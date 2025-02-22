# SDDM Theme

## My Configuration

- Configuration file: `/etc/default/grub`
- Theme: `MineSDDM` (need manually install [sddm-theme-minesddm](https://github.com/Davi-S/sddm-theme-minesddm))
- Theme Path: `/usr/share/sddm/themes/`

## 1. Install dependencies

```sh
sudo pacman -S sddm
# (optional) if you use KDE, `sddm-kcm` provides integration into KDE Plasma's settings.
sudo pacman -S sddm-kcm
# (optional) `sddm-config` offer a GUI to edit configuration files
sudo pacman -S sddm-config-git # ot sddm-config
```

## 2. Changing the theme

## References

- [wiki.archlinux.org: SDDM](https://wiki.archlinux.org/title/SDDM)
