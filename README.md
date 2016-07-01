# vim-rainbows

Vim runtime files for my own language,
[Rainbows](https://github.com/nfischer/rainbows-lang).

> The power of vim meets the power of the rainbow

## Installation

Using [vim-plug](https://github.com/junegunn/vim-plug):

```viml
Plug 'mattn/webapi-vim' " This is a dependency
Plug 'nfischer/vim-rainbows'
```

Using [vundle](https://github.com/VundleVim/Vundle.vim):

```viml
Plugin 'mattn/webapi-vim' " This is a dependency
Plugin 'nfischer/vim-rainbows'
```

Or, check out
[vim-addon-manager](https://github.com/MarcWeber/vim-addon-manager), which
should resolve the dependencies for you.

## How do I use it?

Rainbows is all about coding in color! Now you can do that, all from within vim!

To get started, visit the [live demo](https://nfischer.github.io/rainbows-lang)
and download the files (this should be a `.rain` and `.raint` file).

Next, open up the `.rain` file and start hacking away!

## What does this do for me?

 - type coloring: just like the live coding environment, this will color your
   identifiers and literals based on what type they are.
 - type inference: if you have the type inferencer installed (see below), then
   this will automatically run that after each save.
 - custom coloring: don't like what types the inferencer chose? Just custom
   color the identifiers with a few key presses (see below). Changes will
   persist between vim sessions!

Here are the allowed commands, which should all be entered in normal
mode on top of the token you want to paint

| key map | color/type        |
|:-------:|:-----------------:|
| `grr`   | red/string        |
| `grb`   | blue/int          |
| `gro`   | orange/float      |
| `grw`   | white/bool        |
| `grg`   | green/list        |
| `grp`   | purple/dict       |
| `grD`   | reset to default  |

## But wait, there's more!

### Want this to do type inference?

If you have [Rainbows](https://github.com/nfischer/rainbows-lang) installed, you
can specify the path to the type inferencer, and it'll run after every save:

```viml
" In .vimrc
let g:rainbows#inferencer_path = '/path/to/rainbows/bin/rain-infer.js'
```

### Want the inferencer to run in the background?

Try out [neovim](https://github.com/neovim/neovim)

### Don't like the default colors in commandline vim?

Try it out in `gvim` to get my favorite shade of Rainbows colors! **Cool!**
:sunglasses:

## Customization

 * Invoke commands with `Rr`, `Rb`, `Ro`, etc.
  ```viml
  let g:rainbows#map_prefix = 'R'
  ```
 * Reset the default color with the mapping `grC` instead
  ```viml
  let g:rainbows#default_key = 'C'
  ```
 * Change the key/color mapping to something that's easier for you
  ```viml
  let g:rainbows#custom_map = {
    \   's': 'string',
    \   'i': 'int',
    \   'f': 'float',
    \   'b': 'bool',
    \   'l': 'list',
    \   'd': 'dict'
    \ }
  ```
 * Run the type inferencer after every save
  ```viml
  let g:rainbows#inferencer_path = '/path/to/rainbows/bin/rain-infer.js'
  ```

## Coming soon...

 - [x] Async support for neovim users (so we can run the inferencer in the
   background, then update the UI when it's done)
 - [ ] Unit tests... yeah right

## Want something more?

Let me know! Either post an issue, or send a PR my way. This is still super
experimental, and very closely tied to the language itself, so anything is up
for grabs.
