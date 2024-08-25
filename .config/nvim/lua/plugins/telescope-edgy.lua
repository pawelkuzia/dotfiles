return {
  "nvim-telescope/telescope.nvim",
  optional = true,
  opts = {
    defaults = {
      get_selection_window = function()
        require("edgy").goto_main()
        return 0
      end,
    },
  },
}
