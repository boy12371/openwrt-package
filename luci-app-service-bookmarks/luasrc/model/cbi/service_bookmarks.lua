local o = require "luci.sys"

a = Map("service_bookmarks", translate("Service BookMarks"), translate("Set service bookmarks here, which can include any service elements like title, url, description..."))
a.template = "service_bookmarks/index"

t = a:section(TypedSection, "service", translate("Service Settings"), translate("MAC addresses do not filter out all clients. For example, only specified clients are filtered out. Filtering time is optional."))
t.template = "cbi/tblsection"
t.anonymous = true
t.addremove = true

e = t:option(DummyValue, "bookmarks_status", translate("Service BookMarks"))
e.template = "service_bookmarks/service_bookmarks"
e.value = translate("Collecting data...")

e = t:option(Value, "title", translate("Service Title"))
e.rmempty = true

e = t:option(Value, "url", translate("Url Address"))
e.rmempty = true

o.net.mac_hints(function(t, a) e:value(t, "%s (%s)" % {t, a}) end)

e = t:option(Value, "timeon", translate("Start time"))
e.placeholder = "00:00"
e.rmempty = true

e = t:option(Value, "timeoff", translate("End time"))
e.placeholder = "23:59"
e.rmempty = true

e = t:option(Value, "description", translate("Description"))
e.rmempty = false

return a
