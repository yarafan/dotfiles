local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

---@class wk.Opts
local setup = {
  ---@type false | "classic" | "modern" | "helix"
  preset = "classic",
  -- Delay before showing the popup. Can be a number or a function that returns a number.
  ---@type number | fun(ctx: { keys: string, mode: string, plugin?: string }):number
  delay = function(ctx)
    return ctx.plugin and 0 or 200
  end,
  ---@param mapping wk.Mapping
  filter = function(mapping)
    -- example to exclude mappings without a description
    -- return mapping.desc and mapping.desc ~= ""
    return true
  end,
  --- You can add any mappings here, or use `require('which-key').add()` later
  ---@type wk.Spec
  spec = {},
  -- show a warning when issues were detected with your mappings
  notify = true,
  -- Which-key automatically sets up triggers for your mappings.
  -- But you can disable this and setup the triggers manually.
  -- Check the docs for more info.
  ---@type wk.Spec
  triggers = {
    { "<auto>", mode = "nxso" },
  },
  -- Start hidden and wait for a key to be pressed before showing the popup
  -- Only used by enabled xo mapping modes.
  ---@param ctx { mode: string, operator: string }
  defer = function(ctx)
    return ctx.mode == "V" or ctx.mode == "<C-V>"
  end,
  plugins = {
    marks = true,     -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    spelling = {
      enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    presets = {
      operators = true,    -- adds help for operators like d, y, ...
      motions = true,      -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true,      -- default bindings on <c-w>
      nav = true,          -- misc bindings to work with windows
      z = true,            -- bindings for folds, spelling and others prefixed with z
      g = true,            -- bindings for prefixed with g
    },
  },
  ---@type wk.Win.opts
  win = {
    -- don't allow the popup to overlap with the cursor
    no_overlap = true,
    -- width = 1,
    -- height = { min = 4, max = 25 },
    -- col = 0,
    -- row = math.huge,
    -- border = "none",
    padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
    title = true,
    title_pos = "center",
    zindex = 1000,
    -- Additional vim.wo and vim.bo options
    bo = {},
    wo = {
      -- winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
    },
  },
  layout = {
    width = { min = 20 }, -- min and max width of the columns
    spacing = 3,          -- spacing between columns
  },
  keys = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>",   -- binding to scroll up inside the popup
  },
  ---@type (string|wk.Sorter)[]
  --- Mappings are sorted using configured sorters and natural sort of the keys
  --- Available sorters:
  --- * local: buffer-local mappings first
  --- * order: order of the items (Used by plugins like marks / registers)
  --- * group: groups last
  --- * alphanum: alpha-numerical first
  --- * mod: special modifier keys last
  --- * manual: the order the mappings were added
  --- * case: lower-case first
  sort = { "local", "order", "group", "alphanum", "mod" },
  ---@type number|fun(node: wk.Node):boolean?
  expand = 0, -- expand groups when <= n mappings
  -- expand = function(node)
  --   return not node.desc -- expand all nodes without a description
  -- end,
  -- Functions/Lua Patterns for formatting the labels
  ---@type table<string, ({[1]:string, [2]:string}|fun(str:string):string)[]>
  replace = {
    key = {
      function(key)
        return require("which-key.view").format(key)
      end,
      -- { "<Space>", "SPC" },
    },
    desc = {
      { "<Plug>%(?(.*)%)?", "%1" },
      { "^%+",              "" },
      { "<[cC]md>",         "" },
      { "<[cC][rR]>",       "" },
      { "<[sS]ilent>",      "" },
      { "^lua%s+",          "" },
      { "^call%s+",         "" },
      { "^:%s*",            "" },
    },
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
    ellipsis = "…",
    -- set to false to disable all mapping icons,
    -- both those explicitly added in a mapping
    -- and those from rules
    mappings = true,
    --- See `lua/which-key/icons.lua` for more details
    --- Set to `false` to disable keymap icons from rules
    ---@type wk.IconRule[]|false
    rules = {},
    -- use the highlights from mini.icons
    -- When `false`, it will use `WhichKeyIcon` instead
    colors = true,
    -- used by key format
    keys = {
      Up = " ",
      Down = " ",
      Left = " ",
      Right = " ",
      C = "󰘴 ",
      M = "󰘵 ",
      D = "󰘳 ",
      S = "󰘶 ",
      CR = "󰌑 ",
      Esc = "󱊷 ",
      ScrollWheelDown = "󱕐 ",
      ScrollWheelUp = "󱕑 ",
      NL = "󰌑 ",
      BS = "󰁮",
      Space = "󱁐 ",
      Tab = "󰌒 ",
      F1 = "󱊫",
      F2 = "󱊬",
      F3 = "󱊭",
      F4 = "󱊮",
      F5 = "󱊯",
      F6 = "󱊰",
      F7 = "󱊱",
      F8 = "󱊲",
      F9 = "󱊳",
      F10 = "󱊴",
      F11 = "󱊵",
      F12 = "󱊶",
    },
  },
  show_help = true, -- show a help message in the command line for using WhichKey
  show_keys = true, -- show the currently pressed key and its label as a message in the command line
  -- disable WhichKey for certain buf types and file types.
  disable = {
    ft = {},
    bt = {},
  },
  debug = false, -- enable wk.log in the current directory
}
-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

local custom_mappings = {
  { "<C-h>",     "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree" },
  { "<leader>y", '"+y',                     desc = "Yank +",         mode = 'v' },
  { "<leader>p", '"+p',                     desc = "Paste +",        mode = 'n' },
  {
    mode = "i",
    {
      "<C-j>",
      function()
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        end
      end,
      desc = "Luasnip expand",
    },
    {
      "<C-k>",
      function()
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        end
      end,
      desc = "Luasnip go back",
    },
    {
      "<C-l>",
      function()
        if luasnip.choice_active() then
          luasnip.change_choice(-1)
        end
      end,
      desc = "Luasnip change choice",
    },
  },
  {
    mode = 'n',
    {
      "<leader><leader>s",
      "<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<cr>",
      desc = "Relaod luasnip config",
      nowait = true,
      remap = false
    },
    { "<leader>c",   "<cmd>Bdelete!<CR>",                                        desc = "Close Buffer",          nowait = true, remap = false },
    { "<leader>g",   group = "Git",                                              nowait = true,                  remap = false },
    { "<leader>gA",  "<cmd>lua require 'gitsigns'.stage_buffer()<cr>",           desc = "Stage Buffer",          nowait = true, remap = false },
    { "<leader>gR",  "<cmd>lua require 'gitsigns'.reset_buffer()<cr>",           desc = "Reset Buffer",          nowait = true, remap = false },
    { "<leader>gU",  "<cmd>lua require 'gitsigns'.reset_buffer_index()<cr>",     desc = "Undo Stage Hunk",       nowait = true, remap = false },
    { "<leader>ga",  "<cmd>lua require 'gitsigns'.stage_hunk()<cr>",             desc = "Stage Hunk",            nowait = true, remap = false },
    { "<leader>gb",  "<cmd>Telescope git_branches<cr>",                          desc = "Find branch",           nowait = true, remap = false },
    { "<leader>gc",  "<cmd>Telescope git_commits<cr>",                           desc = "Checkout commit",       nowait = true, remap = false },
    { "<leader>gd",  "<cmd>Gitsigns diffthis<cr>",                               desc = "Diff",                  nowait = true, remap = false },
    { "<leader>gj",  "<cmd>lua require 'gitsigns'.next_hunk()<cr>",              desc = "Next Hunk",             nowait = true, remap = false },
    { "<leader>gk",  "<cmd>lua require 'gitsigns'.prev_hunk()<cr>",              desc = "Prev Hunk",             nowait = true, remap = false },
    { "<leader>gl",  "<cmd>lua require 'gitsigns'.blame_line()<cr>",             desc = "Blame",                 nowait = true, remap = false },
    { "<leader>gp",  "<cmd>lua require 'gitsigns'.preview_hunk()<cr>",           desc = "Preview Hunk",          nowait = true, remap = false },
    { "<leader>gr",  "<cmd>lua require 'gitsigns'.reset_hunk()<cr>",             desc = "Reset Hunk",            nowait = true, remap = false },
    { "<leader>gs",  "<cmd>Telescope git_status<cr>",                            desc = "Open changed file",     nowait = true, remap = false },
    { "<leader>gu",  "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",        desc = "Undo Stage Hunk",       nowait = true, remap = false },
    { "<leader>l",   group = "LSP",                                              nowait = true,                  remap = false },
    { "<leader>lS",  "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",         desc = "Workspace Symbols",     nowait = true, remap = false },
    { "<leader>la",  "<cmd>lua vim.lsp.buf.code_action()<cr>",                   desc = "Code Action",           nowait = true, remap = false },
    { "<leader>ld",  "<cmd>Telescope diagnostics bufnr=0<cr>",                   desc = "Document Diagnostics",  nowait = true, remap = false },
    { "<leader>lf",  "<cmd>lua vim.lsp.buf.format{async=true}<cr>",              desc = "Format",                nowait = true, remap = false },
    { "<leader>lg",  group = "Go to",                                            nowait = true,                  remap = false },
    { "<leader>lgD", "<cmd>lua vim.lsp.buf.declaration()<cr>",                   desc = "Go to declaration",     nowait = true, remap = false },
    { "<leader>lgd", "<cmd>lua vim.lsp.buf.definition()<cr>",                    desc = "Go to definition",      nowait = true, remap = false },
    { "<leader>lgi", "<cmd>lua vim.lsp.buf.implementation()<cr>",                desc = "Go to implementation",  nowait = true, remap = false },
    { "<leader>lgr", "<cmd>lua vim.lsp.buf.references()<cr>",                    desc = "Go to references",      nowait = true, remap = false },
    { "<leader>lh",  "<cmd>lua vim.lsp.buf.hover()<CR>",                         desc = "Hover",                 nowait = true, remap = false },
    { "<leader>lj",  "<cmd>lua vim.diagnostic.jump({count=1, float=true})<CR>",  desc = "Next Diagnostic",       nowait = true, remap = false },
    { "<leader>lk",  "<cmd>lua vim.diagnostic.jump({count=-1, float=true})<cr>", desc = "Prev Diagnostic",       nowait = true, remap = false },
    { "<leader>ll",  "<cmd>lua vim.lsp.codelens.run()<cr>",                      desc = "CodeLens Action",       nowait = true, remap = false },
    { "<leader>lq",  "<cmd>lua vim.diagnostic.setloclist()<cr>",                 desc = "Quickfix",              nowait = true, remap = false },
    { "<leader>lr",  "<cmd>lua vim.lsp.buf.rename()<cr>",                        desc = "Rename",                nowait = true, remap = false },
    { "<leader>ls",  "<cmd>Telescope lsp_document_symbols<cr>",                  desc = "Document Symbols",      nowait = true, remap = false },
    { "<leader>lw",  "<cmd>Telescope diagnostics<cr>",                           desc = "Workspace Diagnostics", nowait = true, remap = false },
    { "<leader>ob",  "<cmd>ObsidianBacklinks<cr>",                               desc = "Obsidian Backlinks",    nowait = true, remap = false },
    { "<leader>ol",  "<cmd>ObsidianLinks<cr>",                                   desc = "Obsidian Links",        nowait = true, remap = false },
    { "<leader>on",  "<cmd>ObsidianNew<cr>",                                     desc = "Obsidian New",          nowait = true, remap = false },
    { "<leader>oq",  "<cmd>ObsidianQuickSwitch<cr>",                             desc = "Obsidian Quick Switch", nowait = true, remap = false },
    { "<leader>os",  "<cmd>ObsidianSearch<cr>",                                  desc = "Obsidian Search",       nowait = true, remap = false },
    { "<leader>ot",  "<cmd>ObsidianTags<cr>",                                    desc = "Obsidian Tags",         nowait = true, remap = false },
    { "<leader>q",   "<cmd>q!<CR>",                                              desc = "Quit",                  nowait = true, remap = false },
    { "<leader>s",   group = "Search",                                           nowait = true,                  remap = false },
    { "<leader>sF",  "<cmd>Telescope live_grep theme=ivy<cr>",                   desc = "Find Text",             nowait = true, remap = false },
    { "<leader>sM",  "<cmd>Telescope man_pages<cr>",                             desc = "Find Man Pages",        nowait = true, remap = false },
    { "<leader>sR",  "<cmd>Telescope registers<cr>",                             desc = "Find Registers",        nowait = true, remap = false },
    {
      "<leader>sb",
      "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
      desc = "Buffers",
      nowait = true,
      remap = false
    },
    {
      "<leader>sc",
      "<cmd>lua require('telescope.builtin').commands(require('telescope.themes').get_dropdown{})<cr>",
      desc = "Commands",
      nowait = true,
      remap = false
    },
    {
      "<leader>sf",
      "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
      desc = "Find files",
      nowait = true,
      remap = false
    },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>",                              desc = "Find Help",             nowait = true, remap = false },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>",                                desc = "Find Keymaps",          nowait = true, remap = false },
    { "<leader>sr", "<cmd>Telescope oldfiles<cr>",                               desc = "Find Open Recent File", nowait = true, remap = false },
    { "<leader>w",  "<cmd>w!<CR>",                                               desc = "Save",                  nowait = true, remap = false },
    { "<leader>d",  group = "Debugger",                                          nowait = true,                  remap = false },
    { "<leader>dt", "<cmd>lua require('dapui').toggle()<cr>",                    desc = "Toggle DAP ui",         nowait = true, remap = false },
    { "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<cr>",           desc = "Toggle breakpoint",     nowait = true, remap = false },
    { "<leader>di", "<cmd>lua require('dap').step_into()<cr>",                   desc = "Step into",             nowait = true, remap = false },
    { "<leader>do", "<cmd>lua require('dap').step_out()<cr>",                    desc = "Step out",              nowait = true, remap = false },
    { "<leader>dv", "<cmd>lua require('dap').step_over()<cr>",                   desc = "Step over",             nowait = true, remap = false },
    { "<leader>dc", "<cmd>lua require('dap').continue()<cr>",                    desc = "Continue",              nowait = true, remap = false },
    { "<leader>dl", "<cmd>lua require('dap').run_last()<cr>",                    desc = "Run last",              nowait = true, remap = false },
    { "<leader>dr", "<cmd>lua require('dap').repl.open()<cr>",                   desc = "Open REPL",             nowait = true, remap = false },
    { "<leader>d?", "<cmd>lua require('dapui').eval(nil, { enter = true })<cr>", desc = "Eval current line",     nowait = true, remap = false },
    {
      "<leader>tn",
      function() require("neotest").run.run() end,
      desc = "[t]est [n]earest",
    },
    {
      "<leader>to",
      function() require("neotest").output.open({ enter = true }) end,
      desc = "[t]est window [o]pen",
    },
    {
      "<leader>ts",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "[t]est summary [t]oggle",
    },
  },
}

which_key.setup(setup)
which_key.add(custom_mappings)
