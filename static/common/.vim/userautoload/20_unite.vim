NeoBundleLazy 'Shougo/unite.vim', {
    \   'autoload': {
    \     'commands': [
    \       'Unite',
    \       'UniteWithBufferDir',
    \       'UniteWithCurrentDir',
    \       'UniteWithProjectDir',
    \     ],
    \   },
    \ }
NeoBundle 'Shougo/neomru.vim'

let s:bundle = neobundle#get('unite.vim')
let g:unite_data_directory = s:init_temporary_directory . "/unite"
function! s:bundle.hooks.on_source(bundle)
  " Write configurations for Unite here

endfunction