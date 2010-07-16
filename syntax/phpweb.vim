
runtime syntax/html.vim
unlet b:current_syntax

syn include @php syntax/php.vim

syn cluster phpInline contains=phpIdentifier,phpSpecialChar,phpIdentifierSimply,phpIdentifierComplex

syn region webDocRef start="\[\[" end="]]" contains=@phpInline keepend

syn region webChunk matchgroup=webChunkHeader start="^<<.\{-}>>=" end="^@" contains=@phpClTop,webChunkRef keepend fold

syn region webChunkRef matchgroup=webChunkRefDelim start="<<" end=">>" contains=@htmlTop contained keepend

hi link webChunkHeader Operator
hi link webChunkRef Operator
hi link webChunkRefDelim Operator
hi link webDocRef String

