#!/bin/bash
#=================================================
#   Description: DIY script
#   Lisence: MIT
#   Author: P3TERX
#   Blog: https://p3terx.com
#=================================================
#克隆源码
git clone -b openwrt-18.06-k5.4 --single-branch https://github.com/immortalwrt/immortalwrt openwrt
cd openwrt
./scripts/feeds clean
./scripts/feeds update -a
./scripts/feeds install -a

#更改主机型号，支持中文。 
sed -i "s/Letv LBA-047-CH/天猫路由器M1/g" target/linux/ath79/dts/qca9531_letv_lba-047-ch.dts

rm -rf target/linux/ath79/dts/qca9531_joyit_jt-or750i.dts
rm -rf target/linux/ath79/generic/base-files/etc/hotplug.d/firmware/11-ath10k-caldata
mv ../Tmall_M1/qca9531_joyit_jt-or750i.dts target/linux/ath79/dts/qca9531_joyit_jt-or750i.dts
mv ../Tmall_M1/11-ath10k-caldata target/linux/ath79/generic/base-files/etc/hotplug.d/firmware/11-ath10k-caldata
#添加主题
git clone https://github.com/thinktip/luci-theme-neobird.git package/luci-theme-neobird
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-edge package/luci-theme-edge
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-1.7.2

#添加自定义插件
git clone https://github.com/small-5/luci-app-adblock-plus.git package/luci-app-adblock-plus
git clone https://github.com/ntlf9t/luci-app-easymesh package/luci-app-easymesh
#svn checkout https://github.com/Hyy2001X/AutoBuild-Packages/trunk/luci-app-webd package/luci-app-webd
#svn checkout https://github.com/Hyy2001X/AutoBuild-Packages/trunk/webd package/webd
#sed -i '$a chmod 775 /usr/bin/webd\n' package/emortal/default-settings/files/99-default-settings

#删除包含"exit 0"的行
#sed -i '/exit 0/d' package/emortal/default-settings/files/99-default-settings
#修改网络共享的位置
#sed -i '$a sed -i '\''s/services/nas/g'\'' /usr/lib/lua/luci/controller/samba4.lua' package/emortal/default-settings/files/99-default-settings
#sed -i '$a\sed -i '\''s/services/nas/g'\'' /usr/share/luci/menu.d/luci-app-samba4.json' package/emortal/default-settings/files/99-default-settings
#sed -i '$a\sed -i '\''s/services/nas/g'\'' /usr/lib/lua/luci/controller/ksmbd.lua' package/emortal/default-settings/files/99-default-settings
#sed -i '$a\sed -i '\''s/services/nas/g'\'' /usr/share/luci/menu.d/luci-app-ksmbd.json' package/emortal/default-settings/files/99-default-settings

#添加LingMaxDNS
#sed -i '$a sed -i '\''$a #iptables -t nat -A PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 8287'\'' /etc/firewall.user' package/emortal/default-settings/files/99-default-settings
#sed -i '$a sed -i '\''/exit 0/i\/etc/init.d/network restart'\'' /etc/rc.local' package/emortal/default-settings/files/99-default-settings

#添加包含"exit 0"的行
#sed -i '$a\exit 0' package/emortal/default-settings/files/99-default-settings

#修改lan口地址
#sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate                                  
#修改机器名称
sed -i 's/OpenWrt/Tmall/g' package/base-files/files/bin/config_generate
#修改wifi名称
sed -i 's/OpenWrt/Tmall/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#默认打开WiFi
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#修改时区
#sed -i "s/'UTC'/'CST-8'\n        set system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate

#加载config
#mv -f ../Tmall_M1/M1_config.buildinfo .config
mv -f ../Tmall_M1/Tmall_M1.config .config
