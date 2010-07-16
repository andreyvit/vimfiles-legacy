

runtime syntax/xml.vim
unlet b:current_syntax

syn include @cpp syntax/cpp.vim
unlet b:current_syntax

let b:current_syntax="states_xml"

syn cluster xmlCdataHook add=@cpp

hi link xmlCdata NONE


"syn cluster phpInline contains=phpIdentifier,phpSpecialChar,phpIdentifierSimply,phpIdentifierComplex
"syn region webDocRef start="\[\[" end="]]" contains=@phpInline keepend
"syn region webChunk matchgroup=webChunkHeader start="^<<.\{-}>>=" end="^@" contains=@phpClTop,webChunkRef keepend fold
"syn region webChunkRef matchgroup=webChunkRefDelim start="<<" end=">>" contains=@htmlTop contained keepend

"hi link webDocRef String

