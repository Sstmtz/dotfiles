# Initramfs

> [!WARNING]
> The content here may be outdated, and some parts have been adjusted according to my own needs, so it may not be applicable to you. The best approach is to refer to the official documentation, such as the `Arch Linux Wiki`. Or refer to the link below.

## Introduction

As mentioned earlier, initramfs is an initial boot environment that serves as a supplement to the Linux kernel image. It should contain all the modules and utilities required by the kernel for proper booting (primarily for mounting the root partition). To save space in the boot partition, this environment is provided in a self-extracting archive format, which is decompressed in real-time during the system boot process. In Arch Linux, the program used to generate initramfs is mkinitcpio, which by default uses the zstd algorithm for compression, known for its optimal compression and decompression speed metrics. Therefore, the compression speed of initramfs is not as critical, while the decompression speed is crucial, as it directly affects the system boot speed. Thus, to accelerate this process, it is preferable to use an algorithm with the fastest decompression speed: `lz4`.

## Accelerate the decompression of initramfs

We need to edit the configuration file `/etc/mkinitcpio.conf` and add the following line:

```sh
 COMPRESSION="lz4"
 COMPRESSION_OPTIONS=(-9)
```

Then run `sudo mkinitcpio -p` to update the initramfs.

## Use systemd to accelerate system boot

Another way to speed up system boot is to use systemd to initialize the system and specify its use early in the initramfs environment. To do this, you need to remove `base` and `udev` from the array `HOOKS` in the file `/etc/mkinitcpio.conf` and replace them with systemd, making it look something like this:

```sh
 HOOKS=(systemd autodetect microcode modconf kms keyboard sd-vconsole block filesystems fsck)
```

This will slightly increase the size of initramfs, but it may significantly speed up system boot time.

For systems with an encrypted root partition, you should also add `sd-encrypt` after the provided hook list, followed by a space and then the hook `sd-vconsole`.

Then run `sudo mkinitcpio -p` to update the initramfs.

## References

- [ARU: initramfs](https://ventureo.codeberg.page/source/boot.html#initramfs)
