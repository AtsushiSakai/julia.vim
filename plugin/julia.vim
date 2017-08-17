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

command! JuliaLint :call JuliaLint()

let &cpo = s:save_cpo
unlet s:save_cpo
