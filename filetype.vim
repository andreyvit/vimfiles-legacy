
if exists("did_load_filetypes")
    finish
endif

augroup filetypedetect
    au! BufRead,BufNewFile *.php.w      setfiletype phpweb
    au! BufRead,BufNewFile *.h_inc      setfiletype cpp
    au! BufRead,BufNewFile *.cc_inc      setfiletype cpp
    au! BufRead,BufNewFile *.cpp_inc      setfiletype cpp
    au! BufRead,BufNewFile states.xml      setfiletype states_xml
	au! BufRead,BufNewFile *.rhtml		setfiletype eruby
augroup END
