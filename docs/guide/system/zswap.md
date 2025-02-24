# zswap

> [!WARNING]
> The content here may be outdated, and some parts have been adjusted according to my own needs, so it may not be applicable to you. The best approach is to refer to the official documentation, such as the `Arch Linux Wiki`. Or refer to the link below.

## Introduction

`zswap` is a kernel feature that provides a compressed RAM cache for swap pages. Pages which would otherwise be swapped out to disk are instead compressed and stored into a memory pool in RAM. Once the pool is full or the RAM is exhausted, the least recently used (LRU) page is decompressed and written to disk, as if it had not been intercepted. After the page has been decompressed into the swap cache, the compressed version in the pool can be freed.

The difference compared to zram is that zswap works in conjunction with a swap device while zram with created swap on top of it is a swap device in RAM that does not require a backing swap device.

> [!TIP]
> `linux-rt` and `linux-rt-lts` have zswap enabled by default. This can be verified with `zgrep CONFIG_ZSWAP_DEFAULT_ON /proc/config.gz`.

> [!WARNING]
> `zswap` and `zram` cannot coexist. If you are using zswap, please disable zram.

```sh
# 1. If use zram-generator, run the following command to disable zram:
sudo systemctl mask systemd-zram-setup@zram0.service
# 2. If manually set (based on udev rules), run the following command to disable zram:
sudo mv /etc/modules-load.d/zram.conf{,.bak}
sudo mv /etc/modules-load.d/30-zram.conf{,.bak}
# then, delete the following line from `/etc/fstab`:
# /etc/fstab/dev/zram0 none swap defaults,pri=100 0 0
```

Run the following commands to check zram status:

```sh
swapon --show
# or
zramctl
```

## How to do ?

To enable zswap permanently, add `zswap.enabled=1` to your kernel parameters. To disable zswap permanently on kernels where it is enabled by default, add `zswap.enabled=0` instead.

```sh
GRUB_CMDLINE_LINUX_DEFAUL='... zswap.enabled=1 zswap.compressor=lz4 zswap.max_pool_percent=20 zswap.zpool=zsmalloc ...'
```

Then, run `sudo grub-mkconfig -o /boot/grub/grub.cfg` to update grub entries.

> [!NOTE]
>
> - `zswap.compressor=lz4`: Set compression algorithm, default is `zstd`.
> - `zswap.max_pool_percent=20`: Set maximum pool size. Once this threshold is reached, pages are evicted from the pool into the swap device.
> - `zswap.zpool=zsmalloc`: Set compressed memory pool allocator. It controls the management of the compressed memory pool.

## Check & statistics

The boot time load message showing the initial configuration can be retrieved with:

```sh
sudo dmesg | grep zswap:
# [    0.317569] zswap: loaded using pool zstd/zsmalloc
```

zswap has several customizable parameters. The live settings can be displayed using:

```sh
sudo grep -r . /sys/module/zswap/parameters/
```

To see zswap statistics you can run this:

```sh
sudo grep -r . /sys/kernel/debug/zswap/
```

## References

- [wiki.archlinux.org: Zswap](https://wiki.archlinux.org/title/Zswap)
- [一文说清swap,zram,zswap，交换空间和内存压缩方案](https://bbs.deepin.org/post/270814)
