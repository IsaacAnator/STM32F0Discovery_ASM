-- Local initialization: 
-- Comments character for .thumb assembly is '@'

-- Ensure .s files are recognized as assembly
vim.filetype.add({
  extension = { s = "asm" }
})

-- Set the commentstring for .s files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "asm",
  callback = function()
    vim.bo.commentstring = "@ %s"
  end,
})

-- Highlight everything after '@' as a comment
vim.api.nvim_create_autocmd({ "BufReadPost", "BufWinEnter", "TextChanged", "TextChangedI" }, {
  pattern = "*.s",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local ns = vim.api.nvim_create_namespace("asm_at_comment_highlight")
    vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

    -- Get total number of lines in buffer
    local line_count = vim.api.nvim_buf_line_count(bufnr)

    -- Loop through each line
    for lnum = 0, line_count - 1 do
      local line = vim.api.nvim_buf_get_lines(bufnr, lnum, lnum + 1, false)[1] or ""
      local at_pos = line:find("@") -- Find first '@' in line
      
      if at_pos then
        -- Highlight everything from '@' to end of line
        vim.api.nvim_buf_add_highlight(bufnr, ns, "Comment", lnum, at_pos - 1, -1)
      end
    end
  end,
})

