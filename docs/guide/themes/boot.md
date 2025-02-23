# Boot Theme

## My Configuration

- Configuration file: `/etc/plymouth/plymouthd.conf`
- Theme: `mc` (need install `minecraft-plymouth-theme-git`)
- Theme Path: `/usr/share/plymouth/themes/`
- Services: `/etc/systemd/system/plymouth-wait-for-animation.service`

## 1. Install dependencies

At first, you need to install `plymouth`.

```sh
sudo pamcan -S plymouth # or plymouth-git
# (optional) if you use KDE, `plymouth-kcm` provides integration into KDE Plasma's settings.
sudo pamcan -S plymouth-kcm
```

## 2. Add kernel parameters

Add `splash` and `quiet` to kernel parameters:

```sh
# /etc/default/grub
GRUB_CMDLINE_LINUX_DEFAUL='... splash quiet ...'
```

> [!NOTE]
>
> - `splash`: enable splash screen.
> - `quiet`: enable slient boot.

Finally, Don't forget to run `sudo grub-mkconfig -o /boot/grub/grub.cfg` to regenerate the GRUB UEFI boot entry.

## 3. Add hook

Add `plymouth` to the HOOKS array in `/etc/mkinitcpio.conf`:

```sh
# /etc/mkinitcpio.conf
HOOKS=(... plymouth ...)
```

> [!WARNING]
> If you are using the `systemd` hook, it must be before `plymouth`.
> Furthermore make sure you place `plymouth` before the `encrypt` or `sd-encrypt` hook if your system is encrypted with dm-crypt.

> [!NOTE]
> Finally, Don't forget to run `sudo mkinitcpio -P` to regenerate the initramfs.

## 4. Changing the theme

Plymouth provides some default themes, and you can also install other themes.
If you has installed `plymouth-kcm`, you can change the theme in `System Settings >> Colors & Themes >> Boot Screen`.

All currently installed themes can be listed by using this command:

```sh
plymouth-set-default-theme -l
# or 
ls /usr/share/plymouth/themes
```

The theme can be changed by editing the configuration file:

```sh
# set your theme
[Daemon]
Theme=theme
```

Or by running:

```sh
plymouth-set-default-theme -R theme
```

## 5. Slow down boot to show the full animation

On systems with a very fast boot time, it might be necessary to add a delay to `plymouth-quit.service` with a drop-in snippet containing `ExecStartPre=/usr/bin/sleep 5` if showing the whole animation is desired.

Alternatively, it is possible to use a new systemd service starting at the same time as plymouth and waiting the whole duration needed for the animation. This method will ensure that inconsistencies in the boot time will not be perceived, as it is not time added after the animation but a delay running during the animation.

```sh
# /etc/systemd/system/plymouth-wait-for-animation.service
[Unit]
Description=Waits for Plymouth animation to finish
Before=plymouth-quit.service display-manager.service

[Service]
Type=oneshot
ExecStart=/usr/bin/sleep duration_of_your_animation

[Install]
WantedBy=plymouth-start.service
```

Then `enable` the service.

> [!NOTE]
> None of the previous methods will work if you are starting Plymouth from initramfs.

## References

- [wiki.archlinux.org: Plymouth](https://wiki.archlinux.org/title/Plymouth)
