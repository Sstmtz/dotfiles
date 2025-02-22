# VMware

## Installation

At first, install the following packages:

```sh
sudo pacman -S vmware-workstation
```

Then, enable the following services:

```sh
# for guest network access
sudo systemctl enable --now vmware-networks.service
# for connecting USB devices to guest
sudo systemctl enable --now vmware-usbarbitrator.service
```

Lastly, load the VMware modules or reboot your computer:

```sh
modprobe -a vmw_vmci vmmon
```

## Fix issues

Text in the VMware application is rendered at an appropriate size following the system configuration, but icons are small and UI elements have little padding between them.

To fix this issue, you can use the following steps:

First, copy `wechat.desktop` to the local `applications` folder.

```sh
sudo cp /usr/share/applications/vmware-workstation.desktop ~/.local/share/applications/
```

Then, edit `~/.local/share/applications/vmware-workstation.desktop` and add the following content:

```sh
# For example, to get a final 2x scale factor
Exec=env GDK_SCALE=2 GDK_DPI_SCALE=0.5 ...
```

You can refer to [vmware-workstation.desktop](../../../home/dot_local/share/applications/vmware-workstation.desktop)

## References

- [wiki.archlinux.org: VMware](https://wiki.archlinux.org/title/VMware)
- [wiki.archlinux.org: HiDPI#VMware](https://wiki.archlinux.org/title/HiDPI#VMware)
