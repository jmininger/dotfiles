vim.cmd [[packadd packer.nvim]]

-- Rustaceanvim configuration (must be set BEFORE plugin loads)
vim.g.rustaceanvim = {
  server = {
    on_attach = function(client, bufnr)
      local bufopts = { noremap = true, silent = true, buffer = bufnr }
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
      vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
      vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
      vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
      vim.keymap.set("n", "<space>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, bufopts)
      vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
      vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
      vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
      vim.keymap.set("n", "<space>f", vim.lsp.buf.format, bufopts)

      -- Rustaceanvim-specific mappings
      vim.keymap.set("n", "<C-space>", function() vim.cmd.RustLsp({ 'hover', 'actions' }) end, { buffer = bufnr, desc = "Hover Actions" })
      vim.keymap.set("n", "<Leader>a", function() vim.cmd.RustLsp('codeAction') end, { buffer = bufnr, desc = "Code Action" })
      vim.keymap.set("n", "<leader>j", function() vim.cmd.RustLsp('joinLines') end, { buffer = bufnr, desc = "Join Lines" })
      vim.keymap.set("n", "<leader>r", function() vim.cmd.RustLsp('runnables') end, { buffer = bufnr, desc = "Run Runnables" })
      vim.keymap.set("n", "<leader>pm", function() vim.cmd.RustLsp('parentModule') end, { buffer = bufnr, desc = "Go to Parent Module" })
      vim.keymap.set("n", "<leader>em", function() vim.cmd.RustLsp('expandMacro') end, { buffer = bufnr, desc = "Expand Macro" })
    end,
    default_settings = {
      ["rust-analyzer"] = {
        inlayHints = {
          bindingModeHints = { enable = true },
          chainingHints = { enable = true },
          closingBraceHints = { enable = true, minLines = 25 },
          closureReturnTypeHints = { enable = "always" },
          lifetimeElisionHints = { enable = "skip_trivial" },
          parameterHints = { enable = true },
          typeHints = { enable = true, hideNamedConstructor = true },
        },
        semantics = {
          enable = true,
        },
        imports = {
          granularity = { group = "crate" },
        },
        completion = {
          autoimport = { enable = true },
          autoself = { enable = true },
          callable = { snippets = "fill_arguments" },
          postfix = { enable = true },
        },
        lens = {
          enable = true,
          implementations = true,
          run = true,
          debug = true,
          references = true,
        },
        diagnostics = {
          enable = true,
          experimental = { enable = true },
          disabled = { "unresolved-proc-macro" },
        },
      },
    },
  },
}

require('plugins')

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])


vim.cmd([[
silent! language en_US.UTF-8
syntax on
filetype plugin indent on
]])

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- nvim-tree setup with custom mappings
require("nvim-tree").setup({
  on_attach = function(bufnr)
    local api = require('nvim-tree.api')
    
    -- Default mappings
    api.config.mappings.default_on_attach(bufnr)
    
    -- Custom mappings
    vim.keymap.set('n', '<C-v>', api.node.open.vertical, {
      desc = 'nvim-tree: Open in vertical split',
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true,
    })
  end,
})

-- vim.opt.t_Co="256"
-- vim.cmd('colorscheme gruvbox')
-- vim.cmd('colorscheme Paper')
vim.cmd('colorscheme solarized8_high')
vim.opt.termguicolors = true

vim.opt.langmenu="en_US"
vim.opt.background="dark"
vim.opt.tabstop=2
vim.opt.shiftwidth=2
vim.opt.expandtab = true vim.opt.textwidth=100

vim.api.nvim_create_autocmd("FileType", {
  pattern = "c",
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.expandtab = true
  end,
})
vim.opt.hlsearch=true
vim.opt.ignorecase=true
vim.opt.smartcase=true
vim.opt.number=true
vim.opt.autoindent=true
-- set list
vim.opt.backspace="indent,eol,start"
vim.opt.belloff="all"
-- Open vertical splits to the right
vim.opt.splitright=true

vim.g.rustfmt_autosave=1
vim.g.rustfmt_command="rustfmt +nightly"
-- vim.g.rustfmt_options="+nightly"

vim.api.nvim_set_keymap("n", "<C-t>",  ":tabnew ", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-w><C-w>",  ":q<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-J>",  "<C-W><C-J>",  { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-K>",  "<C-W><C-K>",  { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-L>",  "<C-W><C-L>",  { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-H>",  "<C-W><C-H>",  { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "oo",  "o<Esc>",  { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "OO",  "O<Esc>",  { noremap = true, silent = true })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>cd', '<cmd>lua open_crate_docs()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>cp', '<cmd>CopilotToggle<cr>', { noremap = true })
-- LazyGit
vim.api.nvim_set_keymap('n', '<leader>lg', ':LazyGit<CR>', { noremap = true, silent = true })
-- Toggles tagbar
vim.api.nvim_set_keymap('n', '<leader>t', ':Tagbar<CR>', { noremap = true, silent = true })
-- vim.keymap.set('n', "<leader>d", ":RustOpenExternalDocs<CR>")
-- vim.keymap.set('n', "<leader>ct", ":RustTest<CR>")
vim.api.nvim_set_keymap("n", "<C-S>", ":StripTrailing<cr>:update<cr>",  { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<C-S>", ":update<cr>",  { noremap = true, silent = true })
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-f>f', builtin.find_files, {})
vim.keymap.set('n', '<C-f>g', builtin.live_grep, {})
vim.keymap.set('n', '<C-f>b', builtin.buffers, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<C-k>', builtin.keymaps, {})
-- vim.keymap.set('n', '<leader>fr', builtin.help_tags, {})
vim.api.nvim_set_keymap("n", "<leader>n", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
-- playground deprecated, use :InspectTree instead
vim.keymap.set('n', '<leader>p', ':InspectTree<CR>', {noremap = true})

-- FloaTerm configuration
vim.keymap.set('n', "<leader>ft", ":FloatermNew --name=myfloat --height=0.8 --width=0.7 --autoclose=2 zsh <CR> ")
vim.keymap.set('n', "t", ":FloatermToggle myfloat<CR>")
vim.keymap.set('t', "<C-W>", "<C-\\><C-n>:q<CR>")


-- vim.cmd ([[
-- let g:lightline = {}
-- let g:lightline.colorscheme = 'gruvbox'
-- ]])

vim.cmd([[
  function StripTrailingWhitespace()
    if !&binary && &filetype != 'diff'
      normal mz
      normal Hmy
      %s/\s\+$//e
      normal 'yz<CR>
      normal `z
    endif
  endfunction
  command StripTrailing call StripTrailingWhitespace()
]])

-- Rust tags
vim.cmd([[
  autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/$HOME/rsrc-tags/;
  autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!
  ]])

vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true}
vim.api.nvim_set_option('updatetime', 300)

vim.cmd('highlight Normal guibg=NONE')
vim.g.neovide_transparency = 0.85
vim.g.neovide_scale_factor = 0.65
vim.g.neovide_colorscheme = 'gruvbox'
vim.g.tagbar_width = math.floor(vim.api.nvim_win_get_width(0) * 0.35)

vim.g.copilot_enabled = true
vim.g.copilot_assume_mapped = true
vim.api.nvim_create_user_command('CopilotToggle', function()
    vim.g.copilot_enabled = not vim.g.copilot_enabled
    vim.cmd('Copilot status')
end, { nargs = 0, })

-- Accepts the input for copilot
vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.keymap.set('i', '<C-L>', '<Plug>(copilot-accept-line)')
vim.g.copilot_no_tab_map = true


local function on_crate_selected(crate)
  if not crate or crate == "" then
    return
  end
  local crate_path = string.match(crate, "%[(.*)%]")
  if crate_path then
    local cmd = string.format("open %s", crate_path)
    os.execute(cmd)
  end
end

function open_crate_docs()
  local handle = io.popen("cargo doc --document-private-items --workspace --quiet --message-format=json")
  local result = handle:read("*a")
  handle:close()

  local crates = {}
  for line in result:gmatch("[^\r\n]+") do
    local data = vim.fn.json_decode(line)
    if data and data.target and data.target.name and data.reason and data.reason == "compiler-artifact" and data.filenames then
      for _, filename in ipairs(data.filenames) do
        if filename:find("index.html$") then
          table.insert(crates, string.format("[%s] %s", filename, data.target.name))
        end
      end
    end
  end

  table.sort(crates)

  vim.fn['fzf#run'](vim.fn['fzf#wrap']({
    source = crates,
    sink = on_crate_selected,
    options = '--ansi --prompt="Select a crate: " --with-nth 2..',
  }))
end

-- local cargo_docs_fzf = require('cargo_docs_fzf')
vim.cmd([[command! CargoDocOpen lua open_crate_docs()]])
-- local cmd = vim.cmd

-- -- Function to run cargo test and handle window behavior
-- function RunCargoTest()
--   local buf_name = "CargoTestResults"
--   local buf_found = false
--   local buf

--   -- Check if the cargo test buffer is already open
--   for _, b in ipairs(vim.api.nvim_list_bufs()) do
--     if vim.api.nvim_buf_get_name(b):find(buf_name) then
--       buf = b
--       buf_found = true
--       break
--     end
--   end

--   if buf_found then
--     -- If buffer is found, check if it is displayed in any window
--     local win_found = false
--     for _, win in ipairs(vim.api.nvim_list_wins()) do
--       if vim.api.nvim_win_get_buf(win) == buf then
--         vim.api.nvim_set_current_win(win)
--         cmd('enew')
--         cmd('vertical resize 80')
--         cmd('term cargo test')
--         cmd('startinsert')
--         return
--       end
--     end
--     -- If buffer is found but not displayed in a window
--     vim.cmd('botright vsplit')
--     vim.cmd('wincmd l')
--     vim.cmd('buffer ' .. buf)
--     cmd('enew')
--     cmd('vertical resize 80')
--     cmd('term cargo test')
--     cmd('startinsert')
--     return
--   else
--     -- If buffer is not found, open a new vertical window to the right
--     cmd('botright vsplit')
--     cmd('wincmd l')
--     cmd('enew')
--     cmd('file ' .. buf_name)
--     cmd('vertical resize 80')
--     cmd('term cargo test')
--     cmd('startinsert')
--   end
-- end
-- vim.api.nvim_set_keymap('n', '<leader>ct', ':lua RunCargoTest()<CR>', { noremap = true, silent = true })


-- vim.cmd([[
-- autocmd FileType nr setlocal commentstring=#\ %s
-- ]])
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  -- Installed sources:
  sources = {
    { name = 'path' },                              -- file paths
    { name = 'nvim_lsp', keyword_length = 3 },      -- from language server
    { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
    { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'buffer', keyword_length = 2 },        -- source current buffer
    { name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip
    { name = 'calc'},                               -- source for math calculation
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  formatting = {
      fields = {'menu', 'abbr', 'kind'},
      format = function(entry, item)
          local menu_icon ={
              nvim_lsp = 'λ',
              vsnip = '⋗',
              buffer = 'Ω',
              path = '🖫',
          }
          item.menu = menu_icon[entry.source.name]
          return item
      end,
  },
})

