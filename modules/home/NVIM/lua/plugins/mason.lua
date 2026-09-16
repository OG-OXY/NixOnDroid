---@type LazySpec
return {
  { "WhoIsSethDaniel/mason-tool-installer.nvim", enabled = false },
  { "williamboman/mason-lspconfig.nvim", enabled = false },
  { "jay-babu/mason-null-ls.nvim", enabled = false },
  { "williamboman/mason.nvim", enabled = false, opts = {
    ensure_installed = {},
  } },
}
