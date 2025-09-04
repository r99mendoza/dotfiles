return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    keywords = {
      NOTE = { icon = "󰈙 ", color = "hint", alt = { "INFO" } },
    }
  }
}
