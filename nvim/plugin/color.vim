fun! ColorMyPencils()
    if g:colorscheme == "gruvbox"
        set background=dark
        colorscheme gruvbox

        " hi CursorLineNR guibg=None
        " highlight Normal guibg=none
        highlight LineNr guifg=#ff8659
        highlight LineNr guifg=#aed75f
        highlight LineNr guifg=#5eacd3
        highlight qfFileName guifg=#aed75f
        hi TelescopeBorder guifg=#5eacd
    endif

    if g:colorscheme == "github_*"
        let g:github_function_style = "italic"
        let g:github_sidebars = ["qf", "vista_kind", "terminal", "packer"]

        " Change the "hint" color to the "orange" color, and make the "error" color bright red
        let g:github_colors = {
            \ 'hint': 'orange',
            \ 'error': '#ff0000'
            \ }

        colorscheme github_dimmed
    endif

    if g:colorscheme == "kanagawa"
        colorscheme kanagawa
    endif

    if g:colorscheme == "tokyonight"
        colorscheme tokyonight-moon
    endif 

    if g:colorscheme == "everforest"
        " Important!!
        if has('termguicolors')
          set termguicolors
        endif

        " For dark version.
        set background=dark

        " Set contrast.
        " This configuration option should be placed before `colorscheme everforest`.
        " Available values: 'hard', 'medium'(default), 'soft'
        let g:everforest_background = 'hard'
        let g:everforest_enable_italic = 1

        " For better performance
        let g:everforest_better_performance = 1

        colorscheme everforest
    endif

    " allowing for background transparency
    " hi Normal guibg=NONE ctermbg=NONE
endfun
call ColorMyPencils()

" Vim with me
nnoremap <leader>cmp :call ColorMyPencils()<CR>
nnoremap <leader>vwb :let g:colorscheme =
