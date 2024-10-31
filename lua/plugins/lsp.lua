return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      vtsls = {
        settings = {
          autoUseWorkspaceTsdk = false,
        },
      },
    },
  },
}
