# julia.vim

A vim plugin for Julia.

 

functions:

- Asynchronous lint checker. 

# Requirements

- [vim v8.x](http://www.vim.org/) for +job

- [Julia](https://julialang.org/)

- [Lint.jl](https://github.com/tonyhffong/Lint.jl)

 

# Install

- NeoBundle

> NeoBundle 'AtsushiSakai/julia.vim'

- [vim-plug](https://github.com/junegunn/vim-plug)

> Plug 'AtsushiSakai/julia.vim'

- [Vim packages](http://vimhelp.appspot.com/repeat.txt.html#packages)

> git clone https://github.com/AtsushiSakai/julia.vim.git ~/.vim/pack/plugins/start/julia.vim`

 
# Usage

## Asynchronous lint checker for julia code

![gif1](https://github.com/AtsushiSakai/julia.vim/blob/master/images/JuliaLint.gif)

This is an asynchronous lint check function using [Lint.jl](https://github.com/tonyhffong/Lint.jl).

When you are writing Julia code, you just command:

```
:JuliaLint
```

Then, the Lint checker is running asynchronously. (it is powered by vim +job) 

The result of lint check will be shown in quickfix of vim.

You can jump to the corresponding code with quickfix.


### Ignore error / warning codes

If you want to ignore some error or warning codes,

you can set like this in vimrc:

```
let g:julia_lint_ignores = ["E321","W320"]
```

# License 

MIT

# Author

Atsushi Sakai ([@Atsushi_twi](https://twitter.com/Atsushi_twi))


