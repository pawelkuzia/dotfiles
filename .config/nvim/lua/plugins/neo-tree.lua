return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    config = function()
      require("neo-tree").setup({
        source_selector = {
          winbar = true,
          statusline = false,
        },
        window = {
          mappings = {
            ["P"] = {
              "toggle_preview",
              config = {
                use_float = true,
                title = "Neo-tree Preview",
              },
            },
          },
        },
        filesystem = {
        filtered_items = {
            visible = true,  -- Set to true to show hidden files
            hide_dotfiles = false,  -- This ensures dotfiles are visible
            hide_gitignored = true,  -- Keep this true if you want to hide gitignored files
        },
    },
      })
    end,
  },
}
