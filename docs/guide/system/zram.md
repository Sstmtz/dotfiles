# ZARM

## Introduction

It is important to note that when using ZRAM, you do not need to disable the regular swap space if it has already been configured. In this case, the kernel will default to using the partition or file mounted at the service mount point [swap] as the primary swap space, which has a higher priority than others. Therefore, if you set the priority of ZRAM to 100, as we do in the /etc/fstab file below, the regular disk swap space will only be used by the kernel as a backup in case ZRAM overflows, or when using the hibernation feature, which can only work with disk swap space.

In most cases, you should only use `zstd`, as it is optimized for speed and compression efficiency. `LZ4` may be faster during decompression, but it doesn't have much advantage in other aspects. `LZO` should only be used on very weak processors that cannot compress a large number of pages using Zstd.

## How to do ?

To avoid conflicts, after installing zram, please disable zswap by adding the kernel parameter `zswap.enabled=0`.

```sh
GRUB_CMDLINE_LINUX_DEFAUL='... zswap.enabled=0 ...'
```

Or run the following command to disable zswap Temporarily:

```sh
echo 0 > /sys/module/zswap/parameters/enabled
```

### Automatic

```sh
sudo pacman -S zram-generator
```

This generator checks the following locations:

- `/run/systemd/zram-generator.conf`
- `/etc/systemd/zram-generator.conf`
- `/usr/local/lib/systemd/zram-generator.conf`
- `/usr/lib/systemd/zram-generator.conf`

… and the first file found in that list wins.

For example, add the following content to `/usr/lib/systemd/zram-generator.conf`:

```sh
[zram0]
zram-size = ram
compression-algorithm = zstd
swap-priority = 100
fs-type = swap
```

Then Start the service:

```sh
sudo daemon-reload
sudo systemctl enable --now systemd-zram-setup@zram0.service
```

### Manually (Besed on udev rules)

Explicitly load the module at boot.
Add the following content to `/etc/modules-load.d/zram.conf`:

```sh
zram
```

Create the following udev rule adjusting the disksize attribute as necessary.
Add the following content to `/etc/modules-load.d/30-zram.conf`:

```sh
# you may need to modify disksize
# mime is 16G, can be 16G(one time) or 32G (two times).
ACTION=="add", KERNEL=="zram0", ATTR{initstate}=="0", ATTR{comp_algorithm}="zstd", \
    ATTR{disksize}="16G", \
    RUN="/usr/bin/mkswap -U clear %N", TAG+="systemd"
```

Add `/dev/zram` to your fstab with a higher than default priority.
Add the following content to `/etc/fstab`:

```sh
 /dev/zram0 none swap defaults,pri=100 0 0
```

## Optimizing swap on zram

- [archwiki links](https://wiki.archlinux.org/title/Zram#Optimizing_swap_on_zram)

Since zram behaves differently than disk swap, we can configure the system's swap to take full potential of the zram advantages:

Add the following content to `/etc/sysctl.d/99-vm-zram-parameters.conf`:

```sh
vm.swappiness = 150
vm.watermark_boost_factor = 0
vm.watermark_scale_factor = 125
vm.page-cluster = 0
```

## References

- [wiki.archlinux.org: Zram](https://wiki.archlinux.org/title/Zram)
- [ARU: ZARM](https://ventureo.codeberg.page/source/kernel-parameters.html#zram)
- [ARU: zram-generator](https://ventureo.codeberg.page/source/services.html#zram-generator)
