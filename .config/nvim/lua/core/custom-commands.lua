vim.api.nvim_create_user_command(
	'FormatJSON',
	function()
		vim.cmd('%!jq .')
	end,
	{ desc = "Format the current buffer as JSON using jq" }
)
