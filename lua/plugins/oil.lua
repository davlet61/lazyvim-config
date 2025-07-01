-- return {
--   "nvim-neo-tree/neo-tree.nvim",
--   opts = {
--     close_if_last_window = true,
--     enable_diagnostics = true,
--     filesystem = {
--       filtered_items = {
--         visible = true,
--         hide_dotfiles = false,
--         hide_gitignored = true,
--         hide_by_name = {
--           ".git",
--           ".DS_Store",
--           "thumbs.db",
--         },
--       },
--     },
--     sort_case_insensitive = true,
--     group_empty_dirs = true,
--     window = {
--       position = "right",
--     },
--     event_handlers = {
--       {
--         event = "neo_tree_buffer_enter",
--         handler = function()
--           vim.opt_local.cursorline = true
--           vim.api.nvim_set_hl(0, "NeotreeCursorLine", { bg = "#2a3834" })
--         end,
--       },
--     },
--   },
-- }

return {
  {
    "stevearc/oil.nvim",
    opts = function()
      -- helper function to parse output
      local function parse_output(proc)
        local result = proc:wait()
        local ret = {}
        if result.code == 0 then
          for line in vim.gsplit(result.stdout, "\n", { plain = true, trimempty = true }) do
            -- Remove trailing slash
            line = line:gsub("/$", "")
            ret[line] = true
          end
        end
        return ret
      end

      -- build git status cache
      local function new_git_status()
        return setmetatable({}, {
          __index = function(self, key)
            local ignore_proc = vim.system(
              { "git", "ls-files", "--ignored", "--exclude-standard", "--others", "--directory" },
              {
                cwd = key,
                text = true,
              }
            )
            local tracked_proc = vim.system({ "git", "ls-tree", "HEAD", "--name-only" }, {
              cwd = key,
              text = true,
            })
            local ret = {
              ignored = parse_output(ignore_proc),
              tracked = parse_output(tracked_proc),
            }
            rawset(self, key, ret)
            return ret
          end,
        })
      end

      local git_status = new_git_status()
      local detail = false

      return {
        default_file_explorer = true,
        keymaps = {
          ["<leader>."] = { "actions.toggle_hidden", mode = "n" },
          ["gd"] = {
            desc = "Toggle file detail view",
            callback = function()
              detail = not detail
              if detail then
                require("oil").set_columns { "icon", "permissions", "size", "mtime" }
              else
                require("oil").set_columns { "icon" }
              end
            end,
          },
        },
        view_options = {
          is_hidden_file = function(name, bufnr)
            local oil = require "oil"
            local dir = oil.get_current_dir(bufnr)
            local is_dotfile = vim.startswith(name, ".") and name ~= ".."
            -- if no local directory (e.g. for ssh connections), just hide dotfiles
            if not dir then return is_dotfile end
            -- dotfiles are considered hidden unless tracked
            if is_dotfile then
              return not git_status[dir].tracked[name]
            else
              -- Check if file is gitignored
              return git_status[dir].ignored[name]
            end
          end,
        },
        win_options = {
          signcolumn = "yes:2",
        },
      }
    end,
    config = function(_, opts)
      local oil = require "oil"
      oil.setup(opts)

      -- Set up refresh hook after oil is loaded
      local refresh = require("oil.actions").refresh
      local orig_refresh = refresh.callback
      refresh.callback = function(...)
        git_status = new_git_status()
        orig_refresh(...)
      end
    end,
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
  },
  {
    "refractalize/oil-git-status.nvim",

    dependencies = {
      "stevearc/oil.nvim",
    },

    config = true,
  },
}
