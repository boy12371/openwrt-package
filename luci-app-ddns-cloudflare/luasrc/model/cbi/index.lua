local a = Map("ddns_cloudflare", translate("DDNS Cloudflare"), "")
a.template = "ddns_cloudflare/index"
a.pageaction = false

local t = a:section(TypedSection, "base", "", translate("List all available service bookmarks here"))
t.template = "cbi/tblsection"
t.anonymous = true
t.addremove = false

local e = t:option(DummyValue, "enabled", translate("Service Title"))
e.default = ""
e.rawhtml = false

e = t:option(DummyValue, "cloudflare_sn", translate("Url Address"))
e.rawhtml = true

return a