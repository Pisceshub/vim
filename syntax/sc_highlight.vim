
if exists("g:loaded_sc_highlight")
  finish
endif
let g:loaded_sc_highlight = 1

" 配置
let g:sc_highlight_index = 0
let g:sc_current_word_highlight = 1
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
" 初始化词映射表
if !exists('g:sc_word_map')
  let g:sc_word_map = {}
endif
" 自动匹配语法组（用于 string 内高亮）
function! Sc_detect_string_group() abort
  let ft = &filetype
  return get({
  \ 'python': 'pythonString',
  \ 'cpp': 'cppString',
  \ 'c': 'cString',
  \ 'javascript': 'javaScriptString',
  \ 'java': 'javaString',
  \ 'lua': 'luaString',
  \ }, ft, '')
endfunction

" 主命令：Sc <word> [index] [exact|fuzzy]
function! Sc(word, ...) abort
  let word = a:word
  let esc_word = escape(word, '/\')

  " === 1. 如果已经高亮，就取消它 ===
  if has_key(g:sc_word_map, word)
    let group = g:sc_word_map[word]
    if hlexists(group)
      execute 'syntax clear ' . group
    endif
    unlet g:sc_word_map[word]
    return
  endif

  " === 2. 否则继续执行高亮 ===
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

  if matchtype ==# 'exact'
    let pattern = '\V\<'.esc_word.'\>'
  else
    let pattern = '\V' . esc_word
  endif

  if hlexists(group)
    execute 'syntax clear ' . group
  endif

  execute 'syntax match ' . group . ' /' . pattern . '/ containedin=ALL'
  execute 'highlight ' . group . ' guibg=' . color . ' guifg=black'

  " === 3. 注册词组和颜色组 ===
  let g:sc_word_map[word] = group

  if a:0 == 0 || (a:1 !~ '^\d\+$')
    let g:sc_highlight_index += 1
  endif
endfunction

"function! Sc(word, ...) abort
"  let idx = g:sc_highlight_index
"  let matchtype = 'fuzzy'
"
"  if a:0 >= 1
"    if a:1 =~ '^\d\+$'
"      let idx = str2nr(a:1)
"    elseif a:1 =~? '^\(exact\|fuzzy\)$'
"      let matchtype = a:1
"    endif
"  endif
"
"  if a:0 >= 2 && a:2 =~? '^\(exact\|fuzzy\)$'
"    let matchtype = a:2
"  endif
"
"  let idx = idx % len(g:sc_colors)
"  let color = g:sc_colors[idx][1]
"  let group = 'ScHighlight' . idx
"  let esc_word = escape(a:word, '/\')
"
"  let pattern = matchtype ==# 'exact'
"        \ ? '\V\<'.esc_word.'\>'
"        \ : '\V'.esc_word
"
"  if hlexists(group)
"    execute 'syntax clear ' . group
"  endif
"
"  let string_group = Sc_detect_string_group()
"  "if !empty(string_group)
"  "  execute 'syntax match ' . group . ' /' . pattern . '/ contained containedin=' . string_group
"  "else
"  "  execute 'syntax match ' . group . ' /' . pattern . '/'
"  "endif
"  execute 'syntax match ' . group . ' /' . pattern . '/ containedin=ALL'
"
"
"  execute 'highlight ' . group . ' guibg=' . color . ' guifg=black'
"
"  if a:0 == 0 || (a:1 !~ '^\d\+$')
"    let g:sc_highlight_index += 1
"  endif
"endfunction

" 清除全部高亮
function! ScClear() abort
  for [word, group] in items(g:sc_word_map)
    if hlexists(group)
      silent! execute 'syntax clear ' . group
    endif
  endfor
  let g:sc_word_map = {}
  let g:sc_highlight_index = 0
  silent! execute 'syntax clear ScCurrentWord'
endfunction

"function! ScClear() abort
"  for i in range(0, len(g:sc_colors) - 1)
"    let group = 'ScHighlight' . i
"    silent! execute 'syntax clear ' . group
"  endfor
"  silent! execute 'syntax clear ScCurrentWord'
"  let g:sc_highlight_index = 0
"endfunction

" 自动高亮光标下的词
function! ScHighlightCurrentWord() abort
  if !get(g:, 'sc_current_word_highlight', 1)
    return
  endif

  let word = expand('<cword>')
  let group = 'ScCurrentWord'
  let color = '#ffff99'

  if hlexists(group)
    execute 'syntax clear ' . group
  endif

  if word =~ '^\s*$'
    return
  endif

  let pattern = '\V\<'.escape(word, '/\').'\>'
  execute 'syntax match ' . group . ' /' . pattern . '/'
  execute 'highlight ' . group . ' guibg=' . color . ' guifg=black'
endfunction

function! ScHighlightUnderCursor() abort
  let word = expand('<cword>')
  if word =~ '^\s*$'
    echom "No word under cursor"
    return
  endif
  call Sc(word)
endfunction

" 自定义快捷键：光标停在词上按 Shift-H 进行高亮
nnoremap <silent> <S-F> :call ScHighlightUnderCursor()<CR>

" 自动命令触发光标词高亮
augroup ScCurrentWordHighlight
  autocmd!
  autocmd CursorHold,CursorMoved * call ScHighlightCurrentWord()
augroup END

" 提供命令
command! -nargs=+ Sc call Sc(<f-args>)
command! ScClear call ScClear()

" 推荐设置：加快触发响应
set updatetime=500
syntax enable
