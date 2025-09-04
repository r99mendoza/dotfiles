return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
      end

      -- Navigation
      map("n", "]c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end, "Next Hunk")

      map("n", "[c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end, "Prev Hunk")

      -- Actions
      map("n", "<leader>hs", gitsigns.stage_hunk, "Stage Hunk")
      map("n", "<leader>hu", gitsigns.undo_stage_hunk, "Undo Stage Hunk")
      map("n", "<leader>hr", gitsigns.reset_hunk, "Reset Hunk")
      map("v", "<leader>hs", function()
        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Stage Hunk")
      map("v", "<leader>hr", function()
        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Reset Hunk")

      map("n", "<leader>hS", gitsigns.stage_buffer, "Stage Buffer")
      map("n", "<leader>hR", gitsigns.reset_buffer, "Reset Buffer")
      map("n", "<leader>gp", gitsigns.preview_hunk, "Preview Hunk") -- move gp to hp
      map("n", "<leader>hi", gitsigns.preview_hunk_inline, "Preview Hunk Inline")

      map("n", "<leader>hb", function()
        gitsigns.blame_line({ full = true })
      end, "Blame Line")
      map("n", "<leader>hd", gitsigns.diffthis, "Diff this")
      map("n", "<leader>hD", function()
        gitsigns.diffthis("~")
      end, "Diff this ~")

      map('n', '<leader>hQ', function() gitsigns.setqflist('all') end, "Set QF list (all)")
      map('n', '<leader>hq', gitsigns.setqflist, "Set QF list")

      -- Toggles
      map("n", "<leader>gt", gitsigns.toggle_current_line_blame, "Toggle Current Line Blame") -- move gt to tb
      map("n", "<leader>tw", gitsigns.toggle_word_diff, "Toggle Word Diff")

      -- Text object
      map({ "o", "x" }, "ih", gitsigns.select_hunk, "Gitsigns select hunk")
    end
  }
}
