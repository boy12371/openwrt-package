a = Map("service_bookmarks", translate("Service Bookmarks"), translate("List all available service bookmarks here"))
a.template = "service_bookmarks/index"
a.pageaction = false

-- 创建选项卡容器
tabs = a:section(NamedSection, "service", "bookmarks")
tabs.anonymous = true
tabs.addremove = false
tabs:tab("home", translate("Home"))
tabs:tab("settings", translate("Settings"))

-- 首页选项卡内容
eh = tabs:option("home", DummyValue, "title", translate("Service Title"))
eh.width = "15%"
eh.rawhtml = false

eh = tabs:option("home", DummyValue, "url", translate("Url Address"))
eh.width = "30%"
eh.rawhtml = true
function eh.cfgvalue(self, section)
    local url = self.map:get(section, "url") or ""
    return string.format('<a href="%s" target="_blank">%s</a>', url, url)
end

eh = tabs:option("home", DummyValue, "description", translate("Description"))
eh.width = "45%"
eh.rawhtml = false

-- 设置选项卡内容
es = tabs:option("settings", Value, "title", translate("Service Title"))
es.width = "15%"
es.rmempty = true

es = tabs:option("settings", Value, "url", translate("Url Address"))
es.width = "30%"
es.rmempty = true

es = tabs:option("settings", Value, "description", translate("Description"))
es.width = "45%"
es.rmempty = false

return a