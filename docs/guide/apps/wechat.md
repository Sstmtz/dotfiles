# WeChat (微信)

> [!WARNING]
> The content here may be outdated, and some parts have been adjusted according to my own needs, so it may not be applicable to you. The best approach is to refer to the official documentation, such as the `Arch Linux Wiki`. Or refer to the link below.

> [!WARNING]
> The software is only designed for Chinese users and does not offer other languages.

## Installation

You can install `wechat-bin` or `wechat`.

```sh
# Official vesion, supports Mini Programs, Moments, VoIP and more.
sudo pacman -S wechat-bin
# provides other fixes for input method, HiDPI and more.
sudo pacman -S wechat
```

> [!NOTE]
> if you have installed `wechat`, it already fixes the following issues, you can skip the following steps.

## Fix issues

> [!NOTE]
> If you has installed `wechat`, it may have fixed the following issues.
> Therefore, you can skip the following steps.

`WeChat` is currently not built for Wayland, so it runs under `Xwayland`, resulting in the following issues:

1. HiDPI font size issue.
2. Screen scaling issue.
3. `fcitx5` input method is not available.
4. ......

To fix these issues, you can use the following steps:

First, copy `wechat.desktop` to the local `applications` folder.

```sh
sudo cp /usr/share/applications/wechat.desktop ~/.local/share/applications/
```

Then, edit `~/.local/share/applications/wechat.desktop` and add the following content:

```sh
Exec=env GTK_IM_MODULE=fcitx QT_IM_MODULE=fcitx QT_FONT_DPI=169 QT_AUTO_SCREEN_SCALE_FACTOR=1 ...
```

> [!NOTE]
>
> - `GTK_IM_MODULE=fcitx`: Resolve the issue of fcitx5 input method not being available.
> - `QT_IM_MODULE=fcitx`: Resolve the issue of fcitx5 input method not being available.
> - `QT_FONT_DPI=169`: Fix issues such as fonts being too small on HiDPI displays (default is 96(1.0)).
> - `QT_AUTO_SCREEN_SCALE_FACTOR=1`: Fix scaling issues.

You can refer to my [wechat.desktop](../../../home/dot_local/share/applications/wechat.desktop)

## References

- [wiki.archlinux.org: Wechat](https://wiki.archlinux.org/title/WeChat)
- [wiki.archlinuxcn.org: 微信](https://wiki.archlinuxcn.org/wiki/微信)
