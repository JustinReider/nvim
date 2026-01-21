local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s("dp", {
    t('echo("<pre>");'),
    t({"", "var_dump("}), i(1), t(");"),
    t({"", 'echo("</pre>");'}),
    t({"", "die();"}),
  }),
}
