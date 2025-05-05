m = Map("service_bookmarks")
m.title = translate("BookMarks Service")
m.description = ""

m:section(SimpleSection).template = "service_bookmarks/status"

e = m:section(TypedSection, "server")
e.anonymous = true

enable = e:option(Flag, "enable", translate("Enable"))
enable.rmempty = false

root = e:option(Value, "root", translate("Root Directory"))
root.description = translate("Restrict access to a folder, defaults to / which means no restrictions")
root.default = "/"

host = e:option(Value, "host", translate("Host"))
host.default = "0.0.0.0"
host.datatype = "ipaddr"

port = e:option(Value, "port", translate("Port"))
port.default = "8080"
port.datatype = "port"

debug = e:option(Flag, "debug", translate("Debug Mode"))
debug.rmempty = false

return m