
func! StartPreview ()
	au! CursorHold * nested call PreviewWord()
endfunc

func! <SID>PreviewWord()
  if &previewwindow			" don't do this in the preview window
    return
  endif
  let w = expand("<cword>")		" get the word under cursor
  if w != ""				" if there is one ":ptag" to it

    " Delete any existing highlight before showing another tag
    silent! wincmd P			" jump to preview window
    if &previewwindow			" if we really get there...
      match none			" delete existing highlight
      wincmd p			" back to old window
    endif

    " Try displaying a matching tag for the word under the cursor
    let v:errmsg = ""
    exe "silent! ptag " . w
    if v:errmsg =~ "tag not found"
      return
    endif

    silent! wincmd P			" jump to preview window
    if &previewwindow		" if we really get there...
	 if has("folding")
	   silent! .foldopen		" don't want a closed fold
	 endif
	 call search("$", "b")		" to end of previous line
	 let w = substitute(w, '\\', '\\\\', "")
	 call search('\<\V' . w . '\>')	" position cursor on match
	 " Add a match highlight to the word at this position
      hi previewWord term=bold ctermbg=green guibg=green
	 exe 'match previewWord "\%' . line(".") . 'l\%' . col(".") . 'c\k*"'
      wincmd p			" back to old window
    endif
  endif
endfun

fun! <SID>ClosePreview()
    silent! pclose
endfun

map <Plug>PreviewWord :<C-U>call <SID>PreviewWord()<CR>
map <F1> <Plug>PreviewWord

map <Plug>ClosePreview :<C-U>call <SID>ClosePreview()<CR>
map <S-F1> <Plug>ClosePreview

