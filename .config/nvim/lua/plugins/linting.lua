return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      python = { "ruff" },
    }

    -- Try linting when we enter a buffer, when we write to the buffer, we exit insert mode, or change the text in the buffer.
    -- Some linters require the file to be saved before executing. So the InsertLeave and TextChanged events
    -- won't work with every linter. To check for this, go to the repo: nvim-lint/lua/lint/linters/ruff.lua
    -- Check if stdin is set to 'true' or 'false'. If it is true, the file does not have to be saved for the linter to work.
    -- pylint stdin = false
    -- ruff stdin = true
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end
    })

    vim.keymap.set("n", "<leader>l", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end
}
