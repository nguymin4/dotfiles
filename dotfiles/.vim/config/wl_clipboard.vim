vim9script


def WLPaste(pasteCmd: string)
    setreg("@", system('wl-paste --no-newline')->substitute('', '', 'g'))
    exe 'normal! ""' .. pasteCmd
enddef


autocmd TextYankPost * if (v:event.operator == 'y' || v:event.operator == 'd') | silent! execute 'call system("wl-copy", @")' | endif
xnoremap p <ScriptCmd>WLPaste("p")<CR>
xnoremap P <ScriptCmd>WLPaste("P")<CR>
nnoremap p <ScriptCmd>WLPaste("p")<CR>
nnoremap P <ScriptCmd>WLPaste("P")<CR>
inoremap <C-r>+ <ScriptCmd>WLPaste("p")<CR><Cmd>normal! `]<CR><Right>
