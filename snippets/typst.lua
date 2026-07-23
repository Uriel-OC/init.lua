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

return {},{
  -- Delimiters
  s("$", fmta("$<>$", i(1)), { condition = - in_math }),
  s("(", fmta("(<>)", i(1)), { condition = in_math }),
  s("[", fmta("[<>]", i(1)), { condition = in_math }),
  s("{", fmta("{<>}", i(1)), { condition = in_math }),
  -- Scripts
  s("^", fmt("^({})", i(1)), { condition = in_math }),
  s("_", fmt("_({})", i(1)), { condition = in_math }),
  -- Symbols
  s("infty", t("infinity"), { condition = in_math }),
  s("mid", fmt("mid({})", i(1)), { condition = in_math }),
  -- Operations
  s("abs", fmt("abs({})", i(1)), { condition = in_math }),
  s("norm", fmt("norm({})", i(1)), { condition = in_math }),
  s("floor", fmt("floor({})", i(1)), { condition = in_math }),
  s("ceil", fmt("ceil({})", i(1)), { condition = in_math }),
  s("frac", fmt("frac({},{})", { i(1), i(2) }), { condition = in_math }),
  s("sint", fmt("integral_({})", i(1)), { condition = in_math }),
  s("bint", fmt("integral_({})^({})", { i(1), i(2) }), { condition = in_math }),
  s("ssum", fmt("sum_({})", i(1)), { condition = in_math }),
  s("sum", fmt("sum_({}={})^({})", { i(1), i(2), i(3) }), { condition = in_math }),
  s("sprod", fmt("product_({})", i(1)), { condition = in_math }),
  s("prod", fmt("product_({}={})^({})", { i(1), i(2), i(3) }), { condition = in_math }),
  s("bcap", fmt("inter.big_({}={})^({})", { i(1), i(2), i(3) }), { condition = in_math }),
  s("scap", fmt("inter.big_({})", { i(1) }), { condition = in_math }),
  s("bcup", fmt("union.big({}={})^({})", { i(1), i(2), i(3) }), { condition = in_math }),
  s("scup", fmt("union.big_({})", { i(1) }), { condition = in_math }),
  -- Math letters
  postfix(".bb", {
    l(l.POSTFIX_MATCH:sub(1, -2) .. "bb(" .. l.POSTFIX_MATCH:sub(-1) .. ")"),
  }, { conditions = in_math }),
  postfix(".cal", {
    l(l.POSTFIX_MATCH:sub(1, -2) .. "cal(" .. l.POSTFIX_MATCH:sub(-1) .. ")"),
  }, { conditions = in_math }),
  postfix(".scr", {
    l(l.POSTFIX_MATCH:sub(1, -2) .. "scr(" .. l.POSTFIX_MATCH:sub(-1) .. ")"),
  }, { conditions = in_math }),
  postfix(".frak", {
    l(l.POSTFIX_MATCH:sub(1, -2) .. "frak(" .. l.POSTFIX_MATCH:sub(-1) .. ")"),
  }, { conditions = in_math }),
  -- Others
  s("lbl", fmt("<eq:{}>", i(1)), { condition = conds.line_end * in_math })
}
