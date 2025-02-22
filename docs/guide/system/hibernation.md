# Hibernation

## Introduction

In order to use hibernation, you must create a swap partition or file, configure the initramfs so that the resume process will be initiated in early userspace, and specify the location of the swap space in a way that is available to the initramfs, e.g. HibernateLocation EFI variable defined by systemd or resume= kernel parameter. These three steps are described in detail below.

Hibernating to swap on zram is not supported, even when zram is configured with a backing device on permanent storage. While logind will protect against attempts to hibernate into swap space on zram, as an alternative you can create multiple swap spaces. The memory will be stored into a swap file while another available swap space is reserved for zram. See details in [Maintaining swap file for hibernation with zram](https://wiki.archlinux.org/title/Power_management/Suspend_and_hibernate#Maintaining_swap_file_for_hibernation_with_zram).

**You do not need to deactivate zram, since the hibernation logic in systemd ignores zram devices anyway when looking for a swap device to hibernate into.**

if you have a swap file anyway, then just activate it always, but make sure to give it a lower priority than your zram device, so that zram is always preferred, and the swap file is only used if the system is under pressure enough that zram didn#t work. That will give you overall better behaviour.

Hence, no need deactivate zram, and no need to activate the swap files. just use swap priorities, which exist since forever.

First, You need to create a swap file or partition.

## Create a swap file

To properly initialize a swap file, first create a non-snapshotted subvolume to host the file, e.g.

```sh
btrfs subvolume create /swap
```

For btrfs, create the swap file:

```sh
# you may need to modify the size
# Abount 50% ~ 60% of your RAM is enough to hibernate.
btrfs filesystem mkswapfile --size 9g --uuid clear /swap/swapfile
```

Activate the swap file:

```sh
swapon /swap/swapfile
```

Finally, edit the `/etc/fstab` configuration to add an entry for the swap file:

```sh
/swap/swapfile none swap defaults 0 0
```

## Create a swap partition

You can use `fdisk` or `cfdisk` to create a swap partition.

Then run `swapon /dev/sdxy` to start using the swap partition.

Or add a entry to the `/etc/fstab` file:

```sh
# replace device_UUID with your swap device UUID 
UUID=device_UUID none swap defaults 0 0
```

## Configure the initramfs

When using a busybox-based initramfs, which is the default, the resume hook is required in /etc/mkinitcpio.conf. Whether by label or by UUID, the swap partition is referred to with a udev device node, **so the `resume` hook must go after the `udev` hook**. This example was made starting from the default hook configuration:

```sh
HOOKS=(base udev autodetect microcode modconf kms keyboard keymap consolefont block filesystems resume fsck)
```

> [!NOTE]
> When an initramfs with the `systemd` hook is used, a resume mechanism is already provided, and no further hooks need to be added.

## Hibernate to the swap file or partition

First, confirm the `UUID` of the partition where the Swap file is located:

```sh
# for swap file
sudo findmnt -no UUID -T /swap/swapfile
# for swap partition
lsblk -no UUID /dev/sdxy
```

Then, if you use swap file, need to confirm the `offset value` of the Swap file:

```sh
# for btrfs filesystem
sudo btrfs inspect-internal map-swapfile -r /swap/swapfile
# fot ext4 filesystem
filefrag -v /swap/swapfile | awk '$1=="0:" {print substr($4, 1, length($4)-2)}'
```

Finally, add the following content to the `/etc/default/grub`:

>[!NOTE]
> if you use swap partition, you don't need to set `resume_offset`

```sh
GRUB_CMDLINE_LINUX_DEFAUL='... resume=UUID=<your_uuid> resume_offset=<your_offset> ...'
```

## References

- [wiki.archlinux.org: Swap](https://wiki.archlinux.org/title/Swap)
- [wiki.archlinux.org: Hibernation](https://wiki.archlinux.org/title/Power_management/Suspend_and_hibernate)
- [wiki.archlinux.org: Btrfs#Swap_file](https://wiki.archlinux.org/title/Btrfs#Swap_file)
