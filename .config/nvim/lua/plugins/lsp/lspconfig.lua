return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    -- can add "folke/lazydev.nvim" for properly configuring LuaLS for editing your Neovim config
  },
  config = function()
    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap -- for conciseness
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }

        -- set keybinds
        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
      end,
    })

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- Hint icons: 󰠠 󰌵
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.HINT] = "󰌵 ",
          [vim.diagnostic.severity.INFO] = " ",
        }
      }
    })

    vim.lsp.config("*", {
      capabilities = capabilities,
    })

    -- New LSP setup for neovim 0.11+
    -- See https://gpanders.com/blog/whats-new-in-neovim-0-11/ for a nice overview
    -- off how the lsp setup works in neovim 0.11+.
    --------------------------------------------------------------------------------
    -- vim.lsp.set_log_level("DEBUG") -- enable verbose logging

    -- This actually just enables the lsp servers.
    -- The configuration is found in the lsp folder inside the nvim config folder,
    -- so in ~/.config/nvim/lsp/lua_ls.lua for lua_ls, for example.
    vim.lsp.enable("bashls")
    vim.lsp.enable("clangd")
    vim.lsp.enable("lua_ls")
    vim.lsp.enable("pyright")
    vim.lsp.enable("ruby_lsp")
    vim.lsp.enable("yamlls")

    -- SystemVerilog LSPs
    -- Veridian used for autocompletion. Works with verible.
    -- local lspconfutil = require("lspconfig/util")
    -- local root_pattern = lspconfutil.root_pattern("veridian.yml", ".git")
    -- vim.lsp.config("veridian", {
    --   root_dir = function(fname)
    --     local filename = lspconfutil.path.is_absolute(fname) and fname
    --         or lspconfutil.path.join(vim.loop.cwd(), fname)
    --     return root_pattern(filename) or lspconfutil.path.dirname(filename)
    --   end,
    -- })
    -- vim.lsp.enable({ "verible", "veridian" })

    -- Diagnostics
    vim.diagnostic.config({
      -- Use the default configuration
      -- virtual_lines = true

      -- Alternatively, customize specific options
      virtual_lines = {
        -- Only show virtual line diagnostics for the current cursor line
        current_line = true,
      }
    })
  end
}
