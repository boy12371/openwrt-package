local a, tabs, eh, es

a = Map("service_bookmarks", translate("Service Bookmarks"), translate("List all available service bookmarks here"))
a.template = "service_bookmarks/index"
a.pageaction = false

-- 创建选项卡容器
tabs = a:section(TypedSection, "service", translate("Service Bookmarks"))
tabs.template = "cbi/tblsection"
tabs.anonymous = true
tabs.addremove = true
tabs:tab("home", translate("Home"))
tabs:tab("settings", translate("Settings"))

-- 首页选项卡内容
eh = tabs:taboption("home", DummyValue, "title", translate("Service Title"))
eh.width = "15%"
eh.rawhtml = false

eh = tabs:taboption("home", DummyValue, "url", translate("Url Address"))
eh.width = "30%"
eh.rawhtml = true
function eh.cfgvalue(self, section)
    local url = self.map:get(section, "url") or ""
    return string.format('<a href="%s" target="_blank">%s</a>', url, url)
end

eh = tabs:taboption("home", DummyValue, "description", translate("Description"))
eh.width = "45%"
eh.rawhtml = false

-- 设置选项卡内容
es = tabs:taboption("settings", Value, "title", translate("Service Title"))
es.width = "15%"
es.rmempty = true

es = tabs:taboption("settings", Value, "url", translate("Url Address"))
es.width = "30%"
es.rmempty = true

es = tabs:taboption("settings", Value, "description", translate("Description"))
es.width = "45%"
es.rmempty = false

return a