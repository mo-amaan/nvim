return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters = {
				-- Keep markdown formatters
				["markdown-toc"] = {
					condition = function(_, ctx)
						for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
							if line:find("<!%-%- toc %-%->") then
								return true
							end
						end
					end,
				},
				["markdownlint-cli2"] = {
					condition = function(_, ctx)
						local diag = vim.tbl_filter(function(d)
							return d.source == "markdownlint"
						end, vim.diagnostic.get(ctx.buf))
						return #diag > 0
					end,
				},
				-- Simplified Django templates via pipenv
				djlint = {
					command = "pipenv",
					args = { "run", "djlint", "--reformat", "--indent", "2", "-" },
				},
				-- Simplified Python via pipenv
				autopep8 = {
					command = "pipenv",
					args = { "run", "autopep8", "-" },
				},
			},

			formatters_by_ft = {
				-- Web files
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				css = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				html = { "prettier" },

				-- Markdown (keep your existing setup)
				markdown = { "prettier" },
				["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },

				-- Django and Python
				htmldjango = { "djlint" },
				python = { "autopep8" },

				-- Lua
				lua = { "stylua" },
			},

			format_on_save = {
				timeout_ms = 2000,
				lsp_fallback = true,
			},
		})

		-- Keep your existing keymaps
		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({ timeout_ms = 2000 })
		end, { desc = "Format with specific formatter" })

		vim.keymap.set("n", "<leader>mf", function()
			local bufnr = vim.api.nvim_get_current_buf()
			local ft = vim.bo[bufnr].filetype
			local formatters = conform.list_formatters(bufnr)

			print("File type: " .. ft)
			if #formatters > 0 then
				for _, formatter in ipairs(formatters) do
					print("Formatter: " .. formatter.name .. " (available: " .. tostring(formatter.available) .. ")")
				end
			else
				print("No formatters configured for: " .. ft)
			end
		end, { desc = "Show formatter for current file" })
	end,
}
