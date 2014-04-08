syn region p4Entry start="^Change " end="$" oneline contains=ALL
syn match p4ID =\s\<\(CL\)\?\zs\d\+\ze\>\s= contained
syn match p4User =\<[^@ ]\+\ze@= contained
syn match p4UserBuild =\<p4build2\ze@= contained
"syn match p4Path =\<//[^ #]\*\>=

syn region p4RevEntry start=/^.../ end=/$/ oneline contains=ALL
syn match p4Rev =#\d\+= contained
syn match p4Date =\<\d\{4}/\d\{2}/\d\{2}\>= contained

hi def link p4ID Tag
hi def link p4Date Number
hi def link p4User Title
"hi def link p4Path Title
hi def link p4Rev CursorLineNr
