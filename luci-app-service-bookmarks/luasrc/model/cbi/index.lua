local a, tabs, e, eh, es

a = Map("service_bookmarks", translate("Service Bookmarks"), translate("List all available service bookmarks here"))
a.pageaction = true

-- 创建选项卡容器
tabs = a:section(TypedSection, "service", translate("Service Bookmarks"))
tabs.anonymous = true
tabs:tab("home", translate("Home"))
tabs:tab("settings", translate("Settings"))

-- 首页选项卡内容
e = a:section(TypedSection, "home", translate("Service Bookmarks"))
e.template = "cbi/tblsection"
e.anonymous = true
e.addremove = false

eh = e:option(DummyValue, "title", translate("Service Title"))
eh.default = ""
eh.width = "15%"
eh.rawhtml = false

eh = e:option(DummyValue, "url", translate("Url Address"))
eh.width = "30%"
eh.rawhtml = true
function e.cfgvalue(self, section)
    local url = self.map:get(section, "url") or ""
    return string.format('<a href="%s" target="_blank">%s</a>', url, url)
end

eh = e:option(DummyValue, "description", translate("Description"))
eh.default = ""
eh.width = "45%"
eh.rawhtml = false

-- 设置选项卡内容
e = a:section(TypedSection, "settings", translate("Service Settings"))
e.template = "cbi/tblsection"
e.anonymous = true
e.addremove = true

es = e:option(Value, "title", translate("Service Title"))
es.width = "15%"
es.rmempty = true

es = e:option(Value, "url", translate("Url Address"))
es.width = "30%"
es.rmempty = true

es = e:option(Value, "description", translate("Description"))
es.width = "45%"
es.rmempty = false

return a