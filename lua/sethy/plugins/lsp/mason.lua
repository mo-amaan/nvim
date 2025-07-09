return {
	"williamboman/mason.nvim",
	lazy = false,
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"neovim/nvim-lspconfig",
		-- "saghen/blink.cmp",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local capabilities = cmp_nvim_lsp.default_capabilities()

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			ensure_installed = {
				"lua_ls",
				"html",
				"cssls",
				"tailwindcss",
				"gopls",
				"emmet_ls",
				"emmet_language_server",
				"marksman",
			},
			automatic_installation = true,
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier",
				"stylua",
				"isort",
				"pylint",
				"clangd",
				"denols",
				"djlint",
				"autopep8",
				{ "eslint_d", version = "13.1.2" },
			},
		})

		local servers = {
			"lua_ls",
			"html",
			"cssls",
			"tailwindcss",
			"gopls",
			"emmet_ls",
			"emmet_language_server",
			"denols",
			"marksman",
			"ts_ls",
		}

		for _, server_name in ipairs(servers) do
			local opts = {
				capabilities = capabilities,
			}

			if server_name == "emmet_ls" then
				opts.filetypes = {
					"html",
					"typescriptreact",
					"javascriptreact",
					"css",
					"sass",
					"scss",
					"less",
					"svelte",
				}
			elseif server_name == "lua_ls" then
				opts.settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						completion = {
							callSnippet = "Replace",
						},
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
						},
					},
				}
			elseif server_name == "emmet_language_server" then
				opts.filetypes = {
					"css",
					"eruby",
					"html",
					"javascript",
					"javascriptreact",
					"less",
					"sass",
					"scss",
					"pug",
					"typescriptreact",
				}
				opts.init_options = {
					includeLanguages = {},
					excludeLanguages = {},
					extensionsPath = {},
					preferences = {},
					showAbbreviationSuggestions = true,
					showExpandedAbbreviation = "always",
					showSuggestionsAsSnippets = false,
					syntaxProfiles = {},
					variables = {},
				}
			elseif server_name == "denols" then
				opts.root_dir = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
			elseif server_name == "ts_ls" then
				opts.root_dir = function(fname)
					local util = require("lspconfig.util")
					return not util.root_pattern("deno.json", "deno.jsonc")(fname)
						and util.root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git")(fname)
				end
				opts.single_file_support = false
				opts.init_options = {
					preferences = {
						includeCompletionsWithSnippetText = true,
						includeCompletionsForImportStatements = true,
					},
				}
			end

			lspconfig[server_name].setup(opts)
		end
	end,
}
