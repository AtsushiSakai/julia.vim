"=============================================================================
" File: julia.vim
" Author: AtsushiSakai
"=============================================================================

scriptencoding utf-8

if exists('g:loaded_juliavim')
    finish
endif
let g:loaded_juliavim = 1

let s:save_cpo = &cpo
set cpo&vim

function! s:finish_julia_lint(job) abort
    echo "Julia Lint is done"
    let inputfile = "test"
    let errors = []
    if !exists('g:julia_lint_ignores')
        let g:julia_lint_ignores = []
    endif
    for l in readfile(inputfile)

		let fignore = 0
        for ig in g:julia_lint_ignores
            if stridx(l, ig) != -1
				let fignore = 1
			endif
        endfor
        if fignore == 1
			continue
		endif

        let word1 = split(l, ":")
        let info = {'filename': word1[0]}
        let info.lnum = split(word1[1], " ")[0]
        let info.text = join(split(l," ")[1:-1], " ")
        let word4 = split(l," ")[1]
        let info.nr = word4[1:-1]
        let info.type = word4[0]
        call add(errors, info)
        unlet info
    endfor
    call setqflist(errors, 'r')
    cwindow
    call delete("test")
endfunction

function! s:JuliaLint()
    let filepath = expand('%:p')
    if stridx(filepath, '.jl') == -1
        echo "This is not julia code"
        return
    endif

    echo "Julia Lint start!!."

    let scriptcmd = "julia -e 'using Lint;r=lintfile(\""
    let scriptcmd = scriptcmd.filepath
    let scriptcmd = scriptcmd."\");for m in r;println(m);end;'"
 
    call setqflist([])
    let s:job = job_start(
    \   ["/bin/sh", "-c", scriptcmd],
    \   {'close_cb': function('s:finish_julia_lint'), 'out_io': "file", 'out_name': "test"})
endfunction

command! JuliaLint :call s:JuliaLint()

let &cpo = s:save_cpo
unlet s:save_cpo
