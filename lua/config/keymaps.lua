vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "<leader>l", ":Lazy<CR>", { desc = "Open Lazy.nvim UI" })
vim.keymap.set("n", "<leader>po", ":PeekOpen<CR>", { desc = "Open markdown preview" })
vim.keymap.set("n", "<leader>pc", ":PeekClose<CR>", { desc = "Close markdown preview" })
