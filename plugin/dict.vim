if !has('vim9script') ||  v:version < 900 || exists('g:loaded_dict_popup')
  " Needs Vim version 9.0 and above
    finish
endif
vim9script

g:loaded_dict_popup = 1

import autoload 'dict.vim'

nnoremap <Plug>(DictPopup) <scriptcmd>dict.DictPopup(expand("<cfile>"))<CR>
xnoremap <Plug>(DictPopup) y<scriptcmd>dict.DictPopup(getreg('"'))<CR>
