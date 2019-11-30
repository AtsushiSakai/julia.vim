"
" Julia autoformat function
" This command needs JuliaFormatter
"

function! s:finish_julia_fmt(job) abort
	set noconfirm
	" TODO e! shows redefine function error. Why? 
	silent! e! %
  	set confirm
    echo "Julia Lint is done"
endfunction

function! s:JuliaFmt()
    let filepath = expand('%:p')
    if stridx(filepath, '.jl') == -1
        echo "This is not julia code"
        return
    endif

    echo "Julia Format start!!."

    let scriptcmd = "julia -e 'using JuliaFormatter;format(\""
    let scriptcmd = scriptcmd.filepath
    let scriptcmd = scriptcmd."\")'"
    "echo scriptcmd
 
	call setqflist([])
	let s:job = job_start(
	\   ["/bin/sh", "-c", scriptcmd],
	\   {'close_cb': function('s:finish_julia_fmt')})
endfunction

command! JuliaFmt :call s:JuliaFmt()

