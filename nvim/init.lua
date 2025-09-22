-- smooth editing, LSP, Treesitter, Telescope, formatting, Git, terminals, and a few QoL boosts.

---------------------------------------------------------------
-- 0) Bootstrap lazy.nvim (plugin manager)
---------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

---------------------------------------------------------------
-- 1) Core settings (Wayland-safe clipboard, sensible defaults)
---------------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = ","

local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.cursorline = true
opt.wrap = false
opt.scrolloff = 5
opt.sidescrolloff = 8
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.splitbelow = true
opt.splitright = true
opt.updatetime = 300
opt.timeoutlen = 400
opt.undofile = true
opt.clipboard = "unnamedplus"   -- uses wl-clipboard on Wayland if installed

---------------------------------------------------------------
-- 2) Plugins via lazy.nvim
---------------------------------------------------------------
require("lazy").setup({
  -- UI + UX ---------------------------------------------------
  { "folke/tokyonight.nvim", lazy = false, priority = 1000, opts = { style = "night" } },
  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = { options = { theme = "auto", globalstatus = true } } },
  { "folke/which-key.nvim", event = "VeryLazy", opts = {} },
  { "stevearc/dressing.nvim", event = "VeryLazy", opts = {} },
  { "rcarriga/nvim-notify", opts = { timeout = 2000 } },
  -- Removed noice.nvim for faster command execution
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  { "numToStr/Comment.nvim", opts = {} },
  { "kylechui/nvim-surround", event = "VeryLazy", opts = {} },

  -- Files, search, projects ----------------------------------
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = function() return vim.fn.executable("make") == 1 end },
  { "ahmedkhalf/project.nvim", 
    config = function()
      require("project_nvim").setup({
        detection_methods = { "pattern", "lsp" },
        patterns = { ".git", "pyproject.toml", "package.json", "Makefile" }
      })
    end
  },
  { "stevearc/oil.nvim", opts = { view_options = { show_hidden = true } } },

  -- Git -------------------------------------------------------
  { "lewis6991/gitsigns.nvim", opts = {} },
  { "kdheepak/lazygit.nvim", cmd = { "LazyGit" } },

  -- Terminal & task runner -----------------------------------
  { "akinsho/toggleterm.nvim", version = "*", opts = { open_mapping = [[<C-`>]], direction = "float" } },
  { "stevearc/overseer.nvim", opts = {} },

  -- Treesitter ------------------------------------------------
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash", "c", "cpp", "lua", "python", "rust", "json", "yaml", "toml",
          "html", "css", "javascript", "typescript", "markdown", "markdown_inline",
          "make", "fish"
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },

  -- LSP, format, lint ----------------------------------------
  { "williamboman/mason.nvim", opts = { ui = { border = "rounded" } } },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },
  { "stevearc/conform.nvim", opts = {
      notify_on_error = false,
      format_on_save = function(buf)
        -- Disable on big files
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > 512 * 1024 then return end
        return { timeout_ms = 2000, lsp_fallback = true }
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_format", "black" },
        sh = { "shfmt" }, bash = { "shfmt" }, zsh = { "shfmt" }, fish = { "fish_indent" },
        c = { "clang_format" }, cpp = { "clang_format" },
        javascript = { "prettier" }, typescript = { "prettier" },
        json = { "jq", "prettier" }, yaml = { "prettier" }, toml = { "taplo" },
        html = { "prettier" }, css = { "prettier" }, markdown = { "prettier" },
      },
    }
  },

  -- Debugging (optional, light defaults) ---------------------
  { "mfussenegger/nvim-dap" },
  { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
}, {
  install = { colorscheme = { "tokyonight" } },
  change_detection = { notify = false },
})

---------------------------------------------------------------
-- 3) Post-plugin config (LSP, Telescope, keymaps, etc.)
---------------------------------------------------------------
-- Colorscheme
vim.cmd.colorscheme("tokyonight")

-- Lualine
require("lualine").setup({})

-- Telescope
local telescope = require("telescope")
telescope.setup({ 
  defaults = { 
    mappings = { 
      i = { 
        ["<C-j>"] = "move_selection_next", 
        ["<C-k>"] = "move_selection_previous" 
      } 
    } 
  } 
})
pcall(telescope.load_extension, "fzf")
pcall(telescope.load_extension, "projects")

-- Oil: simple file manager toggle
vim.keymap.set("n", "-", function() require("oil").toggle_float() end, { desc = "Oil file manager" })

-- ToggleTerm: float terminal with <C-`>
-- (Already mapped via opts. Add extra terminals if desired.)

-- Overseer: tasks (build, run, test)
vim.keymap.set("n", "<leader>tt", ":OverseerToggle<CR>", { desc = "Toggle task list" })
vim.keymap.set("n", "<leader>tr", ":OverseerRun<CR>",    { desc = "Run a task" })

-- Gitsigns
require("gitsigns").setup()

-- Mason + LSPConfig
require("mason").setup()
local mason_lspconfig = require("mason-lspconfig")

-- Ensure these servers are installed
mason_lspconfig.setup({
  ensure_installed = {
    "pyright", "lua_ls", "clangd", "rust_analyzer", "bashls",
    "jsonls", "yamlls", "html", "cssls", "marksman", "taplo"
  }
})

local lspconfig = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Pretty borders
local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

-- on_attach: buffer-local mappings
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end
  nmap("gd", vim.lsp.buf.definition, "Goto Definition")
  nmap("gr", vim.lsp.buf.references, "References")
  nmap("gD", vim.lsp.buf.declaration, "Goto Declaration")
  nmap("gi", vim.lsp.buf.implementation, "Goto Implementation")
  nmap("K",  vim.lsp.buf.hover, "Hover")
  nmap("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
  nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
  nmap("<leader>fd", function() vim.lsp.buf.format({ async = true }) end, "Format buffer")
end

-- Manual server setup (more compatible)
local servers = {
  pyright = {},
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = { checkThirdParty = false }
      }
    }
  },
  clangd = {},
  rust_analyzer = {},
  bashls = {},
  jsonls = {},
  yamlls = {},
  html = {},
  cssls = {},
  marksman = {},
  taplo = {},
}

-- Setup each server
for server, config in pairs(servers) do
  config.capabilities = capabilities
  config.on_attach = on_attach
  config.handlers = handlers
  lspconfig[server].setup(config)
end

-- DAP minimal sugar
local dap_ok, dapui = pcall(require, "dapui")
if dap_ok then
  dapui.setup()
  local dap = require("dap")
  dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
  dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
  dap.listeners.before.event_exited["dapui_config"]      = function() dapui.close() end
end

---------------------------------------------------------------
-- 4) Keymaps you'll actually use (and remember)
---------------------------------------------------------------
local map = vim.keymap.set
-- Save, quit
map({"n","i","v"}, "<C-s>", function() vim.cmd("silent w") end, { desc = "Save" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })

-- Windows and tabs
map("n", "<leader>sv", ":vsplit<CR>", { desc = "Split vertical" })
map("n", "<leader>sh", ":split<CR>",  { desc = "Split horizontal" })
map("n", "<leader>to", ":tabnew<CR>",  { desc = "New tab" })

-- Telescope
map("n", "<leader>ff", function() require("telescope.builtin").find_files() end, { desc = "Find files" })
map("n", "<leader>fg", function() require("telescope.builtin").live_grep()  end, { desc = "Live grep" })
map("n", "<leader>fb", function() require("telescope.builtin").buffers()    end, { desc = "Buffers" })
map("n", "<leader>fh", function() require("telescope.builtin").help_tags()  end, { desc = "Help tags" })
map("n", "<leader>fp", function() require("telescope").extensions.projects.projects() end, { desc = "Projects" })

-- Move lines (visual)
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Clear search
map("n", "<Esc>", ":noh<CR>", { silent = true })

-- Format
map("n", "<leader>f", function() require("conform").format({ lsp_fallback = true }) end, { desc = "Format file" })

---------------------------------------------------------------
-- 5) Small QoL autocommands
---------------------------------------------------------------
-- Restore cursor to last position
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.highlight.on_yank({ higroup = "IncSearch", timeout = 120 }) end
})

-- Wayland clipboard fix hint (if clipboard missing)
if vim.env.WAYLAND_DISPLAY and vim.o.clipboard ~= "unnamedplus" then
  vim.notify("Tip: install 'wl-clipboard' and set clipboard=unnamedplus for system clipboard.", vim.log.levels.INFO)
end

---------------------------------------------------------------
-- 6) Add language tools via Mason: :Mason
--    Choose servers/formatters: pyright, ruff, lua_ls, clangd, rust_analyzer, bashls,
--    jsonls, yamlls, html, cssls, tsserver/ts_ls, marksman, taplo, fortls, etc.
--    Then enjoy: <leader>ff (files), <leader>fg (grep), <C-`> (terminal), - (Oil),
--    <leader>f (format), gd/gr/K, and :OverseerRun for project tasks.
---------------------------------------------------------------
