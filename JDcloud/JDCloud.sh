#!/bin/bash
#=================================================
#   Description: DIY script
#   Lisence: MIT
#   Author: P3TERX
#   Blog: https://p3terx.com
#=================================================
#克隆源码
git clone -b exp --single-branch https://github.com/LGA1150/openwrt.git openwrt
rm -rf openwrt/feeds.conf.default
wget -O openwrt/feeds.conf.default https://raw.githubusercontent.com/Lienol/openwrt/main/feeds.conf.default
cd openwrt
#添加passwall
sed -i '$a src-git xiaorouji https://github.com/xiaorouji/openwrt-passwall.git' feeds.conf.default
./scripts/feeds clean
./scripts/feeds update -a
./scripts/feeds install -a

#更改主机型号，支持中文。 
sed -i "s/JDCloud RE-SP-01B/京东漏油器/g" target/linux/ramips/dts/mt7621_jdcloud_re-sp-01b.dts

#添加主题
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-2.2.9
#svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-edge package/luci-theme-edge
#git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-1.7.2

#添加自定义插件
svn checkout https://github.com/Lienol/openwrt/branches/main/package/default-settings package/default-settings
git clone https://github.com/small-5/luci-app-adblock-plus.git package/luci-app-adblock-plus
git clone https://github.com/ntlf9t/luci-app-easymesh package/luci-app-easymesh
svn checkout https://github.com/Hyy2001X/AutoBuild-Packages/trunk/luci-app-webd package/luci-app-webd
svn checkout https://github.com/Hyy2001X/AutoBuild-Packages/trunk/webd package/webd
sed -i '$a chmod 775 /usr/bin/webd\n' package/default-settings/files/zzz-default-settings

#删除包含"exit 0"的行
sed -i '/exit 0/d' package/default-settings/files/zzz-default-settings
#修改网络共享的位置
sed -i '$a sed -i '\''s/services/nas/g'\'' /usr/lib/lua/luci/controller/samba4.lua' package/default-settings/files/zzz-default-settings
sed -i '$a\sed -i '\''s/services/nas/g'\'' /usr/share/luci/menu.d/luci-app-samba4.json' package/default-settings/files/zzz-default-settings
sed -i '$a\sed -i '\''s/services/nas/g'\'' /usr/lib/lua/luci/controller/ksmbd.lua' package/default-settings/files/zzz-default-settings
sed -i '$a\sed -i '\''s/services/nas/g'\'' /usr/share/luci/menu.d/luci-app-ksmbd.json' package/default-settings/files/zzz-default-settings
#添加包含"exit 0"的行
sed -i '$a\exit 0' package/default-settings/files/zzz-default-settings

#修改lan口地址
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate                                  
#修改机器名称
sed -i 's/OpenWrt/JDcloud/g' package/base-files/files/bin/config_generate
#修改wifi名称
sed -i 's/OpenWrt/JDcloud/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#默认打开WiFi
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#修改时区
#sed -i "s/'UTC'/'CST-8'\n        set system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate

#加载config
mv -f ../JDCloud.config .config
