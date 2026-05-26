-- Define on_attach function
local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true }
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)

  if client.name == 'ruff' then
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end
  if client.name ~= 'ruff' then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.codeActionProvider = false
  end
end

-- Configure servers using vim.lsp.config (Neovim 0.11+)
vim.lsp.config('ruff', {
  on_attach = on_attach,
  init_options = {
    settings = {
      args = { '--line-length=88', '--select=ALL' },
    },
  },
  capabilities = {
    positionEncodings = { 'utf-8' },
  },
})

vim.lsp.config('pyright', {
  on_attach = on_attach,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        typeCheckingMode = 'basic',
      },
    },
  },
})

vim.lsp.config('gopls', {
  on_attach = on_attach,
  settings = {
    gopls = {
      analyses = { unusedparams = true, shadow = true },
      staticcheck = true,
      usePlaceholders = true,
    },
    hints = {
      assignVariableTypes = true,
      compositeLiteralFields = true,
      compositeLiteralTypes = true,
      constantValues = true,
      functionTypeParameters = true,
      parameterNames = true,
      rangeVariableTypes = true,
    },
  },
})

vim.lsp.config('clangd', {
  on_attach = on_attach,
  cmd = { '/opt/homebrew/opt/llvm/bin/clangd', '--background-index', '--clang-tidy' },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
})

-- Enable the servers
vim.lsp.enable({ 'ruff', 'pyright', 'gopls', 'clangd' })

-- Completion setup (nvim-cmp works independently)
local cmp = require('cmp')

cmp.setup({
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  },
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = true,
})
