local M = {}

M.general = {
  i = {
    ["<C-c>"] = { "<ESC>", "ESC Remap" },
  },

  n = {
    ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "window left" },
    ["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "window right" },
    ["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "window down" },
    ["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "window up" },
    ["<C-d>"] = { "<C-d>zz", "Scroll Down Half-page" },
    ["<C-u>"] = { "<C-u>zz", "Scroll Up Half-page" },
    ["<leader>f"] = { vim.lsp.buf.format, "Auto-format" },
    ["<leader>s"] = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Replace Selection" },
    ["<leader>fx"] = { "<cmd>!chmod +x %<CR>", "Make File Executable", opts = { silent = true } },
  },

  v = {
    ["<s-j>"] = { ":m '>+1<CR>gv=gv", "Move Selection Up" },
    ["<s-k>"] = { ":m '<-2<CR>gv=gv", "Move Selection Down" },
  },
}

return M
