"=============================================================================
" File: julia.vim
" Author: AtsushiSakai
"=============================================================================

scriptencoding utf-8

if !exists('g:loaded_juliavim')
    finish
endif
let g:loaded_juliavim = 1

" Magic word
let s:save_cpo = &cpo
set cpo&vim

" Magic word
let &cpo = s:save_cpo
unlet s:save_cpo
