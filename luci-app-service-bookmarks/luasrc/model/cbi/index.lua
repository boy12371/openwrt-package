-- 1. 创建主Map对象
local map = Map("service_bookmarks", translate("Service Bookmarks"), translate("List all available service bookmarks here"))
map.pageaction = true

-- 2. 创建选项卡容器
local tabs = map:add(Tabs("service_bookmarks_tabs"))

-- 3. 首页选项卡
local tab_home = tabs:add(Tab("home", translate("Home")))
local section_home = tab_home:add(TypedSection, "home", translate("Service Bookmarks"))
section_home.template = "cbi/tblsection"
section_home.anonymous = true
section_home.addremove = false

-- 4. 首页内容定义
local title_home = section_home:option(DummyValue, "title", translate("Service Title"))
title_home.default = ""
title_home.width = "15%"

local url_home = section_home:option(DummyValue, "url", translate("Url Address"))
url_home.width = "30%"
url_home.rawhtml = true
function url_home.cfgvalue(self, section)
    local url = self.map:get(section, "url") or ""
    return string.format('<a href="%s" target="_blank">%s</a>', url, url)
end

local desc_home = section_home:option(DummyValue, "description", translate("Description"))
desc_home.default = ""
desc_home.width = "45%"

-- 5. 设置选项卡
local tab_settings = tabs:add(Tab("settings", translate("Settings")))
local section_settings = tab_settings:add(TypedSection, "settings", translate("Service Settings"))
section_settings.template = "cbi/tblsection"
section_settings.anonymous = true
section_settings.addremove = true

-- 6. 设置内容定义
local title_setting = section_settings:option(Value, "title", translate("Service Title"))
title_setting.width = "15%"
title_setting.rmempty = true

local url_setting = section_settings:option(Value, "url", translate("Url Address"))
url_setting.width = "30%"
url_setting.rmempty = true

local desc_setting = section_settings:option(Value, "description", translate("Description"))
desc_setting.width = "45%"
desc_setting.rmempty = false

return map