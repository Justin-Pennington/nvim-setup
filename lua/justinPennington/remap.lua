vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)


vim.keymap.set("n", "<leader>q","<cmd>lua vim.diagnostic.open_float()<CR>")
vim.keymap.set("n", "<leader>bd","<cmd>:%bd|e#<CR>")
