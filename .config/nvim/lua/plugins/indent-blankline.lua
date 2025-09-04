return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  main = "ibl",
  opts = {},
  config = function()
    local ibl = require("ibl")
    -- initialize and configure indent-blankline
    ibl.setup({
      indent = {
        char = "▎",
        highlight = "IblIndent",
      },
      scope = {
        enabled = true,
        show_start = true, -- disable if KiTTY does not render underlines correctly with JetBrains Font
        show_end = true,   -- disable if KiTTY does not render underlines correctly with JetBrains Font
      }
    })

    -- disable indentation on the first level (looks cleaner, just a preference)
    local hooks = require("ibl.hooks")
    hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
    hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)
  end
}
