" File: p4.vim
" Author: Dex Chen
" Description: A test p4 plugin
" Last Modified: April 09, 2014

if exists('b:did_ftplugin') || &cp || version < 700
    finish
endif
let b:did_ftplugin = 1


let s:save_cpo = &cpo
set cpo&vim

nmap <buffer> <unique> o <Plug>P4ChangeListEntry
nmap <buffer> <unique> <CR> <Plug>P4ChangeListEntry
nmap <buffer> <unique> q :q<CR>

noremap <buffer><unique><script> <Plug>P4ChangeListEntry <SID>ChangeListEntry
noremap <buffer><unique> <SID>ChangeListEntry :call <SID>RunCL(fnameescape(split(getline("."))[1]))<CR>

nmap <buffer> <unique> <C-\> <Plug>P4ChangeList
noremap <buffer> <unique> <script> <Plug>P4ChangeList <SID>ChangeList
noremap <buffer> <SID>ChangeList :call <SID>RunCL(fnameescape(expand("<cWORD>")))<CR>

if !exists("*s:RunCL")
    function! s:RunCL(obj)
	if stridx(a:obj, "\\#") == 0
	    execute "CL ".getline(1)." ".strpart(a:obj, strridx(a:obj, "#")+1)
	else
	    execute "CL ". a:obj
	endif
    endfunction
endif

let &cpo = s:save_cpo
unlet s:save_cpo
