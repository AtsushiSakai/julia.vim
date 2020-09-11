"
" Julia docstring generator
"
" Author: Atsushi Sakai
"
" Ref: Documentation · The Julia Language https://docs.julialang.org/en/v1/manual/documentation/index.html
"

function! s:generate_docstring(input_str)
    "echo a:input_str 
    let ind = stridx(a:input_str, " ")
    let header = a:input_str[0:ind-1]
    let body = a:input_str[ind:]
    echo header
    if header == 'function'
        let rmap = s:parse_function(body)
    else
        echo "Unknown header"+header
    endif

    let docstring = s:generate_docstring_from_map(rmap)
    return docstring
endfunction

function! s:parse_function(body)
    " Parse function code 
    " return example
    "   input: levenberg_marquardt(f, Df, x1, lambda1; kmax=100, tol=1e-6)
    "   output:{'arg_list': ['f', 'Df', 'x1', 'lambda1'], 'opt_arg_list': ['kmax=100', 'tol=1e-6'],
    "         'func_name': 'levenberg_marquardt', 'full_func_name': 'levenberg_marquardt(f,Df,x1,lambda1;kmax=100,tol=1e-6)'}
    "echo a:body
    let rmap = {}
    let tmp = substitute(a:body, " ", "", "g")
    let rmap["full_func_name"] = tmp
    let rmap["func_name"] = tmp[0:stridx(tmp, "(")-1]
    let tmp = tmp[stridx(tmp, "(")+1:]
    let tmp = substitute(tmp, ")", "", "g")
    let args = split(tmp,";")
    if len(args)>=2
        let rmap["arg_list"] = split(args[0],",")
        let rmap["opt_arg_list"] = split(args[1],",")
    elseif len(args)>=1
        let rmap["arg_list"] = split(args[0],",")
    else
        "do nothing
    endif
    "echo rmap
    return rmap
endfunction


function! s:generate_docstring_from_map(rmap)
    "
    " Generate docstring using parsed map data
    "
    " input:
    "       {'arg_list': ['f', 'Df', 'x1', 'lambda1'], 'opt_arg_list': ['kmax=100', 'tol=1e-6'],
    "        'func_name': 'levenberg_marquardt', 'full_func_name': 'levenberg_marquardt(f,Df,x1,lambda1;kmax=100,tol=1e-6)'}
    " output:
    "   \"\"\"
    "       levenberg_marquardt(f,Df,x1,lambda1;kmax=100,tol=1e-6)
    "
    "   description
    "
    "   ...
    "   # Arguments
    "    - `f`: 
    "    - `Df`: 
    "    - `x1`: 
    "    - `lambda1`: 
    "    Optional args:
    "    - `kmax=100`: 
    "    - `tol=1e-6`: 
    "    ...
    "
    "   # Example
    "   ```julia
    "   ```
    "   \"\"\"
    "

    let rstr = "\"\"\"\n"
    let rstr = rstr . "    " . a:rmap["full_func_name"] . "\n\n"
    let rstr = rstr . "description\n\n"

    if has_key(a:rmap, "arg_list")
        let rstr = rstr . "...\n"
        let rstr = rstr . "# Arguments\n"
        for arg in a:rmap["arg_list"]
            let rstr = rstr . "- `".arg."`: \n"
        endfor
        if has_key(a:rmap, "opt_arg_list")
            let rstr = rstr . "Optional args:\n"
            for arg in a:rmap["opt_arg_list"]
                let rstr = rstr . "- `".arg."`: \n"
            endfor
        endif
        let rstr = rstr . "...\n\n"
    endif
    let rstr = rstr . "# Example\n"
    let rstr = rstr . "```julia"
    let rstr = rstr . "```\n"
    let rstr = rstr . "\"\"\""
    "echo rstr
    return rstr
endfunction

function! s:get_function_code()
    let ccol = line(".") 
    let input_str = ""
    while 1
        let line = getline(ccol)
        let input_str = input_str . line
        if stridx(line, ")") != -1
            break
        endif
        let ccol = ccol + 1
    endwhile

    return input_str
endfunction

function! JuliaDocstring()
    "Read function header
    let line = getline(".")
    if stridx(line, "function") != -1
        let input_str = s:get_function_code()
        "echo input_str
        let docstring=s:generate_docstring(input_str)
        "echo docstring
        call append(line(".")-1, split(docstring, "\n"))
    else
        echo "[Error] Cannot find target codes"
    endif
endfunction

command! JuliaDocstring :call JuliaDocstring()

" Test code
"function! s:Test(line)
    "echo a:line
    "let result=s:generate_docstring(a:line)
    "echo result
"endfunction
"call s:Test('function record_movie(flag)')
"call s:Test('function record_movie(flag, x, y)')
"call s:Test('function add(self::ArrayDeque, i::Int64, x)')
"call s:Test('function test()')
"call s:Test('function levenberg_marquardt(f, Df, x1, lambda1; kmax=100, tol=1e-6)')


