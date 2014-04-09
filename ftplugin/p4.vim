" File: p4.vim
" Author: Dex Chen
" Description: A test p4 plugin
" Last Modified: April 09, 2014

if exists('b:did_p4_vim') || &cp || version < 700
    finish
endif
let b:did_p4_vim = 1


let s:save_cpo = &cpo
set cpo&vim

nmap <buffer> <unique> o <Plug>P4ChangeListEntry
nmap <buffer> <unique> <CR> <Plug>P4ChangeListEntry
nmap <buffer> <unique> q :q<CR>

noremap <buffer><unique><script> <Plug>P4ChangeListEntry <SID>ChangeListEntry
noremap <buffer><unique> <SID>ChangeListEntry :call <SID>run_cl(fnameescape(split(getline("."))[1]))<CR>

nmap <buffer> <unique> <C-\> <Plug>P4ChangeList
noremap <buffer> <unique> <script> <Plug>P4ChangeList <SID>ChangeList
noremap <buffer> <SID>ChangeList :call <SID>run_cl(fnameescape(expand("<cWORD>")))<CR>

function! s:run_cl(obj)
    execute "silent !cl ". a:obj
    redraw!
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
