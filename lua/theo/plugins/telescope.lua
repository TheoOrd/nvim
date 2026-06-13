return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope", "ProjectReplace" },
    keys = {
      {
        "<leader>pf",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = "Find files",
      },
      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = "Find files",
      },
      {
        "<leader>fg",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Live grep",
      },
      {
        "<leader>ps",
        function()
          require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
        end,
        desc = "Grep prompt",
      },
      {
        "<leader>pr",
        ":ProjectReplace ",
        desc = "Project replace prompt",
      },
      {
        "<leader>fb",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "Buffers",
      },
      {
        "<leader>fh",
        function()
          require("telescope.builtin").help_tags()
        end,
        desc = "Help tags",
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function(_, opts)
      require("telescope").setup(opts)

      vim.api.nvim_create_user_command("ProjectReplace", function(args)
        local from = args.fargs[1]
        local to = args.fargs[2]

        if not from or not to then
          vim.notify("Usage: ProjectReplace <from> <to> [a]", vim.log.levels.ERROR)
          return
        end

        if vim.fn.executable("rg") ~= 1 then
          vim.notify("ProjectReplace requires ripgrep", vim.log.levels.ERROR)
          return
        end

        local lines = vim.fn.systemlist({
          "rg",
          "--vimgrep",
          "--hidden",
          "-g",
          "!node_modules",
          "-g",
          "!.git",
          from,
          ".",
        })

        if vim.v.shell_error > 1 then
          vim.notify(table.concat(lines, "\n"), vim.log.levels.ERROR)
          return
        end

        if #lines == 0 then
          vim.notify("No matches for: " .. from, vim.log.levels.INFO)
          return
        end

        vim.fn.setqflist({}, " ", {
          title = "ProjectReplace: " .. from,
          lines = lines,
          efm = "%f:%l:%c:%m",
        })
        vim.cmd.copen()

        local search = vim.fn.escape(from, [[\/]])
        local replacement = vim.fn.escape(to, [[\/&]])
        local flags = args.fargs[3] == "a" and "g" or "gc"

        vim.cmd(("cfdo %%s/%s/%s/%s | update"):format(search, replacement, flags))
      end, { nargs = "+" })
    end,
    opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = " ",
      },
    },
  },
}
