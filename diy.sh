#!/bin/bash

# 1. 引入第三方 Feeds / 软件包 (如 Argon 主题 & dae)
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/daeuniverse/openwrt-packages.git package/dae-packages

# 2. 预置 eBPF 内核开启参数 (确保 dae 能够完美挂载 eBPF)
echo "CONFIG_BPF=y" >> .config
echo "CONFIG_BPF_SYSCALL=y" >> .config
echo "CONFIG_BPF_JIT=y" >> .config
echo "CONFIG_NET_CLS_ACT=y" >> .config
echo "CONFIG_NET_ACT_BPF=y" >> .config
echo "CONFIG_CGROUP_BPF=y" >> .config

# 3. 目标架构配置 (x86_64)
echo "CONFIG_TARGET_x86=y" >> .config
echo "CONFIG_TARGET_x86_64=y" >> .config
echo "CONFIG_TARGET_x86_64_DEVICE_generic=y" >> .config

# 4. 必备组件与驱动 (含 eBPF 模块、TUN 驱动及常用工具)
echo "CONFIG_PACKAGE_kmod-bpf=y" >> .config
echo "CONFIG_PACKAGE_kmod-sched-core=y" >> .config
echo "CONFIG_PACKAGE_kmod-sched-bpf=y" >> .config
echo "CONFIG_PACKAGE_kmod-cls-bpf=y" >> .config
echo "CONFIG_PACKAGE_kmod-tun=y" >> .config
echo "CONFIG_PACKAGE_curl=y" >> .config
echo "CONFIG_PACKAGE_htop=y" >> .config
echo "CONFIG_PACKAGE_bash=y" >> .config
echo "CONFIG_PACKAGE_luci-theme-argon=y" >> .config
echo "CONFIG_PACKAGE_dae=y" >> .config
echo "CONFIG_PACKAGE_luci-app-daed=y" >> .config

# 5. 剔除旁路由不必要的组件 (PPPoE 拨号与 DHCPv6 服务)
echo "# CONFIG_PACKAGE_ppp is not set" >> .config
echo "# CONFIG_PACKAGE_ppp-mod-pppoe is not set" >> .config
echo "# CONFIG_PACKAGE_odhcpd-ipv6only is not set" >> .config
