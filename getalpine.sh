#!/usr/bin/env sh

qemu-system-x86_64 \
	-smp 2 \
	-m 2048 \
	-drive file=./alpine/alpine.qcow2,if=virtio \
	-netdev user,id=n1,hostfwd=tcp::6379-:6379,hostfwd=tcp::9000-:9000 \
	-device virtio-net,netdev=n1 \
	-cdrom ./alpine/alpine-virt-3.13.2-x86_64.iso \
	-boot d \
	-nographic
