return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	branch = "main",
	build = ":TSUpdate",
	init = function()
		local languages = {
			"bash",
			"cpp",
			"gitignore",
			"html",
			"json",
			"lua",
			"markdown",
			"make",
			"python",
			"tcl",
			"toml",
			"systemverilog",
			"yaml",
		}
		local already_installed = require("nvim-treesitter.config").get_installed()
		local parsers_to_install = vim.iter(languages)
			:filter(function(parser)
				return not vim.tbl_contains(already_installed, parser)
			end)
			:totable()
		require("nvim-treesitter").install(parsers_to_install)
	end,
	config = function()
		-- use bash parser for zsh files
		vim.treesitter.language.register("bash", "zsh")

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("treesitter.setup", {}),
			callback = function(args)
				local buffer = args.buf
				local filetype = args.match

				-- you need some mechanism to avoid running on buffers that do not
				-- correspond to a language (like oil.nvim buffers), this implementation
				-- checks if a parser exists for the current language
				local language = vim.treesitter.language.get_lang(filetype) or filetype
				if not vim.treesitter.language.add(language) then
					return
				end

				-- replicate "highlight = { enable = true }"
				vim.treesitter.start(buffer, language)

				-- replicate "indent = { enable = true }"
				vim.bo[buffer].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

				-- replicate "fold = { enable = true }"
				-- vim.wo.foldmethod = "expr"
				-- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

				-- "incremental_selection = { enable = true }" cannot be easily replicated
			end,
		})
	end,
}
