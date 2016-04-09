nnoremap [unite]    <Nop>
nmap     <Space>u [unite]

nnoremap <silent> [unite]c   :<C-u>UniteWithCurrentDir -buffer-name=files buffer file_mru bookmark file<CR>
nnoremap <silent> [unite]b   :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]f_   :<C-u>Unite file<CR>
nnoremap <silent> [unite]fm  :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]d_   :<C-u>Unite directory<CR>
nnoremap <silent> [unite]dm  :<C-u>Unite directory_mru<CR>
