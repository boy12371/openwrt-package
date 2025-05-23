local a = Map("ddns_cloudflare", translate("DDNS Cloudflare Configuration"))
a.template = "ddns_cloudflare/index"

local t = a:section(NamedSection, "base", "ddns", translate("Cloudflare Settings"))
t.anonymous = true

local e = t:option(Flag, "enabled", translate("Enable"), translate("Enable Cloudflare DDNS service"))
e.default = "0"

e = t:option(Value, "interval", translate("Update Interval"), translate("Time in minutes between DNS updates"))
e.datatype = "uinteger"
e.default = "10"
e:depends("enabled", "1")

e = t:option(Value, "api_key", translate("API Key"), translate("Cloudflare Global API Key"))
e.password = true
e:depends("enabled", "1")

e = t:option(Value, "zone_name", translate("Zone Name"), translate("The domain name registered with Cloudflare"))
e.datatype = "hostname"
e:depends("enabled", "1")

e = t:option(Value, "record_name", translate("Record Name"), translate("The DNS record to update (e.g. 'home' for home.example.com)"))
e.datatype = "hostname"
e:depends("enabled", "1")

return a