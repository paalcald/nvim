local M = {
   "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    config = function ()
        local ibl = require("ibl")
        ibl.setup()
    end
}
return M
