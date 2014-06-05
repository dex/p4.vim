" File: p4.vim
" Author: Dex Chen
" Description: Vim global plugin for p4 support
" Last Modified: April 10, 2014

if exists('g:loadded_p4') || &cp || version < 700
	finish
endif
let g:loadded_p4 = 1

" Global variables
if !exists('g:P4UseTab')
  let g:P4UseTab = 0
endif

let s:save_cpo = &cpo
set cpo&vim

if !hasmapto('<Plug>P4OpenCL')
    map <unique> <F4> <Plug>P4OpenCL
endif
noremap <unique> <script> <Plug>P4OpenCL <SID>OpenCL
noremap <SID>OpenCL :CL<CR>

function! s:ChangeList(...)
    if a:0 == 1
	let id = str2nr(a:1)
	if id
	    call s:P4DoCmd("p4 describe -du ".id, "p4-describe-".id, "diff")
	elseif isdirectory(a:1) || strridx(a:1, '/') == strlen(a:1)-1
	    call s:P4DoCmd("p4 changes ".a:1."...", "p4-changelist")
	else
	    call s:P4DoCmd("p4 filelog ".a:1, "p4-filelog-".a:1)
	endif
    elseif a:0 == 2
	if a:2 < 2
	    echo "Invalid revision number"
	    return
	endif
	let cur=a:1."#".a:2
	let prev=a:1."#".(a:2-1)
	call s:P4DoCmd("p4 diff2 -du ".prev." ".cur, "p4-diff2-".a:1, "diff")
    else
	call s:P4DoCmd("p4 changes ".getcwd()."/...", "p4-changelist")
    endif
endfunction

function! s:P4DoCmd(cmd, name, ...)
    if bufexists(a:name)
	echo "Buffer ".a:name." exists"
	return
    endif
    " Open a split buffer/tab to capture the output of command

    if g:P4UseTab == 1
	    tabe
    else
	    split | enew
    endif
    set buftype=nofile noswapfile filetype=p4 bufhidden=wipe
    let output = system(a:cmd)
    0put=output|$delete|0
    silent noautocmd file `=a:name`
    setlocal nomodifiable nobuflisted

    if a:0 > 0 && !empty(a:1)
	let &ft.=".".a:1
    endif
endfunction

if !exists(":CL")
    command -nargs=* -complete=dir CL :call s:ChangeList(<f-args>)
endif

let &cpo = s:save_cpo
unlet s:save_cpo
