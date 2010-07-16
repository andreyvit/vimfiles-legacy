
" Purpose:      Allows you to quickly switch between .h/.c, .h/.cpp, .ads/.adb
" Maintainer:   Andrey Tarantsov <andreyvit@gmail.com>
" Copyright:    Free Software Foundation
" Version:      1.0a   (released on      .2005)
" 
" License:
"    this file should be considered in public domain; it is provided "AS IS",
"    without warranty of any kind
"
" Usage:
"    By default maps <F8> to do the job; you may change this (see the end of
"    file).
"
"    If no alternate file is found, asks for the file name to create. Press
"    ESC to cancel if you want.
"
"    In the present state, handles C/C++/Ada files, but can be easily modified
"    to handle more.
"
" Installation:
"    Just put this file in your "Plugin" directory or load it manually via
"    "source" Vim command.
"
" Status:
"    Seems to be stable; many more kinds of file are to be added (probably).
"
" Changes:
"    2005-05-22      1st public release
"    2005-05-30      added bangs after "fun" commands

fun! <SID>FindVariants(base, list)
    let list = a:list
    let other = a:base . "."
    while list != ""
        let ext = "." . fnamemodify(list, ":t")
        let other = a:base . ext
        let list = fnamemodify(list, ":h")
        if filereadable(other)
            break
        endif
    endwhile
    if ! filereadable(other)
        let other = input("Create a NEW file named: ", other)
        if other == ""
            return
        endif
    endif
    exec "edit " . other
endfun

fun! <SID>FindOther()
    let fn = expand ("%")
    let base = fnamemodify(fn, ":r")
    let ext = fnamemodify(fn, ":e")

    " NOTE: to add more file types, just add new "elseif" entries like below.
    " If there are several possible alternate extensions for a given file,
    " separate them with "/" when calling FindVariants. The first extension
    " specified is the default to create if no alternate files exist.

    " NOTE: C++ and C headers are treated separately, because they have
    " different defaults
    if ext ==? "h"
        call <SID>FindVariants(base, "c/C/cpp/cc")
    elseif ext ==? "hpp" || ext ==? "hxx"
        call <SID>FindVariants(base, "cc/cpp/C")
    elseif ext ==? "h_inc"
        call <SID>FindVariants(base, "cc_inc/cpp_inc/C_inc")
    elseif ext ==? "c" || ext ==? "C" || ext ==? "cc" || ext ==? "cpp"
        call <sid>FindVariants(base, "h/hpp/hxx")
    elseif ext ==? "c_inc" || ext ==? "cc_inc" || ext ==? "cpp_inc"
        call <sid>FindVariants(base, "h_inc/h/hpp/hxx")
    elseif ext ==? "ads"
        call <SID>FindVariants(base, "adb")
    elseif ext ==? "adb"
        call <SID>FindVariants(base, "ads")
    else
        call <SID>FindVariants(base, "")
    endif
endfun

noremap <Plug>OtherFile :<C-U>call <SID>FindOther()<CR>
map <F8> <Plug>OtherFile

