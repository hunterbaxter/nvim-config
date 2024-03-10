-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
-- vim.filetype.add {
--   extension = {
--     foo = "fooscript",
--   },
--   filename = {
--     ["Foofile"] = "fooscript",
--   },
--   pattern = {
--     ["~/%.config/foo/.*"] = "fooscript",
--   },
-- }

-- NOTE: we are setting this here because we need to have the custom font choices set before actually calling the colorscheme, and it has to be last
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    -- https://gist.github.com/swarn/fb37d9eefe1bc616c2a7e476c0bc0316#changing-highlights
    vim.api.nvim_set_hl(0, "@lsp.mod.reference.rust", { italic = true })
    vim.api.nvim_set_hl(0, "@lsp.mod.mutable.rust", { bold = true })
    -- vim.api.nvim_set_hl(0, "@lsp.mod.reference.rust", { bold = true })
    -- vim.api.nvim_set_hl(0, "@lsp.mod.mutable.rust", { italic = true })
  end,
})
vim.cmd [[colorscheme github_light_colorblind]]
