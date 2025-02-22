# GRUB Theme

## My Configuration

- Configuration file: `/etc/default/grub`
- Theme: `minegrub-double-menu` (need manually install [double-minegrub-menu](https://github.com/Lxtharia/double-minegrub-menu))
- Theme Path: `/boot/grub/themes/`

## 1. Install dependencies

```sh
sudo pacman -S grub efibootmgr
```

> [!NOTE]
> `grub` is the boot loader while `efibootmgr` is used by the GRUB installation script to write boot entries to NVRAM.

## 2. Changing the theme

```sh
GRUB_TIMEOUT_STYLE=menu # show grub menu
GRUB_THEME=/boot/grub/themes/xxx/theme.txt # set your installed theme file path
```

Finally, Don't forget to run `sudo grub-mkconfig -o /boot/grub/grub.cfg` to regenerate the GRUB UEFI boot entry.

## References

- [wiki.archlinux.org: GRUB](https://wiki.archlinux.org/title/GRUB)
