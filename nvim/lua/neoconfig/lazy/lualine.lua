return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
--    local currentscheme = vim.cmd("echo g:colors_name")
    require("lualine").setup({
      options = {theme = "auto"}
    })
  end

}
