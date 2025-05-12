local o = require "luci.sys"

a = Map("service_bookmarks", translate("Service BookMarks"), translate("Set service bookmarks here, which can include any service elements like title, url, description..."))
a.template = "service_bookmarks/index"

t = a:section(TypedSection, "service", translate("Service Settings"), translate("MAC addresses do not filter out all clients. For example, only specified clients are filtered out. Filtering time is optional."))
t.template = "cbi/tblsection"
t.anonymous = true
t.addremove = true

e = t:option(Value, "title", translate("Service Title"))
e.rmempty = true

e = t:option(Value, "url", translate("Url Address"))
e.rmempty = true

e = t:option(Value, "description", translate("Description"))
e.rmempty = false

return a
