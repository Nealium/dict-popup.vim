vim9script

export def DictPopup(word: string)
  var new_text = systemlist('dict ' .. word)->mapnew((_, v) => v->trim("\<CR>"))

  var winid = popup_atcursor(new_text, {
    padding: [0, 1, 0, 1],
    border: [],
    borderchars: ['─', '│', '─', '│', '┌', '┐', '┘', '└'],
    pos: "botleft",
    mapping: 0,
    filter: (winid, key) => {
      if key == "\<Space>"
        win_execute(winid, "normal! \<C-d>\<C-d>")
        return true
      elseif key == "j"
        win_execute(winid, "normal! \<C-d>")
        return true
      elseif key == "k"
        win_execute(winid, "normal! \<C-u>")
        return true
      elseif key == "g"
        win_execute(winid, "normal! gg")
        return true
      elseif key == "G"
        win_execute(winid, "normal! G")
        return true
      endif

      if key == "c"
        popup_close(winid)
        return true
      endif
      if key == "q"
        popup_close(winid)
        return true
      endif
      if key == "\<TAB>"
        popup_close(winid)
        return true
      endif

      if key == "\<ESC>"
        popup_close(winid)
        return true
      endif
      return true
    }
  })

  setbufvar(winbufnr(winid), '&ft', 'help')
enddef
