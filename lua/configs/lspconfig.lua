-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities
local util = require "lspconfig/util"
local lspconfig = require "lspconfig"
local servers = { "html", "cssls" }
vim.diagnostic.config({
  virtual_text = false
})

-- Show line diagnostics automatically in hover window
vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]



local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
  }
  vim.lsp.buf.execute_command(params)
end

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- typescript
lspconfig.tsserver.setup {
  -- on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    },
    
  },
  --
  -- settings = {
  --   typescript = {
  --     inlayHints = {
  --       includeInlayParameterNameHints = "none", -- 'none' | 'literals' | 'all'
  --       includeInlayParameterNameHintsWhenArgumentMatchesName = true,
  --       includeInlayVariableTypeHints = true,
  --       includeInlayFunctionParameterTypeHints = false,
  --       includeInlayVariableTypeHintsWhenTypeMatchesName = false,
  --       includeInlayPropertyDeclarationTypeHints = false,
  --       includeInlayFunctionLikeReturnTypeHints = true,
  --       includeInlayEnumMemberValueHints = true,
  --     },
  --   },
  --   javascript = {
  --     inlayHints = {
  --       includeInlayParameterNameHints = "none", -- 'none' | 'literals' | 'all'
  --       includeInlayParameterNameHintsWhenArgumentMatchesName = true,
  --       includeInlayVariableTypeHints = true,
  --       includeInlayFunctionParameterTypeHints = false,
  --       includeInlayVariableTypeHintsWhenTypeMatchesName = false,
  --       includeInlayPropertyDeclarationTypeHints = false,
  --       includeInlayFunctionLikeReturnTypeHints = true,
  --       includeInlayEnumMemberValueHints = true,
  --     },
  --   },
  -- },
   init_options = require("nvim-lsp-ts-utils").init_options,
    --
    on_attach = function(client, bufnr)
        local ts_utils = require("nvim-lsp-ts-utils")

        -- defaults
        ts_utils.setup({
            debug = false,
            disable_commands = false,
            enable_import_on_completion = false,

            -- import all
            import_all_timeout = 5000, -- ms
            -- lower numbers = higher priority
            import_all_priorities = {
                same_file = 1, -- add to existing import statement
                local_files = 2, -- git files or files with relative path markers
                buffer_content = 3, -- loaded buffer content
                buffers = 4, -- loaded buffer names
            },
            import_all_scan_buffers = 100,
            import_all_select_source = false,
            -- if false will avoid organizing imports
            always_organize_imports = true,

            -- filter diagnostics
            filter_out_diagnostics_by_severity = {},
            filter_out_diagnostics_by_code = {},

            -- inlay hints
            auto_inlay_hints = false,
            inlay_hints_highlight = "Comment",
            inlay_hints_priority = 200, -- priority of the hint extmarks
            inlay_hints_throttle = 150, -- throttle the inlay hint request
            inlay_hints_format = { -- format options for individual hint kind
                Type = {},
                Parameter = {},
                Enum = {},
                -- Example format customization for `Type` kind:
                -- Type = {
                --     highlight = "Comment",
                --     text = function(text)
                --         return "->" .. text:sub(2)
                --     end,
                -- },
            },

            -- update imports on file move
            update_imports_on_move = false,
            require_confirmation_on_move = false,
            watch_dir = nil,
        })

        -- required to fix code action ranges and filter diagnostics
        ts_utils.setup_client(client)

        -- no default maps, so you may want to define some here
        local opts = { silent = true }
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gi", ":TSLspImportAll<CR>", opts)
    end,
}

-- tailwindcss
lspconfig.tailwindcss.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}



lspconfig.tailwindcss.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- c++
lspconfig.clangd.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}
