# Dotfiles

## Installation

### Directly clone the dotfiles

It will clone the dotfiles into ~/.local/share/chezmoi/, then you can run `chezmoi diff` to check what changes that chezmoi will make to your home directory. If you are not happy with the changes to a file then either edit it with: `chezmoi edit <file>` or directory edit by your text editor.

Finally, run `chezmoi apply -v` to apply the changes to your home directory.

- References:
  - [Using chezmoi across multiple machines](https://www.chezmoi.io/quick-start/#using-chezmoi-across-multiple-machines)
  - [init command](https://www.chezmoi.io/reference/commands/init/)

```sh
# by HTTPS (default)
chezmoi init https://github.com/Sstmtz/dotfiles.git
# by SSH, add --ssh 
chezmoi init --ssh git@github.com:Sstmtz/dotfiles.git
chezmoi apply -v

# single command
chezmoi init --apply https://github.com/Sstmtz/dotfiles.git
```

### Migrate from a dotfile manager that uses symlinks

The main branch is managed using [stow](https://github.com/aspiers/stow), which creates many symbolic links in the home directory pointing to the corresponding files in the dotfiles directory. If you want to switch to chezmoi for management, using `chezmoi add` directly will result in adding link files instead of the actual files themselves. You just need to add the `--follow` flag.

- References:
  - [Migrate away from chezmoi](https://www.chezmoi.io/user-guide/advanced/migrate-away-from-chezmoi/)

```sh
chezmoi add --follow <your_symlink>
# --follow: replace the <your_symlink> symlink with the file contents.
```

## Why is there this branch?

I usually use both of them at the same time, but I mainly use stow because it is simple and intuitive.

1. The symbolic link points to the file itself, so changes take effect immediately without the need for manual submission.
2. The symbolic links allow me to easily see which files are managed by dotfiles when I browse the home directory.
3. Creating a symbolic link takes up less space than copying a file.

However, symbolic links are not secure. They can become corrupted for various reasons and may not be easily noticeable. Therefore, I use chezmoi as a backup in case of unexpected issues.
