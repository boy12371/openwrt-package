local a = Map("service_bookmarks", translate("Service Bookmarks"), "")
a.template = "service_bookmarks/home"
a.pageaction = false

local t = a:section(TypedSection, "service", "", translate("List all available service bookmarks here"))
t.template = "cbi/tblsection"
t.anonymous = true
t.addremove = false

local e = t:option(DummyValue, "title", translate("Service Title"))
e.default = ""
e.width = "15%"
e.rawhtml = false

e = t:option(DummyValue, "url", translate("Url Address"))
e.rawhtml = true
e.width = "40%"
function e.cfgvalue(self, section)
    local url = self.map:get(section, "url") or ""
    return string.format('<a href="%s" target="_blank">%s</a>', url, url)
end

e = t:option(DummyValue, "description", translate("Description"))
e.default = ""
e.width = "45%"
e.rawhtml = false

return a