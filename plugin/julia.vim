"=============================================================================
" File: julia.vim
" Author: AtsushiSakai
"=============================================================================

scriptencoding utf-8

if exists('g:loaded_juliavim')
    finish
endif

let s:save_cpo = &cpo
set cpo&vim

let s:judocstringpath = expand('<sfile>:p:h')."/judocstring.vim"
execute 'source '.fnameescape(s:judocstringpath)

let s:juliafmtpath = expand('<sfile>:p:h')."/juliafmt.vim"
execute 'source '.fnameescape(s:juliafmtpath)

let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_juliavim = 1
