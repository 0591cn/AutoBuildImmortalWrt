#!/bin/bash

# 输出调试信息
echo "$(date '+%Y-%m-%d %H:%M:%S') - Starting build process..."

# 定义路径变量
MAKEFILE_PATH="/home/build/immortalwrt/target/linux/x86/Makefile"

# 打印 Makefile 内容
if [ -f "$MAKEFILE_PATH" ]; then
    echo "Printing Makefile:"
    cat "$MAKEFILE_PATH"
else
    echo "Error: Makefile not found at $MAKEFILE_PATH"
    exit 1
fi

# 定义所需安装的包列表
PACKAGES="\
curl \
luci-i18n-firewall-zh-cn \
luci-i18n-filebrowser-zh-cn \
luci-app-argon-config \
luci-i18n-argon-config-zh-cn \
luci-i18n-opkg-zh-cn \
luci-i18n-ttyd-zh-cn \
luci-i18n-passwall-zh-cn \
luci-app-openclash \
luci-i18n-homeproxy-zh-cn \
openssh-sftp-server \
luci-i18n-dockerman-zh-cn"

# 构建镜像
echo "$(date '+%Y-%m-%d %H:%M:%S') - Building image with the following packages:"
echo "$PACKAGES"

make image PROFILE="generic" PACKAGES="$PACKAGES" FILES="/home/build/immortalwrt/files" ROOTFS_PARTSIZE="2048"

if [ $? -ne 0 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Error: Build failed!"
    exit 1
fi

echo "$(date '+%Y-%m-%d %H:%M:%S') - Build completed successfully."
