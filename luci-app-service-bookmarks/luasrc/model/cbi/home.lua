a = Map("service_bookmarks", translate("Service Bookmarks"), translate("List all available service bookmarks here"))
a.template = "service_bookmarks/home"
a.pageaction = false

t = a:section(TypedSection, "service", translate("Service Bookmarks"), translate("List all available service bookmarks here"))
t.template = "cbi/tblsection"
t.anonymous = true
t.addremove = false

e = t:option(DummyValue, "title", translate("Service Title"))
e.default = ""
e.rawhtml = true

e = t:option(DummyValue, "url", translate("Url Address"))
e.default = ""
e.rawhtml = true

e = t:option(DummyValue, "description", translate("Description"))
e.default = ""
e.rawhtml = true

return a