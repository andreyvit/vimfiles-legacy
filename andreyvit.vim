
set nocompatible

set showmatch
set matchtime=5
set formatoptions=croqlan
set textwidth=90
set expandtab
set linebreak
set nrformats=hex,alpha
set tags=./tags,./../tags,./*/tags
set hidden
set statusline=2
set updatetime=500
set guifont=Oz18x08win:h14:cOEM
set guioptions=agtR

set backspace=indent,eol,start
set nobackup
set history=50
set ruler
set showcmd
set incsearch

set autoread
set autowrite

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

syntax enable
set hlsearch

filetype plugin indent on

augroup vimrcEx
au!

" For all text files set 'textwidth' to 78 characters.
" autocmd FileType text setlocal textwidth=78

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal g`\"" |
\ endif

augroup END

map <F2> :update<CR>
imap <F2> <C-O>:update<CR>
map <F9> <F2>:make<CR>
imap <F9> <C-C><F2><F9>a

set ts=4
set sw=4
set ai
set wildmenu
set previewheight=3

runtime macros/matchit.vim

map <C-Left> 10h
map <C-Right> 10l
map <C-Up> 10k
map <C-Down> 10j

"" use "<C-R>%" instead
" imap <C-f> <C-r>=expand("%")<CR>

fun! <SID>AddAtNs()
    call append (0, "namespace at {")
    call append ("$", "}")
endfun

map <Leader>N :<C-U>call <SID>AddAtNs()<CR>

" Some cool bindings
map <F10> :<C-U>qa<CR>

" Eclipse-style bindings
map <C-CR> o
map <S-CR> O
imap <C-CR> <C-O>o
imap <S-CR> <C-O>O

" paragraph movement
map <C-Up> {
map <C-Down> }

" word/WORD movement
map <C-Left> b
map <C-Right> w
map <C-S-Left> B
map <C-S-Right> W

" speed movement
map <S-Up> 10k
map <S-Down> 10j
map <S-Left> 10h
map <S-Right> 10l

" previous movement bindings for insert mode
imap <C-Up> <C-O><C-Up>
imap <C-Down> <C-O><C-Down>
imap <C-Left> <C-O><C-Left>
imap <C-Right> <C-O><C-Right>
imap <C-S-Left> <C-O><C-S-Left>
imap <C-S-Right> <C-O><C-S-Right>
imap <S-Up> <C-O><S-Up>
imap <S-Down> <C-O><S-Down>
imap <S-Left> <C-O><S-Left>
imap <S-Right> <C-O><S-Right>

map ,p "0p
map ,P "0P

"" this is deprecated, really
map <Leader>n a<C-R>%<CR>

" Insert a C box comment (try it: open a new line, type some text and press \c). Make sure
" you have &textwidth set to some reasonable value (e.g. 90 or 80). Corrupts @a.
map <Leader>c V100<:let b:fo=&fo<CR>:set fo=<CR>:s/./& /g<CR>:noh<CR>:center<CR>0"ad$O<C-O>0/:exec "normal ".(&tw-1)."a*"<CR>o<C-O>0<C-O>d$ *:exec "normal ".(&tw-3)."A "<CR>A*yy2pjo<C-O>0<C-O>d$ :exec "normal ".(&tw-1)."A*"<CR>A/2k^li<INS><C-R>a:let &fo=b:fo<CR>

"" This was a previous variation, which did not use &textwidth
" map <Leader>c :s/./& /g<CR>:noh<CR>:center 90<CR>0"ad$O<C-O>0/89a*o
" <C-O>0<C-O>d$ *87A A*yy2pjo<C-O>0<C-O>d$ 89A*A/2k^li<INS><C-R>a

" global reindentation
map g= m`gg=G``

command! MixedToUnderscored call <SID>MixedToUnderscored()

fun! <SID>MixedToUnderscored ()
    %s/\<\@!\([a-z]\)\([A-Z]\)/\1_\L\2/ge
    %s/\<[A-Z][a-z]/\L&/ge
    noh
endfun


" presentation options

colorscheme koehler

" set lines=55 columns=157
" au GUIEnter * winpos 0 0
" au GUIEnter * set lines=60 columns=160

set linespace=0

map <F4> :<C-U>cn<CR>

exec "command! ReloadVimrc source " . expand("<sfile>")
exec "command! EditVimrc edit " . expand("<sfile>")

map <F6> :<C-U>set hlsearch!<CR>
set nohlsearch

set path=.,,.;,./**1,../**1

fun! KillImportH ()
    let n=bufname("")
    e import.h
    %s/<.*\\\([^\\]*\)>/<\1>/
    normal ggVG"ay
    exec "e " . n
    normal gg
    /import.h
    normal dd"aP
    update
    qa!
endfun

hi Statement gui=NONE,underline
hi Type gui=NONE,underline

fun! <SID>Preprint ()
    colorscheme koehler
    hi Comment gui=italic
    hi Preproc gui=bold
    "hi Identifier gui=bold
    hi phpDefine gui=bold
    hi Operator gui=NONE
    hi phpMemberSelector gui=NONE
    "TOhtml
endfun

fun! <SID>PreprintDuplex ()
    call <SID>Preprint()
    set printfont=Courier_New:h10
endfun

fun! <SID>Prehtml ()
    colorscheme koehler
    hi Comment gui=italic guifg=NONE
    hi Constant guifg=NONE
    hi Special guifg=NONE
    hi Identifier guifg=NONE
    hi Statement guifg=NONE
    hi Preproc gui=bold guifg=NONE
    hi Type guifg=NONE
    hi Underlined guifg=NONE
    TOhtml
endfun

command! Preprint call <SID>Preprint ()
command! PreprintDuplex call <SID>PreprintDuplex ()
command! Htmlize call <SID>Prehtml ()

set printfont=Courier_New:h8
set printoptions=left:5mm,right:5mm,top:10mm,bottom:15mm



" from vimtip #928
" nmap : q:i
" nmap / q/i
" nmap ? q?i
" (in fact, I don't much like them)

