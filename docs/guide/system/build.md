# Package optimization

## Add optimization parameters for native compilation

### configurate makepkg.conf

Create a user configuration file `~/.makepkg.conf` in the home directory to override system settings:

```sh
CFLAGS="-march=native -mtune=native -O2 -pipe -fno-plt -fexceptions \
      -Wp,-D_FORTIFY_SOURCE=3 -Wformat -Werror=format-security \
      -fstack-clash-protection -fcf-protection"
CXXFLAGS="$CFLAGS -Wp,-D_GLIBCXX_ASSERTIONS"
RUSTFLAGS="-C opt-level=3 -C target-cpu=native -C link-arg=-z -C link-arg=pack-relative-relocs"
MAKEFLAGS="-j$(nproc) -l$(nproc)"
```

> [!WARNING]
> These compiler flags can extract maximum performance during compilation, but they may cause build errors in very few applications. If this happens, disable the 'lto' parameter in the options line by adding an exclamation mark ! in front of it ("!lto").

### Enable ccache

Ccache is a cache for C/C++ compilers, specifically compatible with GCC/Clang, aimed at speeding up the process of recompiling the same code. This means that if the same source code blocks are found when building a new version of a program compared to an old version, those source files will not be recompiled. Instead, the previously compiled code will be retrieved from the ccache cache. It is through this method that the compilation process achieves significant acceleration.

Add the following content to `~/.makepkg.conf`:

```sh
BUILDENV=(!distcc color ccache check !sign)
```

> [!WARNING]
> Ccache may break the build of certain programs, so please use it with caution.

### Build in memory using tmpfs

During the build process, many temporary intermediate files are compiled and written to disk (HDD/SSD) to be subsequently combined into an executable file or library. To speed up the package building process, memory outside of HDD/SSD, specifically tmpfs, can be used. Since memory is significantly faster than any HDD or SSD, the build process will be quicker. Additionally, this can reduce the load on system input/output, thereby decreasing disk wear. There are various methods to use tmpfs with makepkg.

#### 1. Specify the variable directly before the build

```sh
# ~/.makepkg.conf
BUILDDIR=/tmp/makepkg makepkg -sric
```

#### 2. To build everything

Set the parameter (uncomment in the file `/etc/makepkg.conf`) BUILDDIR to use the directory /tmp:

```sh
# /etc/makepkg.conf
BUILDDIR=/tmp/makepkg
```

#### 3. Create a separate tmpfs directory of a specified size

You need to add the directory to the mount point of tmpfs in /etc/fstab, specifying the path and the maximum capacity of the directory. This directory can expand while tmpfs is running (note that tmpfs uses memory, so carefully consider the allocated capacity; it should not exceed the total amount of available memory, although tmpfs initially does not occupy any space), for example:

```sh
# /etc/fstab
# not forget to modify the size
tmpfs   /var/tmp/makepkg         tmpfs   rw,nodev,nosuid,size=16G          0  0
```

Then, specify `BUILDDIR` in `/etc/makepkg.conf`.

```sh
# /etc/fstab
# notice: need to use the directory path specified in fstab.
BUILDDIR=/var/tmp/makepkg
```

You can check the amount of available and used space in tmpfs:

```sh
df -h | grep tmpfs
```

---

## Install optimization package

Native compilation is certainly great, but not everyone has the time to do such things, and no one wants to recompile the entire system with native flags (otherwise you would go to: [gentoo](https://gentoo.org)). So the question arises: how to accomplish all of this with minimal effort?

[ALHP](https://somegit.dev/ALHP/ALHP.GO): Go based buildbot to build official Archlinux repos with x86-64 feature levels, -O3 and LTO

### 1. Check your system for support

Check which feature levels your CPU supports with:

```sh
/lib/ld-linux-x86-64.so.2 --help
```

Example output snippet for a system supporting up to x86-64-v3:

```txt
Subdirectories of glibc-hwcaps directories, in priority order:
  x86-64-v4
  x86-64-v3 (supported, searched)
  x86-64-v2 (supported, searched)
```

### 2. Install keyring & mirrorlist

```sh
yay -S alhp-keyring alhp-mirrorlist
```

### 3. Choose a mirror (optional)

Edit /etc/pacman.d/alhp-mirrorlist and comment in/out the mirrors you want to enable/disable. By default, a CDN mirror provided by ALHP is selected.

### 4.  Modify pacman.conf

Add the ALHP repos to your /etc/pacman.conf. Make sure the appropriate ALHP repository is above the Archlinux repo.

```txt
[core-x86-64-v3]
Include = /etc/pacman.d/alhp-mirrorlist

[core]
Include = /etc/pacman.d/mirrorlist

[extra-x86-64-v3]
Include = /etc/pacman.d/alhp-mirrorlist

[extra]
Include = /etc/pacman.d/mirrorlist

# if you need [multilib] support
[multilib-x86-64-v3]
Include = /etc/pacman.d/alhp-mirrorlist

[multilib]
Include = /etc/pacman.d/mirrorlist
```

Replace x86-64-v3 with the x86-64 feature level you want to enable.

---

## References

- [AUR: build](https://ventureo.codeberg.page/source/build.html#)
- [wiki.archlinux.org: Improving performance](https://wiki.archlinux.org/title/Improving_performance)
