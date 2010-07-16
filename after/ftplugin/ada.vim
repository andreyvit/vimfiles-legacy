
set sw=3 ts=3 et

fun! <SID>AdaMenu()
    let opt = confirm("What do you want?", "gnat&stub\ngnatmake -gnat&c\ngnat&make")
    let cmd = ""
    if opt == 1
        exec "!gnatstub " . expand("%")
    elseif opt == 2
        exec "!gnatmake -gnatc " . expand("%")
    elseif opt == 3
        exec "!gnatmake " . expand("%")
    endif
    if cmd != ""
        let outp = system(cmd)
        enew
        call append ("$", "The output of " . cmd)
        call append ("$", "")
        call append ("$", substitute(outp, nr2char(10), "\n", "g"))
    endif
endfun

command! AdaMenu call <SID>AdaMenu()
map <TAB> :AdaMenu<CR>

set makeprg=gnatmake\ %
map <F9> :<C-U>make<CR>
