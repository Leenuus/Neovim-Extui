-- NOTE:
-- this one split a window
-- and route messages to this window

local ns = vim.api.nvim_create_namespace("fancy-ext-messages")

-- first do:
-- vnew
-- lua vim.fn.bufnr()
-- run above lua code in the split window
-- and get the bufnr(fancy way of saying buffer number)
local buf = 52
-- lua vim.api.nvim_get_current_win()
-- run above lua code in the split window
-- and get the winid
local win = 1126

-- set scratch buffer
vim.bo[buf].buftype='nofile'
vim.bo[buf].bufhidden='hide'
vim.bo[buf].noswapfile=true

vim.ui_attach(ns, { ext_messages = true }, function(event, ...)
	-- ["msg_show", kind, content, replace_last]
	local l = { ... }
	if event == "msg_show" then
		local kind = l[1]
		local content = l[2]
		for _, entry in ipairs(content) do
			local id = entry[1]
			local text = entry[2]
			vim.api.nvim_buf_set_lines(buf, 0, 0, false, { id .. ': ' .. text })
		end
	end
end)
