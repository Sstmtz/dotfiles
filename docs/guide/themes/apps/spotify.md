# Spotify

> [!WARNING]
> The content here may be outdated, and some parts have been adjusted according to my own needs, so it may not be applicable to you. The best approach is to refer to the official documentation, such as the `Arch Linux Wiki`. Or refer to the link below.

> [!WARNING]
> The software has regional restrictions; for example, it cannot be accessed in mainland China, and you may need to use a VPN to bypass these restrictions.

The software has two versions: `Spotify Free` and `Spotify Premium`. We will use free version.

## Install spicetify

You need to install the `spicetify-cli` package from the AUR repository.

```sh
sudo pacman -S spicetify-cli
```

If you install `spotify` package, it will be installed to `/opt/spotify`, so you need to gain write permission on Spotify files, by running command:

```sh
sudo chmod a+wr /opt/spotify
sudo chmod a+wr /opt/spotify/Apps -R
```

> [!NOTE]
> If Spotify is installed through the `spotify-launcher` package, then Spotify won't install to `/opt/spotify` and is instead in this folder: `$HOME/.local/share/spotify-launcher/install/usr/share/spotify/`. This directory will need to be added to the `spotify-path` section of the config (and you won't need to change any permissions like the AUR method).

> [!WARNING]
> `spotify-path` must be an abslolute path. Do not use ~ to reference the home folder.

```sh
# edit ~/.config/spicetify/config-xpui.ini, modify the following line:
[Setting]
spotify_path           = $HOME/.local/share/spotify-launcher/install/usr/share/spotify/
```

Finally, run the following command to apply the changes:

```sh
spicetify apply
# maybe need to run
spicetify backup apply
```

## Themes & Plugins

Spicetify offer three sections: `Themes`, `Extensions`, `Custom Apps`.

If you have installed `spotify` package, you can also install `spicetify-marketplace-bin`, It will have a built-in store in Spotify, allowing you to search and install directly.

But if you have installed `spotify-launcher`, it does not work, so you need to set it up manually.

Spicetify provides some default lists, which you can find in the `/opt/spicetify-cli` directory. For information on how to set it up and obtain them, please refer to the [official documentation](https://spicetify.app/docs/advanced-usage/).

For example, we add `autoSkipVideo` extension.

```sh
spicetify config extensions autoSkipVideo.js
Spotify apply
```

## References

- [spicetify.app](https://spicetify.app/)
- [spicetify.app/docs](https://spicetify.app/docs/getting-started)
