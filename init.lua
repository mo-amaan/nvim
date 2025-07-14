-- Check if running in VSCode
if vim.g.vscode then
	-- VSCode-specific configuration
	require("sethy.core.options")
	require("sethy.core.keymaps")
	require("sethy.vscode") -- New VSCode-specific file we'll create
else
	-- Regular Neovim configuration
	require("sethy.core") -- Change to moamaan later
	require("sethy.lazy") -- Change to moamaan later
	require("current-theme")
	require("sethy.terminalpop")
end
