
function! <SID>_MangleName (name)
    let id = substitute(a:name, "[.-/\]", "_", "g")
    let id = toupper(id)
    let id = "_" . id . "_"
    return id
endfunction

function! <SID>AddHeaderIfDef (ask) 
    let path = bufname("%")
    let path = fnamemodify(path, ":p")
    let name = fnamemodify(path, ":t")
    let path = fnamemodify(path, ":h")
    let id = <SID>_MangleName(name)
    while 1
        if a:ask
            let choice = confirm("Proposed #ifdef name is:\n\t" . id, "&Accept\nadd &Directory\nedit &Manually")
            if choice == 0
                return
            elseif choice == 1
                break
            elseif choice == 2
                if fnamemodify(path, ":t") != ""
                    let name = fnamemodify(path, ":t") . "/" . name
                    let path = fnamemodify(path, ":h")
                    let id = <SID>_MangleName(name)
                endif
            elseif choice == 3
                let id = input("Enter #ifdef variable name: ", id)
                if id == ""
                    return
                else
                    break
                endif
            endif
        else
            break
        endif
    endwhile
    call append(0, "#ifndef " . id)
    call append(1, "#define " . id)
    call append(2, "")
    call append("$", "")
    call append("$", "#endif /* !" . id . "*/")
endfunction

command! AddHeaderIfDef call <SID>AddHeaderIfDef(0)
command! AddHeaderIfDefEx call <SID>AddHeaderIfDef(1)

map <Leader>d :<C-U>AddHeaderIfDef<CR>
map <Leader>D :<C-U>AddHeaderIfDefEx<CR>

