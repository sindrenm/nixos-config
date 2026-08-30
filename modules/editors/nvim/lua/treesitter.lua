-- Parsers are installed via Nix (see startupPlugins in editors.nix), so this
-- just needs to start highlighting for whatever filetypes have one available.
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})
