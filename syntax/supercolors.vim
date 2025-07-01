
if exists("g:loaded_sc_highlight")
  finish
endif
let g:loaded_sc_highlight = 1

" 高亮颜色定义
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

" 词映射表
if !exists('g:sc_word_map')
  let g:sc_word_map = {}
endif

" 定义语法 cluster，仅一次
if !exists('g:sc_syntax_cluster_defined')
  let s:clusters = []
  for i in range(len(g:sc_colors))
    call add(s:clusters, 'ScHL' . i)
  endfor
  execute 'syntax cluster ScHLGroup contains=' . join(s:clusters, ',')
  let g:sc_syntax_cluster_defined = 1
endif

" 主函数：Sc(word [, index] [, exact|fuzzy])
function! Sc(word, ...) abort
  let word = a:word
  let esc_word = escape(word, '/\')

  " 如果已存在，取消高亮
  if has_key(g:sc_word_map, word)
    let group = g:sc_word_map[word]
    if hlexists(group)
      execute 'syntax clear ' . group
    endif
    call remove(g:sc_word_map, word)
    return
  endif

  " 解析参数
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
  let group = 'ScHL' . idx

  let pattern = matchtype ==# 'exact' ? '\V\<'.esc_word.'\>' : '\V'.esc_word

  if hlexists(group)
    execute 'syntax clear ' . group
  endif

  execute 'syntax match ' . group . ' /' . pattern . '/ containedin=ALL'
  execute 'highlight default ' . group . ' guibg=' . color . ' guifg=black gui=NONE'

  let g:sc_word_map[word] = group
  let g:sc_highlight_index += 1
endfunction

" 清除全部高亮
function! ScClear() abort
  for [_, group] in items(g:sc_word_map)
    if hlexists(group)
      silent! execute 'syntax clear ' . group
    endif
  endfor
  let g:sc_word_map = {}
  let g:sc_highlight_index = 0
  if hlexists('ScCurrentWord')
    silent! execute 'syntax clear ScCurrentWord'
  endif
endfunction

" 高亮光标下的词（自动模式）
function! ScHighlightCurrentWord() abort
  if !get(g:, 'sc_current_word_highlight', 1)
    return
  endif
  let word = expand('<cword>')
  if word =~# '^\s*$'
    return
  endif
  if hlexists('ScCurrentWord')
    silent! execute 'syntax clear ScCurrentWord'
  endif
  let pattern = '\V\<'.escape(word, '/\').'\>'
  execute 'syntax match ScCurrentWord /' . pattern . '/'
  execute 'highlight default ScCurrentWord guibg=#ffff99 guifg=black gui=NONE'
endfunction

" 视觉模式或光标词高亮
function! ScHighlightVisualOrCursorWord() abort
  let word = ''
  if mode() =~# 'v'
    " 视觉选区获取
    let save_reg = getreg('"')
    let save_type = getregtype('"')
    normal! ""gvy
    let word = substitute(getreg('"'), '\n', '', 'g')
    call setreg('"', save_reg, save_type)
  else
    let word = expand('<cword>')
  endif
  if word =~# '^\s*$'
    echo "No word to highlight"
    return
  endif
  call Sc(word)
endfunction

" 快捷键：<S-H> 视觉/普通模式都支持
nnoremap <silent> <S-H> :call ScHighlightVisualOrCursorWord()<CR>
vnoremap <silent> <S-H> :<C-U>call ScHighlightVisualOrCursorWord()<CR>

" 自动高亮光标词
augroup ScHighlightWord
  autocmd!
  autocmd CursorHold,CursorMoved * call ScHighlightCurrentWord()
augroup END

" 命令接口
command! -nargs=+ Sc call Sc(<f-args>)
command! ScClear call ScClear()

" 推荐设置：更快响应
set updatetime=300
syntax enable
