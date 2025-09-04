return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  config = function()
    local bufferline = require('bufferline')

    bufferline.setup({
      options = {
        mode = "buffers",
        separator_style = "slant", -- slant, slope, thick, thin
        style_preset = {
          bufferline.style_preset.no_italic,
          bufferline.style_preset.no_bold
        },
      }
    })
  end
}
