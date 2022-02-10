#!/bin/bash
#=================================================
#   Description: DIY script
#   Lisence: MIT
#   Author: P3TERX
#   Blog: https://p3terx.com
#=================================================
#克隆源码
#git clone -b 21.02 --single-branch https://github.com/Lienol/openwrt openwrt
#git clone -b main --single-branch https://github.com/Lienol/openwrt openwrt
git clone https://github.com/coolsnowwolf/lede openwrt
cd openwrt
#添加passwall
sed -i '$a src-git xiaorouji https://github.com/xiaorouji/openwrt-passwall.git' feeds.conf.default
./scripts/feeds clean
./scripts/feeds update -a
./scripts/feeds install -a

#添加自定义插件
git clone https://github.com/small-5/luci-app-adblock-plus.git package/luci-app-adblock-plus
git clone https://github.com/ntlf9t/luci-app-easymesh package/luci-app-easymesh
#添加主题
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-2.2.9
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-edge package/luci-theme-edge
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-1.7.2

#修改lan口地址
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate                                  
#修改机器名称
sed -i 's/OpenWrt/R4A/g' package/base-files/files/bin/config_generate
#修改wifi名称
sed -i 's/OpenWrt/R4A/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#默认打开WiFi
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#修改时区
#sed -i "s/'UTC'/'CST-8'\n        set system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate
# 修改主机名字，把YOU-R4A修改你喜欢的就行（不能纯数字或者使用中文）
#sed -i '/uci commit system/i\uci set system.@system[0].hostname='R4A-G'' package/lean/default-settings/files/zzz-default-settings
#更改主机型号，支持中文。 
sed -i "s/Xiaomi Mi Router 4A Gigabit Edition/小米4A千兆版路由/g" target/linux/ramips/dts/mt7621_xiaomi_mi-router-4a-gigabit.dts

mv -f ../MI-R4A-breed-openwrt/MI-R4A/banner package/base-files/files/etc/banner
#加载config
#mv -f ../MI-R4A-breed-openwrt/MI-R4A/mi-r4a.config .config
