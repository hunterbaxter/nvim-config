-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  -- TODO: Remove branch v4 on release
  { "AstroNvim/astrocommunity", branch = "v4" },

  -- Colorschemes
  { import = "astrocommunity.colorscheme.github-nvim-theme" },
  -- Langs
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.terraform" },

  -- editing support
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
  -- git
  { import = "astrocommunity.git.octo-nvim" },

  { import = "astrocommunity.project.nvim-spectre" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  { import = "astrocommunity.editing-support.zen-mode-nvim" },

  -- Change option table for imported stuff
  {
    "nvim-pack/nvim-spectre",
    opts = function()
      return {
        highlight = {
          ui = "String",
          search = "DiagnosticInfo",
          replace = "DiagnosticWarn",
        },
      }
    end,
  },
  {
    -- community override
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = { "smoka7/hydra.nvim" },
    opts = {
      -- removing up/down bindings
      normal_keys = {
        ["k"] = { method = false },
        ["j"] = { method = false },
        ["z"] = { method = false },
      },
    },
  },
}
