function ColorMyPencils(color)
  color = color or "rose-pine"
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

function SetTheme()
    ColorMyPencils("rose-pine")
end


return {
  {
    "LunarVim/darkplus.nvim",
    name = "darkplus"
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "sainnhe/gruvbox-material",
    name = "gruvbox-material",
    config = function ()
      vim.o.background = "dark"

      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_foreground = "original"
    end

  },
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme"
  },
  {
    'ribru17/bamboo.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('bamboo').setup {
        -- optional configuration here
      }
      require('bamboo').load()
    end,
  },
  {
    "olimorris/onedarkpro.nvim",
    name = "onedarkpro",
    config = function()
      require('onedarkpro').setup({
        options = {
          transparency = true,
          cursorline = false,
          terminal_colors = true,
        }
      })
      SetTheme()
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require('rose-pine').setup({
        disable_background = true,
        styles = {
          italic = false,
        },
      })
      SetTheme()
    end
  }
}
