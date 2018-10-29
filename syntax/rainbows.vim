if exists('b:current_syntax')
  finish
endif

" Add types here
let b:type_list = [ 'string', 'int', 'float', 'bool', 'list', 'dict' ]

function! g:ColorLiterals()
  " -------------------------------------------------------------------------
  " Basic things
  " -------------------------------------------------------------------------
  syntax match RainbowNormal '\v.'
  syntax region RainbowComment start='\V//' end='\v$' contains=@Spell

  " -------------------------------------------------------------------------
  " Literals
  " -------------------------------------------------------------------------
  syntax region Rainbowstring start='\V"'  end='\V"'
  syntax region Rainbowstring start='\V\'' end='\V\''
  syntax match  Rainbowint    '\v<\d+(\.)@!>'
  syntax match  Rainbowfloat  '\v<\d+\.\d*'
  syntax match  Rainbowfloat  '\v\d*\.\d+>'
  syntax match  Rainbowbool   '\v<(true|false)>'
  syntax region Rainbowlist   start='\v\[' end='\v\]' keepend
  " syntax region Rainbowdict   start='\v\{' end='\v\}' keepend

  " -------------------------------------------------------------------------
  " Keywords (because these still matter)
  " -------------------------------------------------------------------------
  syntax keyword Rainbowkeyword function if else return var break continue

endfunction
call g:ColorLiterals()

" ---------------------------------------------------------------------------
" Highlighting
" ---------------------------------------------------------------------------

" Emphasize the rainbow!

highlight link RainbowComment Comment

highlight default Rainbowstring cterm=bold  ctermfg=red     gui=bold  guifg=#FF4F4F
highlight default Rainbowint    cterm=bold  ctermfg=blue    gui=bold  guifg=#0084FF
highlight default Rainbowfloat  cterm=bold  ctermfg=yellow  gui=bold  guifg=orange
highlight default Rainbowbool   cterm=bold  ctermfg=white   gui=bold  guifg=#D39BBA
highlight default Rainbowlist   cterm=bold  ctermfg=green   gui=bold  guifg=#00BA00
highlight default Rainbowdict   cterm=bold  ctermfg=magenta gui=bold  guifg=#CE00CE
highlight default RainbowNormal ctermfg=lightgrey guifg=lightgrey
highlight default Rainbowkeyword ctermfg=grey cterm=underline,bold guifg=lightgrey gui=italic

let b:current_syntax = 'rainbows'
