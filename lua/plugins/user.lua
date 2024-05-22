-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {
  {
    -- https://github.com/m4xshen/hardtime.nvim
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    event = "User AstroFile",
    opts = {
      max_count = 5,
      disable_mouse = false,
      -- Defaults are terrible - arrow keys are necessary for LSP rename unfortunately
      disabled_filetypes = {
        "qf",
        "netrw",
        "NvimTree",
        "lazy",
        "mason",
        "oil",
        "neo-tree",
        "Scratch",
        "aerial",
        "spectre",
      },
      disabled_keys = {
        ["<Up>"] = {},
        ["<Down>"] = {},
        ["<Left>"] = {},
        ["<Right>"] = {},
      },
    },
    config = function(_, opts)
      require("hardtime").setup(opts)
      require("hardtime").enable()
    end,
  },
  -- 
  {
    "folke/todo-comments.nvim",
    opts = {
      signs = true, -- show icons in the signs column
      sign_priority = 8, -- sign priority
      -- keywords recognized as todo comments
      keywords = {
        FIX = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        WIP = { icon = " ", color = "test" },
      },
      gui_style = {
        fg = "NONE", -- The gui style to use for the fg highlight group.
        bg = "BOLD", -- The gui style to use for the bg highlight group.
      },
      merge_keywords = true, -- when true, custom keywords will be merged with the defaults
      -- highlighting of the line containing the todo comment
      -- * before: highlights before the keyword (typically comment characters)
      -- * keyword: highlights of the keyword
      -- * after: highlights after the keyword (todo text)
      highlight = {
        multiline = true, -- enable multine todo comments
        multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
        multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
        before = "", -- "fg" or "bg" or empty
        keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
        after = "fg", -- "fg" or "bg" or empty
        pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
        comments_only = true, -- uses treesitter to match keywords in comments only
        max_line_len = 400, -- ignore lines longer than this
        exclude = {}, -- list of file types to exclude highlighting
      },
      -- list of named colors where we try to extract the guifg from the
      -- list of highlight groups or use the hex color if hl not found as a fallback
      colors = {
        error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
        warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
        info = { "DiagnosticInfo", "#2563EB" },
        -- hint = { "DiagnosticHint", "#10B981" },
        hint = { "#800080" },
        default = { "Identifier", "#7C3AED" },
        test = { "Identifier", "#FF00FF" },
      },
      search = {
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        },
        -- regex that will be used to match keywords.
        -- don't replace the (KEYWORDS) placeholder
        pattern = [[\b(KEYWORDS):]], -- ripgrep regex
        -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
      },
    },
    event = "User AstroFile",
    cmd = { "TodoTrouble", "TodoTelescope", "TodoLocList", "TodoQuickFix" },
  },
  {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = { "smoka7/hydra.nvim" },
    opts = {},
    keys = {
      {
        mode = { "v", "n" },
        "<Leader>m",
        "<cmd>MCunderCursor<cr>",
        desc = "Create a MC under cursor",
      },
    },
  },
  {
    "LudoPinelli/comment-box.nvim",
    event = "User AstroFile",
    opts = {},
  },
  -- -- FIXME: this does not appear to be working, but its ok we barely ever use, but it is nice occasionally
  -- {
  --
  --   "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  --   event = "LspAttach",
  --   keys = {
  --     {
  --       "<Leader>uD",
  --       function()
  --         vim.diagnostic.config {
  --           virtual_text = not require("lsp_lines").toggle(),
  --         }
  --       end,
  --       desc = "Toggle virtual diagnostic lines",
  --     },
  --   },
  --   opts = {},
  --   config = function(_, opts)
  --     -- disable diagnostic virtual text
  --     local lsp_utils = require "astronvim.utils.lsp"
  --     lsp_utils.diagnostics[3].virtual_text = false
  --     vim.diagnostic.config(lsp_utils.diagnostics[vim.g.diagnostics_mode])
  --     require("lsp_lines").setup(opts)
  --
  --     -- HACK: we are essentially just hitting the key immediately because I can't figure out how to have it off by default
  --     vim.diagnostic.config {
  --       virtual_text = not require("lsp_lines").toggle(),
  --     }
  --   end,
  -- },

  -- == Examples of Adding Plugins ==

  -- TODO: do I want this?
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function() require("lsp_signature").setup() end,
  -- },

  -- == Examples of Overriding Plugins ==
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        " ██░ ██ ▓█████  ██▓     ██▓     ▒█████      ██░ ██  █    ██  ███▄    █ ▄▄▄█████▓▓█████  ██▀███   ",
        "▓██░ ██▒▓█   ▀ ▓██▒    ▓██▒    ▒██▒  ██▒   ▓██░ ██▒ ██  ▓██▒ ██ ▀█   █ ▓  ██▒ ▓▒▓█   ▀ ▓██ ▒ ██▒ ",
        "▒██▀▀██░▒███   ▒██░    ▒██░    ▒██░  ██▒   ▒██▀▀██░▓██  ▒██░▓██  ▀█ ██▒▒ ▓██░ ▒░▒███   ▓██ ░▄█ ▒ ",
        "░▓█ ░██ ▒▓█  ▄ ▒██░    ▒██░    ▒██   ██░   ░▓█ ░██ ▓▓█  ░██░▓██▒  ▐▌██▒░ ▓██▓ ░ ▒▓█  ▄ ▒██▀▀█▄   ",
        "░▓█▒░██▓░▒████▒░██████▒░██████▒░ ████▓▒░   ░▓█▒░██▓▒▒█████▓ ▒██░   ▓██░  ▒██▒ ░ ░▒████▒░██▓ ▒██▒ ",
        " ▒ ░░▒░▒░░ ▒░ ░░ ▒░▓  ░░ ▒░▓  ░░ ▒░▒░▒░     ▒ ░░▒░▒░▒▓▒ ▒ ▒ ░ ▒░   ▒ ▒   ▒ ░░   ░░ ▒░ ░░ ▒▓ ░▒▓░ ",
        " ▒ ░▒░ ░ ░ ░  ░░ ░ ▒  ░░ ░ ▒  ░  ░ ▒ ▒░     ▒ ░▒░ ░░░▒░ ░ ░ ░ ░░   ░ ▒░    ░     ░ ░  ░  ░▒ ░ ▒░ ",
        " ░  ░░ ░   ░     ░ ░     ░ ░   ░ ░ ░ ▒      ░  ░░ ░ ░░░ ░ ░    ░   ░ ░   ░         ░     ░░   ░  ",
        " ░  ░  ░   ░  ░    ░  ░    ░  ░    ░ ░      ░  ░  ░   ░              ░             ░  ░   ░      ",
        "                                                                                                 ",
      }
      opts.section.header.opts.hl = "Error"
      return opts
    end,
  },
  -----------------------------------------------------------------------------
  -- TODO: We are doing this because Neovim 0.9 does NOT support inlay hints, so we need both a plugin and custom rustaceanvim settings. Once we upgrade our neovim, we need to change this!
  -----------------------------------------------------------------------------
  {
    "lvimuser/lsp-inlayhints.nvim",
    dependencies = {
      "AstroNvim/astrocore",
      opts = {
        autocmds = {
          LspAttach_inlayhints = {
            {
              event = "LspAttach",
              callback = function(args)
                if not (args.data and args.data.client_id) then return end
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client and client.server_capabilities.inlayHintProvider then
                  local inlayhints = require "lsp-inlayhints"
                  inlayhints.on_attach(client, args.buf)
                  require("astrocore").set_mappings({
                    n = {
                      ["<Leader>uh"] = { inlayhints.toggle, desc = "Toggle inlay hints" },
                    },
                  }, { buffer = args.buf })
                end
              end,
            },
          },
        },
      },
    },
    init = function()
      -- WARN: we need to remember to disable this
      -- require("astrocore").notify("`lsp-inlayhints.nvim` has been archived and is now read only!", vim.log.levels.WARN)
    end,
    opts = {},
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^3",
    ft = "rust",
    opts = function()
      local adapter
      local success, package = pcall(function() return require("mason-registry").get_package "codelldb" end)
      local cfg = require "rustaceanvim.config"
      if success then
        local package_path = package:get_install_path()
        local codelldb_path = package_path .. "/codelldb"
        local liblldb_path = package_path .. "/extension/lldb/lib/liblldb"
        local this_os = vim.loop.os_uname().sysname

        -- The path in windows is different
        if this_os:find "Windows" then
          codelldb_path = package_path .. "\\extension\\adapter\\codelldb.exe"
          liblldb_path = package_path .. "\\extension\\lldb\\bin\\liblldb.dll"
        else
          -- The liblldb extension is .so for linux and .dylib for macOS
          liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
        end
        adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path)
      else
        -- this isn't actually an error
        adapter = cfg.get_codelldb_adapter()
      end

      local astrolsp_avail, astrolsp = pcall(require, "astrolsp")
      return {
        server = astrolsp_avail and astrolsp.lsp_opts "rust_analyzer",
        dap = { adapter = adapter },
        inlay_hints = {
          highlight = "NonText",
        },
      }
    end,
    config = function(_, opts) vim.g.rustaceanvim = require("astrocore").extend_tbl(opts, vim.g.rustaceanvim) end,
  },
  -----------------------------------------------------------------------------
  -- End rust config
  -----------------------------------------------------------------------------

  -- You can disable default plugins as follows:
  -- { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts)
      require("luasnip.loaders.from_vscode").lazy_load {
        paths = { vim.fn.stdpath "config" .. "/snippets" },
      }
    end,
  },
}
