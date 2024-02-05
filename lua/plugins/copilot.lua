local M = {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function ()
        require('copilot').setup({})
    end,
    build = ":Copilot auth",
}

return M
