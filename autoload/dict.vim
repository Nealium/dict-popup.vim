if !has('vim9script') ||  v:version < 900
  " Needs Vim version 9.0 and above
    finish
endif
vim9script

def DictPopupConfig(): dict<any>
  return {
    'padding': [0, 1, 0, 1],
    'border': [],
    'borderchars': ['─', '│', '─', '│', '┌', '┐', '┘', '└'],
    'mapping': 0,
    'filter': (winid, key) => {
      if key == "\<Space>"
        win_execute(winid, "normal! \<C-d>\<C-d>")
      elseif key == 'j'
        win_execute(winid, "normal! \<C-d>")
      elseif key == 'k'
        win_execute(winid, "normal! \<C-u>")
      elseif key == 'g'
        win_execute(winid, "normal! gg")
      elseif key == 'G'
        win_execute(winid, "normal! G")
      elseif index(['c', 'q', "\<TAB>", "\<ESC>"], key) != -1
        popup_close(winid)
      endif
      return true
    }
  }
enddef

export def DictAtCursorPopup(word: string)
  var contents = systemlist('dict ' .. word)->mapnew((_, v) => v->trim("\<CR>"))
  var winid = popup_atcursor(contents, DictPopupConfig())
  setbufvar(winbufnr(winid), '&ft', 'dict')
enddef

export def DictCenterPopup(word: string)
  var lines = systemlist('dict ' .. word)
  var contents = lines->mapnew((_, v) => v->trim("\<CR>"))

  var config = DictPopupConfig()
  config['line'] = &lines - &cmdheight - 1
  config['maxheight'] = &lines - 8

  # If it can be reasonably mitigated, extend the popup's width so the
  #   content is NOT wrapped
  var longest_line = 0
  for line in lines
    var line_length = strlen(line)
    if line_length > longest_line
      longest_line = line_length
    endif
  endfor
  if longest_line < &columns - 2
    config['minwidth'] = longest_line
  endif

  var winid = popup_create(contents, config)
  setbufvar(winbufnr(winid), '&ft', 'dict')
enddef
