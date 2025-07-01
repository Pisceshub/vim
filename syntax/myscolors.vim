let g:sc_highlight_index = 0
let g:sc_colors = [
  \ ['Red',     '#ff4c4c'],
  \ ['Orange',  '#ff9900'],
  \ ['Gold',    '#ffd700'],
  \ ['Green',   '#32cd32'],
  \ ['Cyan',    '#00ced1'],
  \ ['Blue',    '#1e90ff'],
  \ ['Purple',  '#ba55d3'],
  \ ['Brown',   '#8b4513'],
  \ ['Slate',   '#708090'],
  \ ['Pink',    '#ff69b4'],
\ ]

" optional, not used anymore
function! StripQuotes(str) abort
  if len(a:str) >= 2 && (a:str[0] == '"' || a:str[0] == "'") && a:str[-1] == a:str[0]
    return a:str[1 : -2]
  endif
  return a:str
endfunction

" 自动根据文件类型选择 containedin 的语法组
function! Sc_detect_string_group() abort
  let ft = &filetype
  if ft ==# 'python'
    return 'pythonString'
  elseif ft ==# 'cpp'
    return 'cppString'
  elseif ft ==# 'c'
    return 'cString'
  elseif ft ==# 'javascript'
    return 'javaScriptString'
  elseif ft ==# 'java'
    return 'javaString'
  elseif ft ==# 'lua'
    return 'luaString'
  " 你可以继续添加更多语言支持
  else
    return ''
  endif
endfunction

function! Sc(word, ...) abort
  let idx = g:sc_highlight_index
  let matchtype = 'fuzzy'

  if a:0 >= 1
    if a:1 =~ '^\d\+$'
      let idx = str2nr(a:1)
    elseif a:1 =~? '^\(exact\|fuzzy\)$'
      let matchtype = a:1
    endif
  endif

  if a:0 >= 2 && a:2 =~? '^\(exact\|fuzzy\)$'
    let matchtype = a:2
  endif

  let idx = idx % len(g:sc_colors)
  let color = g:sc_colors[idx][1]
  let group = 'ScHighlight' . idx
  let esc_word = escape(a:word, '/\')

  if matchtype ==# 'exact'
    let pattern = '\V\<'.esc_word.'\>'
  else
    let pattern = '\V' . esc_word
  endif

  " 清理旧语法组（避免重复定义）
  if hlexists(group)
    execute 'syntax clear ' . group
  endif

  " 根据文件类型决定是否加 containedin
  let string_group = Sc_detect_string_group()
  if !empty(string_group)
    execute 'syntax match ' . group . ' /' . pattern . '/ contained containedin=' . string_group
  else
    execute 'syntax match ' . group . ' /' . pattern . '/'
  endif

  execute 'highlight ' . group . ' guibg=' . color . ' guifg=black'
  " ctermfg=0 ctermbf=red'

  if a:0 == 0 || (a:1 !~ '^\d\+$')
    let g:sc_highlight_index += 1
  endif
  "echom '>>> Group: ' . group . ' Pattern: ' . pattern . ' Color: ' . color . ' StringGroup: ' . string_group

endfunction

function! ScClear() abort
  for i in range(0, len(g:sc_colors) - 1)
    let group='ScHighlight' . i
    silent! execute 'syntax clear ' . group
  endfor
  let g:sc_highlight_index = 0
endfunction

command! -nargs=+ Sc call Sc(<f-args>)
command! ScClear call ScClear()
syntax enable

