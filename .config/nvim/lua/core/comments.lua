local cstring_ok, cstring = pcall(require, "ts_context_commentstring")
if not cstring_ok then
  return
end

local comment_ok, comment = pcall(require, "Comment")
if not comment_ok then
  return
end

cstring.setup {
  enable_autocmd = false,
}

comment.setup {
  pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
}
