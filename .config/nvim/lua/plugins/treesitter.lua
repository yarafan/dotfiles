return {
  {
    "HiPhish/rainbow-delimiters.nvim",
    version = "*",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    version = "*",
    dependencies = {
      "HiPhish/rainbow-delimiters.nvim",
    },
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })()
    end,
  }
}

