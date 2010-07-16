
fun! <SID>Rename()
    let oldn = expand("%")
    if ! filereadable(oldn)
        echo "Cannot rename -- file not readable: " . oldn
        return
    endif
    let newn = input("Enter the new name: ", oldn)
    if newn == ""
        return
    endif
    exec "file " . newn
    exec "write"
    if filereadable(newn)
        call delete(oldn)
    else
        echo "Probably writing failed -- file not readable: " . newn
        echo "Will NOT delete the old file, do it yourself if you need: " . oldn
    endif
endfun

command! Rename call <SID>Rename()
