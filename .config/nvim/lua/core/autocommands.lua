local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup('filetype_vim', { clear = true })

autocmd('FileType', {
	group = 'filetype_vim',
	pattern = { 'vim' },
	command = 'setlocal foldmethod=marker'
})

autocmd('FileType', {
	group = 'filetype_vim',
	pattern = { 'lua' },
	command = 'setlocal shiftwidth=2 tabstop=2'
})

autocmd(
	{
		'BufRead',
		'BufNewFile'
	},
	{
		group = 'filetype_vim',
		pattern = 'Vagrantfile,Gemfile,Capfile',
		command = 'set ft=ruby'
	}
)

autocmd('FileType', {
	group = 'filetype_vim',
	pattern = { 'rspec' },
	command = 'set ft=ruby'
})

autocmd('FileType', {
	group = 'filetype_vim',
	pattern = { 'ruby', 'eruby', 'scss', 'javascript', 'coffee', 'yml', 'yaml', 'markdown' },
	command = 'setlocal shiftwidth=2 softtabstop=2 expandtab'
})

autocmd('FileType', {
	group = 'filetype_vim',
	pattern = { 'python' },
	command = 'setlocal shiftwidth=4 softtabstop=4 expandtab autoindent'
})

autocmd(
	{
		"BufWritePre",
	},
	{
		group = "filetype_vim",
		pattern = { '*.lua', '*.rb' },
		command = "lua vim.lsp.buf.format()",
	}
)

autocmd("BufWritePre", {
	pattern = { "*.go", "*.py", "*.c", "*.cpp", "*.objc", "*.objcpp" },
	callback = function()
		local params = vim.lsp.util.make_range_params()
		params.context = { only = { "source.organizeImports" } }
		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 2000)
		for cid, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.edit then
					local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
					vim.lsp.util.apply_workspace_edit(r.edit, enc)
				end
			end
		end
		vim.lsp.buf.format({ async = false })
	end
})

autocmd("BufWritePre", {
	pattern = { "*.json" },
	callback = function()
		vim.cmd('%!jq .')
	end
})
