# Copyright (C) 2016 Openwrt.org
#
# This is free software, licensed under the Apache License, Version 2.0 .
#
include $(TOPDIR)/rules.mk

LUCI_TITLE:=LuCI Support for ddns-cloudflare
LUCI_DEPENDS:=
LUCI_PKGARCH:=all

PKG_NAME:=luci-app-ddns-cloudflare
PKG_VERSION:=1.0.0
PKG_RELEASE:=1
PKG_PO_VERSION:=$(PKG_VERSION)-$(PKG_RELEASE)
PKG_LICENSE:=MIT
PKG_MAINTAINER:=richard <richard@sveil.com>

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature