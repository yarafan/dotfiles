local dap_ok, dap = pcall(require, "dap")
if not dap_ok then
	return
end

local dapgo_ok, dapgo = pcall(require, "dap-go")
if not dapgo_ok then
	return
end

local dapui_ok, dapui = pcall(require, "dapui")
if not dapui_ok then
	return
end

dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end

dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end

dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end

dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

require("nvim-dap-virtual-text").setup()
dapui.setup()
dapgo.setup()
