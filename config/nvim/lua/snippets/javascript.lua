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

return {
  s("cl", fmt("console.log({});", i(1))),

  s({
    trig = "imp",
    dscr = "Import default module",
  }, fmt([[import {} from "{}";]], { i(2), i(1) })),

  s({
    trig = "imd",
    dscr = "Import named import",
  }, fmt([[import {{ {} }} from "{}";]], { i(2), i(1) })),

  s({
    trig = "ime",
    dscr = "Import as",
  }, fmt([[import * as {} from "{}";]], { i(2), i(1) })),

  s({
    trig = "fof",
    dscr = "for...of loop",
  }, fmt("for (const {} of {}) {{\n  {}\n}}", { i(1), i(2), i(0) })),

  s(
    "fn",
    fmt("function {}({}) {{\n  {}\n}} ", {
      i(1),
      i(2),
      i(0),
    })
  ),

  s("db", fmt("/**\n * {}\n */", { i(0) })),

  s({
    trig = "dpl",
    dscr = "Set debug print limit",
  }, fmt("process.env.DEBUG_PRINT_LIMIT = Infinity;", {})),

  s({
    trig = "sdb",
    dscr = "Debug entire screen",
  }, fmt("screen.debug(undefined, Infinity);", {})),
}
