-- s = require("luasnip.nodes.snippet").S,
-- sn = require("luasnip.nodes.snippet").SN,
-- t = require("luasnip.nodes.textNode").T,
-- f = require("luasnip.nodes.functionNode").F,
-- i = require("luasnip.nodes.insertNode").I,
-- c = require("luasnip.nodes.choiceNode").C,
-- d = require("luasnip.nodes.dynamicNode").D,
-- r = require("luasnip.nodes.restoreNode").R,
-- l = require("luasnip.extras").lambda,
-- rep = require("luasnip.extras").rep,
-- p = require("luasnip.extras").partial,
-- m = require("luasnip.extras").match,
-- n = require("luasnip.extras").nonempty,
-- dl = require("luasnip.extras").dynamic_lambda,
-- fmt = require("luasnip.extras.fmt").fmt,
-- fmta = require("luasnip.extras.fmt").fmta,
-- conds = require("luasnip.extras.expand_conditions"),
-- types = require("luasnip.util.types"),
-- events = require("luasnip.util.events"),
-- parse = require("luasnip.util.parser").parse_snippet,
-- ai = require("luasnip.nodes.absolute_indexer"),

local require_var = function(args, _)
  local text = args[1][1] or ""
  local split = vim.split(text, ".", { plain = true })

  local options = {}
  for len = 0, #split - 1 do
    table.insert(options, t(table.concat(vim.list_slice(split, #split - len, #split), "_")))
  end

  return sn(nil, {
    c(1, options),
  })
end

return {
  s("req", fmt([[local {} = require("{}")]], {
    d(2, require_var, { 1 }),
    i(1),
  })),
}
