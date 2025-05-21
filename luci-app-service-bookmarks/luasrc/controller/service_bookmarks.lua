module("luci.controller.service_bookmarks", package.seeall)

function index()
    if not nixio.fs.access("/etc/config/service_bookmarks") then return end

	local page = entry({ "admin", "services", "service_bookmarks" }, cbi("home"), _("Service Bookmarks"), 10) -- 首页
	page.dependent = false
	page.acl_depends = { "luci-app-service-bookmarks" }

	entry({ "admin", "services", "service_bookmarks", "home" }, cbi("home"), _("Home"), 20).leaf = true
	entry({ "admin", "services", "service_bookmarks", "settings" }, cbi("settings"), _("Settings"), 30).leaf = true
end
