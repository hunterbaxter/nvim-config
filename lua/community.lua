-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  -- TODO: Remove branch v4 on release
  { "AstroNvim/astrocommunity", branch = "v4" },

  -- Colorschemes
  { import = "astrocommunity.colorscheme.github-nvim-theme", branch = "v4" },
  -- Langs
  { import = "astrocommunity.pack.lua", branch = "v4" },
  { import = "astrocommunity.pack.rust", branch = "v4" },
  { import = "astrocommunity.pack.toml", branch = "v4" },
  { import = "astrocommunity.pack.python", branch = "v4" },
  { import = "astrocommunity.pack.json", branch = "v4" },
  { import = "astrocommunity.pack.html-css", branch = "v4" },
  -- editing support
  { import = "astrocommunity.editing-support.todo-comments-nvim", branch = "v4" },
  -- git
  { import = "astrocommunity.git.octo-nvim", branch = "v4" },

  { import = "astrocommunity.project.nvim-spectre", branch = "v4" },
  { import = "astrocommunity.diagnostics.trouble-nvim", branch = "v4" },
  { import = "astrocommunity.editing-support.zen-mode-nvim", branch = "v4" },
  -- { import = "astrocommunity.lsp.lsp-inlayhints-nvim", branch = "v4" },
}
