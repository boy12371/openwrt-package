module("luci.controller.service_bookmarks", package.seeall)

function index()
    if not nixio.fs.access("/etc/config/service_bookmarks") then return end

    entry({"admin", "services"}, firstchild(), "Control", 44).dependent = false
    entry({"admin", "services", "service_bookmarks"}, cbi("service_bookmarks"), _("URL Filter"), 12).dependent = true
    entry({"admin", "services", "service_bookmarks", "status"}, call("status")).leaf = true
end

function status()
    local e = {}
    e.status = luci.sys.call("iptables -L FORWARD | grep BOOKMARKS >/dev/null") == 0
    luci.http.prepare_content("application/json")
    luci.http.write_json(e)
end
