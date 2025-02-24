# Discord

> [!WARNING]
> The content here may be outdated, and some parts have been adjusted according to my own needs, so it may not be applicable to you. The best approach is to refer to the official documentation, such as the `Arch Linux Wiki`. Or refer to the link below.

## Install BetterDiscord

You need to install the `betterdiscordctl` package from the AUR repository.

```sh
sudo pacman -S betterdiscordctl-git
```

Then, run the following command to install:

```sh
betterdiscordctl install
```

> [!NOTE]
> After each Discord update, you need to run the command again to ensure synchronization; otherwise, it will start with the original version of Discord.

Finally, reboot your `discord`.

## Themes & Plugins

Open your discord's settings and you can find `Themes` and `Plugins` sections.

Now, `BetterDiscord` has integrated a store internally, allowing you to search and install directly.
Of course, you can also install themes and plugins manually, please refer to [docs.betterdiscord.app/guides#installing-addons](https://docs.betterdiscord.app/users/guides/installing-addons).

## Dual Boot

`BetterDiscord` allows you to return to vanilla Discord functionality without having to remove BetterDiscord. This is useful for those that like to switch back and forth. This is done using the `--vanilla` command line flag. please refer to [docs.betterdiscord.app/guides#vanilla](https://docs.betterdiscord.app/users/guides/vanilla).

## References

- [betterdiscord.app](https://betterdiscord.app/)
- [docs.betterdiscord.app](https://docs.betterdiscord.app/)
