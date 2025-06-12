return {
	{
		"HiPhish/rainbow-delimiters.nvim",
		-- version = "*",
		branch = "master",
	},
	{
		"nvim-treesitter/nvim-treesitter",
		-- version = "*",
		branch = "master",
		dependencies = {
			"HiPhish/rainbow-delimiters.nvim",
		},
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })()
		end,
	}
}
