local a = Map("ddns_cloudflare", translate("DDNS Cloudflare"))
a.template = "ddns_cloudflare/index"
a.pageaction = false

local t = m:section(NamedSection, "base", nil, "Facebook",
              translate("You can register your own Facebook app and use its parameters here."))

-- local t = a:section(TypedSection, "base", "", translate("List all available service bookmarks here"))
-- t.template = "cbi/tblsection"
-- t.anonymous = true
-- t.addremove = false

local e = t:option(Value, "enabled", translate("Service Title"))
e.default = ""
e.rawhtml = false

e = t:option(Value, "interval", translate("Url Address"))
e.rawhtml = true

e = t:option(Value, "cloudflare_sn", translate("Url Address"))
e.rawhtml = true

return a