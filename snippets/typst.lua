---@diagnostic disable: undefined-global
-- Conditions
local make_condition = require("luasnip.extras.conditions").make_condition

local in_math = make_condition(function()
  local climber = vim.treesitter.get_node { include_anonymous = true }

  while climber do
    local climber_type = climber:type()

    if climber_type == "math" then
      return true
    end

    climber = climber:parent()
  end

  return false
end)

return {},{}
