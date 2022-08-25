#!/bin/bash
#=================================================
#   Description: DIY script
#   Lisence: MIT
#   Author: P3TERX
#   Blog: https://p3terx.com
#=================================================
#克隆源码
git clone https://github.com/padavanonly/immortalwrt openwrt
cd openwrt

./scripts/feeds clean
./scripts/feeds update -a
./scripts/feeds install -a

#添加主题
git clone https://github.com/thinktip/luci-theme-neobird.git package/luci-theme-neobird
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-edge package/luci-theme-edge
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-1.7.2
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-2.2.9

#修改lan口地址
#sed -i 's/192.168.1.1/192.168.5.1/g' package/base-files/files/bin/config_generate                                  
#修改机器名称
sed -i 's/OpenWrt/Meizu/g' package/base-files/files/bin/config_generate
#修改wifi名称
sed -i 's/OpenWrt/Meizu_Mini/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#默认打开WiFi
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#修改时区
#sed -i "s/'UTC'/'CST-8'\n        set system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate
#更改主机型号，支持中文。 
sed -i "s/Xiaomi MiWiFi Nano/Meizu Mini/g" target/linux/ramips/dts/mt7628an_xiaomi_miwifi-nano.dts

#加载config
#mv -f ../Tmall_M1/M1_config.buildinfo .config
#mv -f ../Tmall_M1/Tmall_M1.config .config
mv -f ../XiaoMi_Nano.config .config
