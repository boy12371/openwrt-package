module("luci.controller.service_bookmarks", package.seeall)

function index()
    if not nixio.fs.access("/etc/config/service_bookmarks") then return end

	local page
	page = entry({ "admin", "services", "service_bookmarks" }, alias("admin", "services", "service_bookmarks", "home"), _("BookMarks Service"), 10) -- 首页
	page.dependent = true
	page.acl_depends = { "luci-app-service-bookmarks" }

	entry({ "admin", "services", "service_bookmarks", "home" }, cbi("service_bookmarks/home"), _("Home"), 10).leaf = true
	entry({ "admin", "services", "service_bookmarks", "client" }, cbi("service_bookmarks/client"), _("Settings"), 20).leaf = true -- 客户端配置
	entry({ "admin", "services", "service_bookmarks", "log" }, form("service_bookmarks/log"), _("Log"), 30).leaf = true -- 日志页面

	-- 服务管理API
	entry({"admin", "services", "service_bookmarks", "services"}, call("action_list_services")).leaf = true
	entry({"admin", "services", "service_bookmarks", "services"}, call("action_add_service")).leaf = true
	entry({"admin", "services", "service_bookmarks", "services", ":id"}, call("action_update_service")).leaf = true
	entry({"admin", "services", "service_bookmarks", "services", ":id"}, call("action_delete_service")).leaf = true

	entry({ "admin", "services", "service_bookmarks", "status" }, call("action_status")).leaf = true -- 运行状态
	entry({ "admin", "services", "service_bookmarks", "logtail" }, call("action_logtail")).leaf = true -- 日志采集
	entry({ "admin", "services", "service_bookmarks", "invalidate-cache" }, call("action_invalidate_cache")).leaf = true -- 清除缓存
end

function action_status()
	local e = {}
	e.running = luci.sys.call("pidof service_bookmarks >/dev/null") == 0
	e.application = luci.sys.exec("service_bookmarks --version")
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

function action_invalidate_cache()
	local e = {}
	e.ok = luci.sys.call("kill -HUP `pidof service_bookmarks`") == 0
	luci.http.prepare_content("application/json")
	luci.http.write_json(e)
end

function action_list_services()
	local uci = require "luci.model.uci".cursor()
	local e = {services = {}}

	uci:foreach("service_bookmarks", "service", function(s)
		table.insert(e.services, {
			id = s[".name"],
			title = s.title,
			url = s.url,
			description = s.description
		})
	end)

	luci.http.prepare_content("application/json")
	luci.http.write_json(e)
end

function action_add_service()
	local uci = require "luci.model.uci".cursor()
	local http = luci.http
	local e = {success = false}

	local data = http.content()
	if data then
		local service = luci.jsonc.parse(data)
		if service and service.title and service.url then
			local id = "service_" .. os.time()
			uci:section("service_bookmarks", "service", id, {
				title = service.title,
				url = service.url,
				description = service.description or ""
			})

			if uci:save() and uci:commit() then
				e.success = true
				e.id = id
			else
				e.error = "Failed to save configuration"
			end
		else
			e.error = "Invalid service data"
		end
	else
		e.error = "No data received"
	end

	http.prepare_content("application/json")
	http.write_json(e)
end

function action_update_service(id)
	local uci = require "luci.model.uci".cursor()
	local http = luci.http
	local e = {success = false}

	if id then
		local data = http.content()
		if data then
			local service = luci.jsonc.parse(data)
			if service and service.title and service.url then
				if uci:get("service_bookmarks", id) then
					uci:set("service_bookmarks", id, "title", service.title)
					uci:set("service_bookmarks", id, "url", service.url)
					uci:set("service_bookmarks", id, "description", service.description or "")

					if uci:save() and uci:commit() then
						e.success = true
					else
						e.error = "Failed to save configuration"
					end
				else
					e.error = "Service not found"
				end
			else
				e.error = "Invalid service data"
			end
		else
			e.error = "No data received"
		end
	else
		e.error = "Missing service ID"
	end

	http.prepare_content("application/json")
	http.write_json(e)
end

function action_delete_service(id)
	local uci = require "luci.model.uci".cursor()
	local http = luci.http
	local e = {success = false}

	if id then
		if uci:get("service_bookmarks", id) then
			uci:delete("service_bookmarks", id)
			if uci:save() and uci:commit() then
				e.success = true
			else
				e.error = "Failed to save configuration"
			end
		else
			e.error = "Service not found"
		end
	else
		e.error = "Missing service ID"
	end

	http.prepare_content("application/json")
	http.write_json(e)
end