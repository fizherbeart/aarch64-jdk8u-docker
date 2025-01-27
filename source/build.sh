#!/bin/bash

# 定义工作目录和 JDK 路径
WORKSPACE_DIR=~/workspace/source/openjdk-aarch64-jdk8u
BOOT_JDK_DIR=/usr/lib/jvm/java-8-openjdk-arm64

# 检查工作目录是否存在
if [ ! -d "$WORKSPACE_DIR" ]; then
    echo "Error: Workspace directory $WORKSPACE_DIR does not exist."
    exit 1
fi

# 检查 Boot JDK 目录是否存在
if [ ! -d "$BOOT_JDK_DIR" ]; then
    echo "Error: Boot JDK directory $BOOT_JDK_DIR does not exist."
    exit 1
fi

# 进入工作目录
cd "$WORKSPACE_DIR" || exit

# 配置 OpenJDK
bash configure --with-boot-jdk="$BOOT_JDK_DIR" \
               --with-debug-level=slowdebug \
               --enable-debug-symbols \
               ZIP_DEBUGINFO_FILES=0 \
               --with-extra-cflags=-Wno-all \
               --with-extra-cxxflags=-Wno-all

# 检查配置是否成功
if [ $? -ne 0 ]; then
    echo "Error: configure failed."
    exit 1
fi

# 编译 OpenJDK
make all ZIP_DEBUGINFO_FILES=0 ENABLE_FULL_DEBUG_SYMBOLS=0 JOBS=$(nproc)

# 检查编译是否成功
if [ $? -ne 0 ]; then
    echo "Error: make failed."
    exit 1
fi

# 设置环境变量
JAVA_HOME="$WORKSPACE_DIR/build/linux-aarch64-normal-server-slowdebug/images/j2sdk-image"
echo "export JAVA_HOME=$JAVA_HOME" >> ~/.bashrc
echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> ~/.bashrc
echo "export CLASSPATH=.:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar" >> ~/.bashrc

# 重新加载 .bashrc
source ~/.bashrc

echo "OpenJDK build and setup completed successfully."
