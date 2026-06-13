return {
  "tpope/vim-fugitive",
  config = function() 
    vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

    local neoconfig_fugitive = vim.api.nvim_create_augroup("neoconfig_fugitive", {})

    local autocmd = vim.api.nvim_create_autocmd
    autocmd("BufWinEnter", {
      group = neoconfig_fugitive, 
      pattern = "*",
      callback = function()
        if vim.bo.ft ~= "fugitive" then
          return
        end
      end,
    })
  end
}
