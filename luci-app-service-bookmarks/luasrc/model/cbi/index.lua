a = Map("service_bookmarks", translate("Service Bookmarks"), translate("List all available service bookmarks here"))
a.template = "service_bookmarks"
a.pageaction = false

-- 创建选项卡容器
tabs = a:section(NamedSection, "__tabs__", "", "")
tabs.template = "cbi/tabmenu"
tabs.tabs = {
    { id = "home", header = translate("Home") },  -- 首页选项卡
    { id = "settings", header = translate("Settings") }  -- 设置选项卡
}

-- 首页选项卡内容
home_tab = a:section(TypedSection, "service", translate("Service Bookmarks"), translate("List all available service bookmarks here"))
home_tab.template = "cbi/tblsection"
home_tab.anonymous = true
home_tab.addremove = false
home_tab:depends("__tab__", "home")  -- 绑定到首页选项卡

eh = home_tab:option(DummyValue, "title", translate("Service Title"))
eh.width = "15%"
eh.rawhtml = false

eh = home_tab:option(DummyValue, "url", translate("Url Address"))
eh.width = "30%"
eh.rawhtml = true
function eh.cfgvalue(self, section)
    local url = self.map:get(section, "url") or ""
    return string.format('<a href="%s" target="_blank">%s</a>', url, url)
end

eh = home_tab:option(DummyValue, "description", translate("Description"))
eh.width = "45%"
eh.rawhtml = false

-- 设置选项卡内容
settings_tab = a:section(TypedSection, "service", translate("Service Settings"), translate("Set service bookmarks here, which can include any service elements like title, url, description..."))
settings_tab.template = "cbi/tblsection"
settings_tab.anonymous = true
settings_tab.addremove = true
settings_tab:depends("__tab__", "settings")  -- 绑定到设置选项卡

es = settings_tab:option(Value, "title", translate("Service Title"))
es.width = "15%"
es.rmempty = true

es = settings_tab:option(Value, "url", translate("Url Address"))
es.width = "30%"
es.rmempty = true

es = settings_tab:option(Value, "description", translate("Description"))
es.width = "45%"
es.rmempty = false

return a