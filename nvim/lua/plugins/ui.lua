return {
	{
		-- You can easily change to a different colorscheme.
		-- Change the name of the colorscheme plugin below, and then
		-- change the command in the config to whatever the name of that colorscheme is.
		--
		-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
		"sainnhe/gruvbox-material",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		config = function()
			vim.g.gruvbox_material_background = "hard" -- Options: 'soft', 'medium', 'hard'
			vim.g.gruvbox_material_enable_italic = 0 -- Disable italics
			-- Load the colorscheme here.
			vim.cmd.colorscheme("gruvbox-material")
		end,
	},

	{
		-- Collection of various small independent plugins/modules
		"echasnovski/mini.nvim",
		config = function()
			-- Simple and easy statusline.
			--  You could remove this setup call if you don't like it,
			--  and try some other statusline plugin
			local statusline = require("mini.statusline")
			-- set use_icons to true if you have a Nerd Font
			statusline.setup({ use_icons = vim.g.have_nerd_font })

			-- You can configure sections in the statusline by overriding their
			-- default behavior. For example, here we set the section for
			-- cursor location to LINE:COLUMN
			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return "%2l:%-2v"
			end
		end,
	},
}
