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
    },
    config = function(_, opts)
      require("hardtime").setup(opts)
      require("hardtime").enable()
    end,
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
  -- {
  --   "L3MON4D3/LuaSnip",
  --   config = function(plugin, opts)
  --     require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- add more custom luasnip configuration such as filetype extend or custom snippets
  --     local luasnip = require "luasnip"
  --     luasnip.filetype_extend("javascript", { "javascriptreact" })
  --   end,
  -- },

  -- {
  --   "windwp/nvim-autopairs",
  --   config = function(plugin, opts)
  --     require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- add more custom autopairs configuration such as custom rules
  --     local npairs = require "nvim-autopairs"
  --     local Rule = require "nvim-autopairs.rule"
  --     local cond = require "nvim-autopairs.conds"
  --     npairs.add_rules(
  --       {
  --         Rule("$", "$", { "tex", "latex" })
  --           -- don't add a pair if the next character is %
  --           :with_pair(cond.not_after_regex "%%")
  --           -- don't add a pair if  the previous character is xxx
  --           :with_pair(
  --             cond.not_before_regex("xxx", 3)
  --           )
  --           -- don't move right when repeat character
  --           :with_move(cond.none())
  --           -- don't delete if the next character is xx
  --           :with_del(cond.not_after_regex "xx")
  --           -- disable adding a newline when you press <cr>
  --           :with_cr(cond.none()),
  --       },
  --       -- disable for .vim files, but it work for another filetypes
  --       Rule("a", "a", "-vim")
  --     )
  --   end,
  -- },
}
