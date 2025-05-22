local a = Map("service_bookmarks", translate("Service Bookmarks"), "")
a.template = "service_bookmarks/settings"

local t = a:section(TypedSection, "service", "", translate("Set service bookmarks here, which can include any service elements like title, url, description..."))
t.template = "cbi/tblsection"
t.addremove = true

local e = t:option(Value, "title", translate("Service Title"))
e.width = "15%"
e.rmempty = true

e = t:option(Value, "url", translate("Url Address"))
e.width = "40%"
e.rmempty = true

e = t:option(Value, "description", translate("Description"))
e.width = "45%"
e.rmempty = false

return a