module("luci.controller.ddns_cloudflare", package.seeall)

function index()
    if not nixio.fs.access("/etc/config/ddns_cloudflare") then return end

	local page = entry({ "admin", "services", "ddns_cloudflare" }, cbi("index"), _("DDNS Cloudflare"), 10)
	page.dependent = false
	page.acl_depends = { "luci-app-ddns-cloudflare" }
end
