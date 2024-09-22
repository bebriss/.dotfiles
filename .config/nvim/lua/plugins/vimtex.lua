return {
  -- Other plugins here...

  {
    "lervag/vimtex",
    config = function()
      -- VimTeX general settings
      vim.g.vimtex_view_method = "zathura" -- Use Zathura as the PDF viewer
      vim.g.vimtex_compiler_method = "latexmk" -- Use latexmk for compilation

      -- Compiler settings
      vim.g.vimtex_compiler_latexmk = {
        build_dir = "build", -- Output directory for compiled files
        options = {
          "-pdf",
          -- "-shell-escape",
          -- "-verbose",
          -- "-file-line-error",
          -- "-synctex=1",
          -- "-interaction=nonstopmode",
        },
      }

      -- Key mappings for VimTeX
      vim.keymap.set("n", "<leader>ll", "<cmd>VimtexCompile<CR>", { desc = "Compile LaTeX document" })
      vim.keymap.set("n", "<leader>lv", "<cmd>VimtexView<CR>", { desc = "View compiled PDF" })
      vim.keymap.set("n", "<leader>lc", "<cmd>VimtexClean<CR>", { desc = "Clean auxiliary files" })

      -- Additional VimTeX settings (optional)
      vim.g.vimtex_quickfix_mode = 0 -- Disable automatic quickfix window
    end,
  },

  -- Other plugins here...
}
