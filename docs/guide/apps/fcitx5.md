# Fcitx5

## Basic Settings

> [!WARNING]
> The content here may be outdated, and some parts have been adjusted according to my own needs, so it may not be applicable to you. The best approach is to refer to the official documentation, such as the `Arch Linux Wiki`. Or refer to the link below.

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

> [!NOTE]
> If you are using KDE Plasma, installing `fcitx5-configtool` will automatically integrate it into the `input method` settings of the system. Remember to set the virtual keyboard to `fcitx5 wayland (experimental)`.

## About GTK_IM_MODULE and QT_IM_MODULE

> [!WARNING]
> For KDE Plasma, If you set `GTK_IM_MODULE`/`QT_IM_MODULE` globally, you will hit this issue Candidate window is blinking under wayland with Fcitx 5.

```sh
# not set them in /etc/environment
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
```

Certain Gtk/Qt application that only works under X11 may still need to set `GTK_IM_MODULE` or `QT_IM_MODULE` for them individually.

Best practices: not set `GTK_IM_MODULE` / `QT_IM_MODULE` in /etc/environment`. Set them individually for the applications that need it.

For GTK applications, if you do not set `GTK_IM_MODULE`, you can also specify the input method as fcitx5 using the following method.

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

For Qt applications, there is currently no better unified method, and developers need to adapt. Fortunately, most Qt5/Qt6 desktop applications support fcitx5.

## References

- [wiki.archlinuxcn.org: Fcitx5](https://wiki.archlinuxcn.org/wiki/Fcitx5)
- [Fcitx5 Wiki](https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland)
