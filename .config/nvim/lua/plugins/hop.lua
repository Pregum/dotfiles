-- return {
--   {
--     "phaazon/hop.nvim",
--     branch = "v2",
--     config = function()
--       require("hop").setup({
--         multi_windows = true,
--       })
--     end,
--     keys = {
--       { mode = { "n", "v" }, "<leader>s", "<cmd>HopChar<CR>", desc = "Hop to 1 chars" },
--       { mode = { "n", "v" }, "<leader>w", "<cmd>HopWord<CR>", desc = "Hop to word" },
--       { mode = { "n", "v" }, "<leader>l", "<cmd>HopLine<CR>", desc = "Hop to line" },
--     },
--   },
-- }
return {
  {
    "smoka7/hop.nvim",
    version = "*",
    opts = {
      keys = "etovxqpdygfblzhckisuran",
    },
    config = function()
      require("hop").setup({
        multi_windows = true,
      })
    end,
    keys = {
      { mode = { "n", "v" }, "<leader>s", "<cmd>HopChar1<CR>", desc = "Hop to 1 chars" },
      { mode = { "n", "v" }, "<leader>w", "<cmd>HopWord<CR>", desc = "Hop to word" },
      { mode = { "n", "v" }, "<leader>l", "<cmd>HopLine<CR>", desc = "Hop to line" },
    },
  },
}
