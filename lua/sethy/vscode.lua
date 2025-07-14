-- VSCode-specific Neovim configuration
local vscode = require("vscode")

-- File operations
vim.keymap.set("n", "<leader>ff", function()
	vscode.action("workbench.action.quickOpen")
end, { desc = "Quick Open" })

vim.keymap.set("n", "<leader>fs", function()
	vscode.action("workbench.action.findInFiles")
end, { desc = "Find in Files" })

vim.keymap.set("n", "<leader>e", function()
	vscode.action("workbench.view.explorer")
end, { desc = "Toggle Explorer" })

-- Format document
vim.keymap.set("n", "<leader>f", function()
	vscode.action("editor.action.formatDocument")
end, { desc = "Format Document" })

vim.keymap.set("v", "<leader>f", function()
	vscode.action("editor.action.formatSelection")
end, { desc = "Format Selection" })

-- Git operations
vim.keymap.set("n", "<leader>gg", function()
	vscode.action("workbench.view.scm")
end, { desc = "Git SCM" })

vim.keymap.set("n", "<leader>gb", function()
	vscode.action("gitlens.toggleFileBlame")
end, { desc = "Toggle Git Blame" })

-- Terminal
vim.keymap.set("n", "<leader>t", function()
	vscode.action("workbench.action.terminal.toggleTerminal")
end, { desc = "Toggle Terminal" })

-- Problems/Diagnostics
vim.keymap.set("n", "<leader>xx", function()
	vscode.action("workbench.actions.view.problems")
end, { desc = "Show Problems" })

-- Debugging
vim.keymap.set("n", "<leader>db", function()
	vscode.action("editor.debug.action.toggleBreakpoint")
end, { desc = "Toggle Breakpoint" })

vim.keymap.set("n", "<leader>dc", function()
	vscode.action("workbench.action.debug.continue")
end, { desc = "Debug Continue" })

-- Comments (use VSCode's comment system)
vim.keymap.set("n", "gc", function()
	vscode.action("editor.action.commentLine")
end, { desc = "Comment Line" })

vim.keymap.set("v", "gc", function()
	vscode.action("editor.action.commentLine")
end, { desc = "Comment Selection" })

-- Disable UI elements VSCode handles
vim.opt.number = false
vim.opt.relativenumber = false
vim.opt.signcolumn = "no"
vim.opt.foldcolumn = "0"
vim.opt.scrolloff = 0
vim.opt.colorcolumn = ""

-- Keep basic editing enhancements
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
