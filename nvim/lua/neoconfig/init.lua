require("neoconfig.set")
require("neoconfig.remap")
require("neoconfig.lazy_init")



local augroup = vim.api.nvim_create_augroup
local neoconfiggroup = augroup('neoconfiggroup', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 60,
        })
    end,
})

