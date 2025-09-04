return {
  {
    "folke/tokyonight.nvim",
    enabled = true,
    lazy = false,
    priority = 1000, -- make sure to load this before all other start plugins
    config = function()
      require("tokyonight").setup({
        style = "moon",
        transparent = false, -- Enable this to disable setting the background color
        dim_inactive = true, -- dims inactive windows
      })
      -- Change the "hint" color to the "orange" color, and make the "error" color bright red
      on_colors = function(colors)
        colors.hint = colors.orange
        colors.error = "#ff0000"
      end
      vim.cmd([[colorscheme tokyonight]])
    end
  }
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   enabled = true,
  --   lazy = false,
  --   priority = 1000, -- make sure to load this before all other start plugins
  --   config = function()
  --     local catppuccin = require("catppuccin")
  --
  --     catppuccin.setup({
  --       flavour = "mocha", -- latte, frappe, macchiato, mocha
  --       no_italic = false,
  --       no_bold = false,
  --       no_underline = false,
  --     })
  --     vim.cmd([[colorscheme catppuccin]])
  --   end
  -- }
  -- {
  --     "EdenEast/nightfox.nvim",
  --     enabled = true,
  --     priority = 1000,
  --     config = function()
  --         local nightfox = require("nightfox")
  --         nightfox.setup({
  --             options = {
  --                 styles = {
  --                     comments = "NONE",    -- Value is any valid attr-list value `:help attr-list`
  --                     keywords = "bold",
  --                     types = "italic,bold",
  --                 }
  --             }
  --         })
  --         vim.cmd([[colorscheme carbonfox]])
  --     end
  -- }
  -- {
  --     "rebelot/kanagawa.nvim",
  --     enabled = true,
  --     priority = 1000, -- make sure to load this before all other start plugins
  --     config = function()
  --         local kanagawa = require("kanagawa")
  --
  --         kanagawa.setup({
  --             undercurl = false,
  --             commentStyle = { italic = false },
  --             keywordStyle = { italic = false },
  --             theme = "wave",
  --         })
  --         vim.cmd([[colorscheme kanagawa-wave]])
  --     end
  -- }
  -- {
  --     "rose-pine/neovim",
  --     name = "rose-pine",
  --     enabled = true,
  --     priority = 1000,
  --     config = function()
  --         local rose_pine = require("rose-pine")
  --         rose_pine.setup({
  --             variant = "auto", -- auto, main, moon, or dawn
  --             dark_variant = "main", -- main, moon, or dawn
  --
  --             styles = {
  --                 bold = true,
  --                 italic = false,
  --                 transparency = false,
  --             },
  --         })
  --         vim.cmd([[colorscheme rose-pine]]) -- rose-pine-main, rose-pine-moon, rose-pine-dawn
  --     end
  -- }
}
