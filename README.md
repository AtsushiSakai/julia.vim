# julia.vim

A vim plugin for Julia.

functions:

- Automatic docstring generation.

- Automatic code formatter. 

# Requirements

- [vim v8.x](http://www.vim.org/) for +job

- [Julia](https://julialang.org/)

- [JuliaFormatter.jl](https://github.com/domluna/JuliaFormatter.jl).


# Install

- NeoBundle

> NeoBundle 'AtsushiSakai/julia.vim'

- [vim-plug](https://github.com/junegunn/vim-plug)

> Plug 'AtsushiSakai/julia.vim'

- [Vim packages](http://vimhelp.appspot.com/repeat.txt.html#packages)

> git clone https://github.com/AtsushiSakai/julia.vim.git ~/.vim/pack/plugins/start/julia.vim`

 
# Usage

## Automatic docstring generation

[![asciicast](https://asciinema.org/a/UOw88Y8sbLtu8zppifiWr2JWW.svg)](https://asciinema.org/a/UOw88Y8sbLtu8zppifiWr2JWW)

This fuction is for generating docsting automatically.

- [Documentation · The Julia Language](https://docs.julialang.org/en/v1/manual/documentation/index.html) 

Docstrings for function can be generated currently. 

When you are writing a function in Julia, you put cursor on the function line, and just command:

```
:JuliaDocstring
```

Then, a docsting for the function will be generated. (see the upper movie).


## Asynchronous automatic code format for julia code

This is an asynchronous automatic code formatter using [JuliaFormatter.jl](https://github.com/domluna/JuliaFormatter.jl).

When you are writing Julia code, you just command:

```
:JuliaFmt
```

Then, the auto formatter is running asynchronously. (it is powered by vim +job) 

# License 

MIT

# Author

Atsushi Sakai ([@Atsushi_twi](https://twitter.com/Atsushi_twi))

