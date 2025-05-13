a = Map("service_bookmarks", translate("Service Bookmarks"), translate("Set service bookmarks here, which can include any service elements like title, url, description..."))
a.template = "service_bookmarks/home"
a.pageaction = false

t = a:section(TypedSection, "service", translate("Service Bookmarks"), translate("Set service bookmarks here, which can include any service elements like title, url, description..."))
t.template = "cbi/tblsection"
t.anonymous = true
t.addremove = false

e = t:option(Value, "title", translate("Service Title"))
e.rmempty = true

e = t:option(Value, "url", translate("Url Address"))
e.rmempty = true

e = t:option(Value, "description", translate("Description"))
e.rmempty = false

return a
