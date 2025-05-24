local a = Map("ddns_cloudflare", translate("DDNS Cloudflare"))
a.template = "ddns_cloudflare/index"
a.pageaction = false

local t = a:section(NamedSection, "base", nil, "Cloudflare Settings",
              translate("Configure your Cloudflare DDNS settings here"))

-- local t = a:section(TypedSection, "base", "", translate("List all available service bookmarks here"))
-- t.template = "cbi/tblsection"
-- t.anonymous = true
-- t.addremove = false

local e = t:option(Flag, "enabled", translate("Enable"), 
              translate("Enable Cloudflare DDNS service"))
e.default = "0"
e.rmempty = false

e = t:option(Value, "interval", translate("Update Interval"), 
              translate("Time interval in minutes between updates"))
e.datatype = "uinteger"
e.default = "10"

e = t:option(Value, "api_key", translate("API Key"), 
              translate("Your Cloudflare Global API Key"))
e.password = true

e = t:option(Value, "zone_name", translate("Zone Name"), 
              translate("The domain name to update (e.g. example.com)"))
e.datatype = "hostname"

e = t:option(Value, "record_name", translate("Record Name"), 
              translate("DNS record to update (e.g. www)"))
e.datatype = "hostname"

return a