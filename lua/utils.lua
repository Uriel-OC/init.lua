local M = {}

M.create_spell_keymap = function()
  vim.keymap.set("n", "<leader>ts", function()
    local winid = vim.api.nvim_get_current_win()
    if not vim.o.spell then
      vim.ui.select({ "es_mx", "en_us" }, { prompt = "Lang: " }, function(choice)
        vim.bo.spelllang = choice
      end)
      vim.wo[winid][0].spell = true
    else
      vim.bo.spelllang = ""
      vim.wo[winid][0].spell = false
    end
  end, { desc = "Toggle spell check", buffer = true })
end

return M
