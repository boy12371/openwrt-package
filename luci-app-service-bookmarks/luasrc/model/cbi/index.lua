-- 创建主Map对象
local map = Map("service_bookmarks", translate("Service Bookmarks"), translate("List all available service bookmarks here"))
map.pageaction = true

-- 创建选项卡容器
local tabs = map:section(NamedSection, "__tabs__", "", "")
tabs.template = "cbi/tabmenu"
tabs.tabs = {
    { id = "home",    header = translate("Home") },
    { id = "setting", header = translate("Settings") }
}

-- 首页选项卡
local home_tab = map:section(TypedSection, "service", translate("Service Bookmarks"), translate("所有预定义服务书签"))
home_tab.template = "cbi/tblsection"
home_tab.anonymous = true
home_tab:depends("__tab__", "home")

local title_home = home_tab:option(DummyValue, "title", translate("Service Title"))
title_home.default = ""
title_home.width = "15%"
title_home.rawhtml = false

local url_home = home_tab:option(DummyValue, "url", translate("Url Address"))
url_home.default = ""
url_home.width = "30%"
url_home.rawhtml = true
function url_home.cfgvalue(self, section)
    local url = self.map:get(section, "url") or ""
    return string.format('<a href="%s" target="_blank">%s</a>', url, url)
end

local desc_home = home_tab:option(DummyValue, "description", translate("Description"))
desc_home.default = ""
desc_home.width = "45%"
desc_home.rawhtml = false

-- 设置选项卡
local setting_tab = map:section(TypedSection, "service", translate("Service Settings"), translate("修改服务书签"))
setting_tab.template = "cbi/tblsection"
setting_tab.addremove = true
setting_tab:depends("__tab__", "setting")

-- 6. 设置内容定义
local title_setting = setting_tab:option(Value, "title", translate("Service Title"))
title_setting.width = "15%"
title_setting.rmempty = true

local url_setting = setting_tab:option(Value, "url", translate("Url Address"))
url_setting.width = "30%"
url_setting.rmempty = true

local desc_setting = setting_tab:option(Value, "description", translate("Description"))
desc_setting.width = "45%"
desc_setting.rmempty = false

return map