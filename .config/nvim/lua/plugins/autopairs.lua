return {
  "windwp/nvim-autopairs",
  event = { "InsertEnter" },
  dependencies = { "hrsh7th/nvim-cmp" },
  config = function()
    local autopairs = require("nvim-autopairs")

    -- configure autopairs
    autopairs.setup({
      check_ts = true,             -- enable treesitter
      ts_config = {
        lua = { "string" },        -- don't add pairs in lua string treesitter nodes
      },
      ignored_next_char = "[%w%.]" -- don't add pairs if the next char is alphanumeric
    })

    -- If you want insert '(' after select function or method item
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    cmp.event:on(
      "confirm_done",
      cmp_autopairs.on_confirm_done()
    )
  end
}
