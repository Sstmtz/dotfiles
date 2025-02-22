# Fcitx5

Add the following content to `/etc/environment`:

```sh
INPUT_METHOD=fcitx
XMODIFIERS="@im=fcitx"
SDL_IM_MODULE=fcitx
GLFW_IM_MODULE=ibus
```

In Qt 6.7, there is a new environment variable called "QT_IM_MODULES", which allows you so specify a fallback order on im modules. You can set it to

```sh
QT_IM_MODULES="wayland;fcitx;ibus"
```

> [!WARNING]
> For KDE Plasma, If you set `GTK_IM_MODULE`/`QT_IM_MODULE` globally, you will hit this issue Candidate window is blinking under wayland with Fcitx 5.

Certain Gtk/Qt application that only works under X11 may still need to set `GTK_IM_MODULE` or `QT_IM_MODULE` for them individually.

Best practices: not set `GTK_IM_MODULE`/`QT_IM_MODULE` in /etc/environment.

```sh
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
```

For GTK2, add following content to `~/.gtkrc-2.0`:

```sh
gtk-im-module="fcitx"
```

For GTK 3, add following content to `~/.config/gtk-3.0/settings.ini`:

```sh
[Settings]
gtk-im-module=fcitx
```

For GTK 4, add following content to `~/.config/gtk-4.0/settings.ini`:

```sh
[Settings]
gtk-im-module=fcitx
```

## References

- [wiki.archlinuxcn.org: Fcitx5](https://wiki.archlinuxcn.org/wiki/Fcitx5)
- [Fcitx5 Wiki](https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland)
