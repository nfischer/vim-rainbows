# vim-rainbows

Vim runtime files for my own language,
[Rainbows](https://github.com/nfischer/rainbows-lang).

> All the power of the rainbow, brought right to vim

## Installation

```viml
Plugin 'mattn/webapi-vim' " This is a dependency
Plugin 'nfischer/vim-rainbows'
```

## How do I use it?

Rainbows is all about coding in color! Now you can do that, all from within vim!

To get started, visit the [live Rainbows
demo](https://nfischer.github.io/rainbows-lang) and download the files (should be a
`.rain` and `.raint`) file.

Next, open up the `.rain` file and start hacking away!

## What does this do for me?

Literal values will be highlighted by default. Try typing `12`, `12.1`, `"foo"`,
and other literal values right out of the box in any `.rain` file!

Also, if you have a `.raint` file, then inferred identifiers will also work. So
if you ever see `var foo = 12`, then both the `12` and `foo` will be blue

Now you can start custom-coloring variables to get different behavior!

 * Type out `grb` to paint an identifier blue. If you save your file and reopen
   it, the change will persist!
 * Try `grr` to paint the same identifier red now!
 * Use `grD` to go back to the default coloring

In general, here are the allowed commands, which should all be entered in normal
mode on top of the token you want to paint

| command | color/type        |
|:-------:|:-----------------:|
| `grr`   | red/string        |
| `grb`   | blue/int          |
| `gro`   | orange/float      |
| `grw`   | white/bool        |
| `grg`   | green/list        |
| `grp`   | purple/dict       |
| `grD`   | reset to default  |

## But wait, there's more!

### Annoyed this doesn't do type inference for you?

If you have [Rainbows](https://github.com/nfischer/rainbows-lang) installed, you can
specify the path to the type inferencer, and it'll run after every save:

```viml
" In .vimrc
let g:rainbows#inferencer_path = '/path/to/rainbows/bin/rain-infer.js'
```

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

 * Async support for neovim users (so we can run the inferencer in the
   background, then update the UI when it's done)
 * Async support for neovim users (so we can run the inferencer in the
   background, then update the UI when it's done)
 * Unit tests... yeah right

## Want something more?

Let me know! Either post an issue, or send a PR my way. This is still super
experimental, and very closely tied to the language itself, so anything is up
for grabs.
