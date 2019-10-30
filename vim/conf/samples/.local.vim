" Settings for vim in current directory

let g:cppclean_path_list = ["-i=/home/kromanow/<path>1"]
let g:cppclean_path_list += ["-i=/home/kromanow/<path>2"]

let g:syntastic_cpp_cppclean_args = join(g:cppclean_path_list, ' ')
