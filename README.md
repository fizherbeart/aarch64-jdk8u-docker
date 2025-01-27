# aarch64-jdk8u-docker

## 使用方式

1. 在mac里下载jdk8-aarch64源码, 放到source目录下   

jdk8源码仓库: https://github.com/AdoptOpenJDK/openjdk-aarch64-jdk8u  
.git不用也可以删了,1.2G比较大.

2. 启动容器    
```bash
docker-compose up -d
```

3. 进入容器,全量编译  
```bash
docker exec -it jdk8-debugger /bin/bash
bash /root/workspace/source/build.sh
```
编译完成后    
jdk路径: `/root/workspace/source/openjdk-aarch64-jdk8u/build/linux-aarch64-normal-server-slowdebug/images/j2sdk-image`    
源码路径: `/root/workspace/source/openjdk-aarch64-jdk8u/jdk/src/share/classes`
