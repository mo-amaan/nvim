-- Enhanced Django template detection
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.html" },
	callback = function()
		local bufnr = vim.api.nvim_get_current_buf()
		local bufname = vim.api.nvim_buf_get_name(bufnr)
		local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 50, false)
		local content = table.concat(lines, "\n")

		-- Check file path first (most reliable)
		if bufname:match("/templates/") or bufname:match("/django/") or bufname:match("manage%.py") then
			vim.bo[bufnr].filetype = "htmldjango"
			return
		end

		-- Check for Django template syntax
		local django_patterns = {
			"{%%", -- Template tags
			"{{", -- Variables
			"{#", -- Comments
			"{% load", -- Load tags
			"{% extends", -- Extends
			"{% block", -- Blocks
			"{% if", -- Conditionals
			"{% for", -- Loops
			"{% url", -- URL tags
			"{% csrf_token", -- CSRF
		}

		for _, pattern in ipairs(django_patterns) do
			if content:match(vim.pesc(pattern)) then
				vim.bo[bufnr].filetype = "htmldjango"
				return
			end
		end

		-- Default to regular html for non-Django files
		vim.bo[bufnr].filetype = "html"
	end,
})

-- Force Django templates in specific directories
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*/templates/*.html", "*/template/*.html" },
	callback = function()
		vim.bo.filetype = "htmldjango"
	end,
})
