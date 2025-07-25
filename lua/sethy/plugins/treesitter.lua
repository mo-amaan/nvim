return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		config = function()
			-- import nvim-treesitter plugin
			local treesitter = require("nvim-treesitter.configs")

			-- configure treesitter
			treesitter.setup({ -- enable syntax highlighting
				highlight = {
					enable = true,
				},
				-- enable indentation
				indent = { enable = true },

				-- ensure these languages parsers are installed
				ensure_installed = {
					"json",
					"javascript",
					"typescript",
					"tsx",
					"go",
					"yaml",
					"html",
					"css",
					"python",
					"http",
					"prisma",
					"markdown",
					"markdown_inline",
					"svelte",
					"graphql",
					"bash",
					"lua",
					"vim",
					"dockerfile",
					"gitignore",
					"query",
					"vimdoc",
					"c",
					"java",
					"rust",
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
					},
				},
				additional_vim_regex_highlighting = false,
			})
		end,
	},
	-- NOTE: js,ts,jsx,tsx Auto Close Tags
	{
		"windwp/nvim-ts-autotag",
		ft = { "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte" },
		config = function()
			-- Independent nvim-ts-autotag setup
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true, -- Auto-close tags
					enable_rename = true, -- Auto-rename pairs
					enable_close_on_slash = false, -- Disable auto-close on trailing `</`
				},
				per_filetype = {
					["html"] = {
						enable_close = true, -- Disable auto-closing for HTML
					},
					["typescriptreact"] = {
						enable_close = true, -- Explicitly enable auto-closing (optional, defaults to `true`)
					},
				},
			})
			-- vim.schedule(function()
			-- 	vim.api.nvim_set_hl(0, "@comment", { italic = true })
			-- 	vim.api.nvim_set_hl(0, "@keyword", { italic = true })
			-- 	vim.api.nvim_set_hl(0, "@type", { italic = true })
			-- 	vim.api.nvim_set_hl(0, "@variable.builtin", { italic = true, fg = "#ff5874" }) -- `this`, `self`, etc.
			-- 	vim.api.nvim_set_hl(0, "@function", { bold = true })
			-- 	vim.api.nvim_set_hl(0, "@markup.underline", { underline = true })
			-- 	vim.api.nvim_set_hl(0, "@markup.bold", { bold = true })
			-- 	vim.api.nvim_set_hl(0, "@markup.italic", { italic = true })
			-- 	vim.api.nvim_set_hl(0, "@string.special", { italic = true })
			--
			-- 	-- Exclude italics for some tokens
			-- 	vim.api.nvim_set_hl(0, "@number", { italic = false })
			-- 	vim.api.nvim_set_hl(0, "@operator", { italic = false })
			-- end)
		end,
	},
}
