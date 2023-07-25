# gentoo-qemu
gentoo qemu docker image is a test image built by [crossany - cross compile envirionment](https://github.com/cross-any/cross-any).  
It uses qemu to binfmts to allow you run arm64 binararies on amd64 or amd64 binararies on arm64. This build include all qemu user targets.  
# Tags
https://hub.docker.com/r/crossany/qemu/tags  
# Mirrors
Use aliyun if docker hub is slow for you:
  registry.cn-beijing.aliyuncs.com/crossany/qemu
# Run it  
```
docker run -ti --rm --privileged crossany/qemu
```
# Run it on different architeture cpu  
```
docker run -ti --rm --privileged crossany/qemu
docker run  --rm -ti --platform arm64 crossany/gentoo-mini:latest uname -a
docker run  --rm -ti --platform amd64 crossany/gentoo-mini:latest uname -a
```
# crossany
Try [crossany](https://github.com/cross-any/cross-any) https://github.com/cross-any/cross-any if you need cross compile toolset.
