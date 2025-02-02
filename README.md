# Dotfiles

## Requirements

You need to install [chezmoi](https://github.com/twpayne/chezmoi) first.

```sh
# by pacman
sudo pacman -S chezmoi
```

After cloning this repo, you need to run `install_pkg.sh` in scripts directory to install required packages.

## Installation

### Directly clone the dotfiles

It will clone the dotfiles into ~/.local/share/chezmoi/, then you can run `chezmoi diff` to check what changes that chezmoi will make to your home directory. If you are not happy with the changes to a file then either edit it with: `chezmoi edit <file>` or directory edit by your text editor.

Finally, run `chezmoi apply -v` to apply the changes to your home directory.

- References:
  - [Using chezmoi across multiple machines](https://www.chezmoi.io/quick-start/#using-chezmoi-across-multiple-machines)
  - [init command](https://www.chezmoi.io/reference/commands/init/)

```sh
# by HTTPS (default)
chezmoi init --branch chezmoi https://github.com/Sstmtz/dotfiles.git
# by SSH, add --ssh 
chezmoi init --branch chezmoi --ssh git@github.com:Sstmtz/dotfiles.git
chezmoi apply -v

# single command
chezmoi init --branch chezmoi --apply https://github.com/Sstmtz/dotfiles.git
```

### Migrate from a dotfile manager that uses symlinks

The main branch is managed using [stow](https://github.com/aspiers/stow), which creates many symbolic links in the home directory pointing to the corresponding files in the dotfiles directory. If you want to switch to chezmoi for management, using `chezmoi add` directly will result in adding link files instead of the actual files themselves. You just need to add the `--follow` flag.

- References:
  - [Migrating from another dotfile manager](https://www.chezmoi.io/migrating-from-another-dotfile-manager/)

```sh
chezmoi add --follow <your_symlink>
# --follow: replace the <your_symlink> symlink with the file contents.
```

## Encryption

It is important to note that since some files are encrypted, running `chezmoi apply` after you complete `chezmoi init` to clone this repository will result in related errors. Don't worry; the non-encrypted files have already been copied to your home directory.

**The following paragraph is addressed to myself, but if you want to encrypt files in your own dotfiles, you can refer to them.**

My partial files are encrypted using tools like [gpg](https://github.com/gpg/gnupg) or [age](https://github.com/FiloSottile/age), for example, ssh. You can use the `decrypt-private-key.sh` script in the scripts directory and enter the key to decrypt them. Finally, generate the `key.txt` public key in the ~/.config/chezmoi directory, and then run `chezmoi apply`.

- References:
  - [How do I configure chezmoi to encrypt files but only request a passphrase the first time chezmoi init is run?](https://www.chezmoi.io/user-guide/frequently-asked-questions/encryption/)

## Why is there this branch?

I usually use both of them at the same time, but I mainly use stow because it is simple and intuitive.

1. The symbolic link points to the file itself, so changes take effect immediately without the need for manual submission.
2. The symbolic links allow me to easily see which files are managed by dotfiles when I browse the home directory.
3. Creating a symbolic link takes up less space than copying a file.

However, symbolic links are not secure. They can become corrupted for various reasons and may not be easily noticeable. Therefore, I use chezmoi as a backup in case of unexpected issues.
