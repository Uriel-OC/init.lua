---@diagnostic disable: undefined-global
-- Conditions
local make_condition = require("luasnip.extras.conditions").make_condition

local in_math = make_condition(function()
  local math_nodes = {
    "math_delimiter",
    "inline_formula",
    "displayed_equation",
    "math_environment"
  }
  local stop_nodes = { "label_definition", "text_mode", "begin", "end" }

  local climber = vim.treesitter.get_node()

  while climber do
    local climber_type = climber:type()

    if vim.list_contains(stop_nodes, climber_type) then
      return false
    elseif vim.list_contains(math_nodes, climber_type) then
      return true
    end

    climber = climber:parent()
  end

  return false
end)

return {}, {
  -- Delimiters
  s([[\(]], fmta([[\(<>\)]], i(1)), { condition = - in_math }),
  s([[\[]], fmta("\\[<>\\]", i(1)), { condition = - in_math }),
  s([[\{]], fmta([[\{<>\}]], i(1)), { condition = in_math }),
  -- Scripts
  s("^", fmta("^{<>}", i(1)), { condition = in_math }),
  s("_", fmta("_{<>}", i(1)), { condition = in_math }),
  -- Symbols
  s("infty", t([[\infty]]), { condition = in_math }),
  s("then", t([[\implies]]), { condition = in_math }),
  s("iff", t([[\iff]]), { condition = in_math }),
  s("to", t([[\to]]), { condition = in_math }),
  -- Operations
  s("abs", fmta([[|<>|]], i(1)), { condition = in_math }),
  s("frac", fmta([[\frac{<>}{<>}]], { i(1), i(2) }), { condition = in_math }),
  s("sint", fmta([[\int_{<>}]], i(1)), { condition = in_math }),
  s("bint", fmta([[\int_{<>}^{<>}]], { i(1), i(2) }), { condition = in_math }),
  s("ssum", fmta([[\sum_{<>}]], i(1)), { condition = in_math }),
  s("sum", fmta([[\sum_{<>}^{<>}]], { i(1), i(2) }), { condition = in_math }),
  s("sprod", fmta([[\sum_{<>}]], i(1)), { condition = in_math }),
  s("prod", fmta([[\sum_{<>}^{<>}]], { i(1), i(2) }), { condition = in_math }),
  -- Math letters
  postfix(".bb", {
    l(l.POSTFIX_MATCH:sub(1, -2) .. "\\mathbb{" .. l.POSTFIX_MATCH:sub(-1) .. "}"),
  }, { conditions = in_math }),
  postfix(".cal", {
    l(l.POSTFIX_MATCH:sub(1, -2) .. "\\mathcal{" .. l.POSTFIX_MATCH:sub(-1) .. "}"),
  }, { conditions = in_math }),
  postfix(".scr", {
    l(l.POSTFIX_MATCH:sub(1, -2) .. "\\mathscr{" .. l.POSTFIX_MATCH:sub(-1) .. "}"),
  }, { conditions = in_math }),
  postfix(".frak", {
    l(l.POSTFIX_MATCH:sub(1, -2) .. "\\mathfrak{" .. l.POSTFIX_MATCH:sub(-1) .. "}"),
  }, { conditions = in_math }),
  -- Others
  s("nnum", t([[\nonumber]]), { condition = conds.line_end * in_math }),
  s("text", fmta([[\text{<>}]], i(1)), { condition = in_math }),
  s("lbl", fmta([[\label{eq:<>}]], i(1)), { condition = conds.line_end * in_math })
}
