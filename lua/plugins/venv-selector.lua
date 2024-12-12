return {
  "linux-cultist/venv-selector.nvim",
  branch = "regexp", -- Use this branch for the new version
  opts = {
    settings = {
      search = {
        anaconda_envs = {
          command = "fd /bin/python$ /home/dy/anaconda3/envs --full-path --color never -E /proc",
          type = "anaconda",
        },
      },
    },
  },
}
