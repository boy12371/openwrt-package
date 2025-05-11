module("luci.controller.service_bookmarks", package.seeall)

function index()
    if not nixio.fs.access("/etc/config/service_bookmarks") then return end

	local page = entry({ "admin", "services", "service_bookmarks" }, cbi("service_bookmarks"), _("Service BookMarks"), 10) -- 首页
	page.dependent = false
	page.acl_depends = { "luci-app-service-bookmarks" }

	entry({ "admin", "services", "service_bookmarks", "home" }, cbi("service_bookmarks"), _("Home"), 20).leaf = true
	entry({ "admin", "services", "service_bookmarks", "log" }, form("log"), _("Log"), 30).leaf = true -- 日志页面

	-- -- 服务管理API
	-- entry({"admin", "services", "service_bookmarks", "services"}, call("action_list_services")).leaf = true
	-- entry({"admin", "services", "service_bookmarks", "services"}, call("action_add_service")).leaf = true
	-- entry({"admin", "services", "service_bookmarks", "services", ":id"}, call("action_update_service")).leaf = true
	-- entry({"admin", "services", "service_bookmarks", "services", ":id"}, call("action_delete_service")).leaf = true
	entry({ "admin", "services", "service_bookmarks", "logtail" }, call("action_logtail")).leaf = true -- 日志采集
    entry({ "admin", "services", "service_bookmarks", "status" }, call("status")).leaf = true -- 服务状态API
end

function status()
    local e = {}
    e.status = luci.sys.call("iptables -L FORWARD | grep BOOKMARKS >/dev/null") == 0
    luci.http.prepare_content("application/json")
    luci.http.write_json(e)
end

function action_logtail()
	local fs = require "nixio.fs"
	local log_path = "/var/log/service_bookmarks.log"
	local e = {}
	e.running = luci.sys.call("pidof service_bookmarks >/dev/null") == 0
	if fs.access(log_path) then
		e.log = luci.sys.exec("tail -n 100 %s | sed 's/\\x1b\\[[0-9;]*m//g'" % log_path)
	else
		e.log = ""
	end
	luci.http.prepare_content("application/json")
	luci.http.write_json(e)
end