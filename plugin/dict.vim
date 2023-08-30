if !has('vim9script') ||  v:version < 900 || exists('g:loaded_dict_popup')
  " Needs Vim version 9.0 and above
    finish
endif
vim9script

g:loaded_dict_popup = 1

import autoload 'dict.vim'

nnoremap <Plug>(dict_popup) <scriptcmd>dict.DictAtCursorPopup(expand("<cfile>"))<CR>
xnoremap <Plug>(dict_popup) y<scriptcmd>dict.DictAtCursorPopup(getreg('"'))<CR>

command -nargs=1 Dict call dict.DictCenterPopup(<f-args>)
