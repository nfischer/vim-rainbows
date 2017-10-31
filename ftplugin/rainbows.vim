" TODO(nate): remove this after a few months
if !exists('*maktaba#json#Format')
  echohl WarningMsg
  echom 'google/vim-maktaba is now a required dependency for nfischer/vim-rainbows'
  echohl NONE
  finish
endif

if !exists('g:rainbows#map_prefix')
  " 'go rainbow'
  let g:rainbows#map_prefix = 'gr'
endif

if !exists('rainbows#default_key')
  let g:rainbows#default_key = 'D'
endif

if !exists('g:rainbows#custom_map')
  " DEFAULT
  let g:rainbows#custom_map = {
    \   'r': 'string',
    \   'b': 'int',
    \   'o': 'float',
    \   'w': 'bool',
    \   'g': 'list',
    \   'p': 'dict'
    \ }
endif

setlocal commentstring=//\ %s

function! s:GetType(dict, sub_section, token)
  if has_key(a:dict[a:sub_section], a:token)
    let l:obj = a:dict[a:sub_section][a:token]
    return has_key(l:obj, 'ret') ? l:obj.ret : l:obj.type
  else
    return 'unknown'
  endif
endfunction

function! s:RemoveType(dict, token)
  if has_key(a:dict.selected, a:token)
    unlet a:dict.selected[a:token]
  endif
endfunction

function! s:AddType(dict, token, type)
  if has_key(a:dict.selected, a:token)
    let l:obj = a:dict.selected[a:token]
    if has_key(l:obj, 'ret')
      let l:obj.ret = a:type
    else
      let l:obj.type = a:type
    endif
  elseif has_key(a:dict.inferred, a:token) && has_key(a:dict.inferred[a:token], 'ret')
    let a:dict.selected[a:token] = {
      \   'ret': a:type,
      \   'type': 'fun',
      \   'name': a:token,
      \   'args': a:dict.inferred[a:token].args
      \ }
  else
    let a:dict.selected[a:token] = {'name': a:token, 'type': a:type}
  endif
endfunction

let s:bad_words = [ 'abstract', 'else', 'instanceof', 'super', 'boolean',
\ 'enum', 'int', 'switch', 'break', 'export', 'interface', 'synchronized',
\ 'byte', 'extends', 'let', 'this', 'case', 'false', 'long', 'throw', 'catch',
\ 'final', 'native', 'throws', 'char', 'finally', 'new', 'transient', 'class',
\ 'float', 'null', 'true', 'const', 'for', 'package', 'try', 'continue',
\ 'function', 'private', 'typeof', 'debugger', 'goto', 'protected', 'var',
\ 'default', 'if', 'public', 'void', 'delete', 'implements', 'return',
\ 'volatile', 'do', 'import', 'short', 'while', 'double', 'in', 'static', 'with' ]

function! s:Color(token)
  let l:mychar = nr2char(getchar())
  if index(s:bad_words, a:token) >= 0
    echohl ErrorMsg | echo '`' . a:token . '` is not a colorable token' | echohl NONE
    return
  endif
  if l:mychar ==# ''
    return
  elseif l:mychar ==# g:rainbows#default_key
    call s:RemoveType(s:tokenMap, a:token)
  elseif !has_key(g:rainbows#custom_map, l:mychar)
    echohl ErrorMsg | echo '`' . l:mychar . '` is not a valid char' | echohl NONE
    return
  else
    let l:type_name = g:rainbows#custom_map[l:mychar]
    call s:AddType(s:tokenMap, a:token, l:type_name)
  endif
  call s:MatchKnownTokens()
  set modified
endfunction

function! s:MatchKnownTokens()
  syntax clear
  call g:ColorLiterals()
  for l:token in keys(s:tokenMap.inferred)
    exe "syntax match Rainbow" . s:GetType(s:tokenMap, 'inferred', l:token) . " '\\V\\<" . l:token . "\\>'"
  endfor
  for l:token in keys(s:tokenMap.selected)
    exe "syntax match Rainbow" . s:GetType(s:tokenMap, 'selected', l:token) . " '\\V\\<" . l:token . "\\>'"
  endfor
endfunction

" visual and normal mode (and operator pending)
exe "noremap <buffer> <silent> " . g:rainbows#map_prefix . " :<C-u>call <SID>Color('<C-R><C-W>')<CR>"

function! s:LoadTypeDictWrapper(job_id, data, event) abort
  call s:LoadTypeDict()
endfunction

function! s:LoadTypeDict()
  let l:type_file_name = expand('%:p') . 't'
  let l:json_str = join(readfile(l:type_file_name), '\n')
  let s:tokenMap = maktaba#json#Parse(l:json_str)
  call s:MatchKnownTokens()
endfunction

function! s:SaveTypeDict()
  let l:type_file_name = expand('%:p') . 't'
  let l:json_str = maktaba#json#Format(s:tokenMap)
  call writefile(split(l:json_str, '\n'), l:type_file_name)
  if exists('g:rainbows#inferencer_path')
    if has('nvim') " The future is here, and it's beautiful
      call jobstart(['node', g:rainbows#inferencer_path, expand('%:p')],
          \ {'on_exit': function('s:LoadTypeDictWrapper')})
    else
      echo 'Synchronously loading inferred types...'
      call system('node ' . g:rainbows#inferencer_path . ' ' . expand('%:p'))
      call s:LoadTypeDict()
    endif
  endif
endfunction

augroup RainbowFileStuff
  au!
  au BufEnter *.rain call s:LoadTypeDict()
  au BufWritePost *.rain call s:SaveTypeDict()
augroup END
