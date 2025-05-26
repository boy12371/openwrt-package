local a = Map("ddns_cloudflare", translate("DDNS Cloudflare"))
a.template = "ddns_cloudflare/index"
a.pageaction = false

local t = a:section(NamedSection, "ddns", "base", translate("Cloudflare Settings"))
t.anonymous = true
t.addremove = true

local e = t:option(Flag, "enabled", translate("Enable"), translate("Enable Cloudflare DDNS service"))
e.default = "0"

e = t:option(Value, "interval", translate("Update Interval"), translate("Time in minutes between DNS updates"))
e.datatype = "uinteger"
e.default = "10"
e:depends("enabled", "1")

e = t:option(Value, "api_token", translate("API Token"), translate("Cloudflare API Token"))
e.password = true
e:depends("enabled", "1")

e = t:option(Value, "zone_name", translate("Zone Name"), translate("The domain name registered with Cloudflare"))
e.datatype = "hostname"
e:depends("enabled", "1")

e = t:option(Value, "record_name", translate("Record Name"), translate("The DNS record to update (e.g. 'home' for home.example.com)"))
e.datatype = "hostname"
e:depends("enabled", "1")

-- Add service control buttons
local n = a:section(TypedSection, "base", translate("Service Control"))
n.template = "cbi/tblsection"
n.anonymous = true
n.addremove = false

local btns = n:option(DummyValue, "_buttons")
btns.template = "ddns_cloudflare/buttons"
btns.width = "100%"
btns.rawhtml = false
btns:depends("enabled", "1")

function a.handle(self, state, data)
    if state == FORM_VALID then
        local cmd = luci.http.formvalue("cbi.apply")
        if cmd == "start" then
            os.execute("/etc/init.d/ddns_cloudflare start >/dev/null 2>&1")
            a.message = translate("Service started successfully")
        elseif cmd == "stop" then
            os.execute("/etc/init.d/ddns_cloudflare stop >/dev/null 2>&1")
            a.message = translate("Service stopped successfully")
        elseif cmd == "restart" then
            os.execute("/etc/init.d/ddns_cloudflare restart >/dev/null 2>&1")
            a.message = translate("Service restarted successfully")
        end
    end
    return a
end

return a