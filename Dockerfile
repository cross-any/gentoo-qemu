# name the portage image
FROM gentoo/portage:20230710 as portage

# image is based on stage3
FROM gentoo/stage3:systemd-20230710 as build

# copy the entire portage volume in
COPY --from=portage /var/db/repos/gentoo /var/db/repos/gentoo

ENV FEATURES="-ipc-sandbox -network-sandbox -pid-sandbox -sandbox -usersandbox"
COPY /register.sh /register
COPY /qemu-binfmt-conf.sh /usr/bin/
# build qemu and tar to /qemu/
RUN USE="static-user" QEMU_SOFTMMU_TARGETS="" QEMU_USER_TARGETS="x86_64 loongarch64 hexagon aarch64 aarch64_be alpha arm armeb cris hppa i386 m68k microblaze microblazeel mips mips64 mips64el mipsel mipsn32 mipsn32el nios2 or1k ppc ppc64 ppc64abi32 ppc64le riscv32 riscv64 s390x sh4 sh4eb sparc sparc32plus sparc64 tilegx xtensa xtensaeb"  emerge --tree   --autounmask-continue --autounmask=y --autounmask-write  -vn -j$(nproc) '>app-emulation/qemu-8' \
    app-portage/gentoolkit && mkdir /qemu && equery f -t qemu|grep file|cut -f2 -d\  |xargs tar cvf /root/qemu.tar /register /usr/bin/qemu-binfmt-conf.sh && tar xvf /root/qemu.tar -C /qemu

#create final image from busybox with copying /qemu to / from previous build step
FROM busybox
COPY --from=build /qemu/ /
ENTRYPOINT [ "/register" ]
CMD [ "--reset","-p", "yes" ]

