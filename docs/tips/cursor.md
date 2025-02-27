# Cursor

Taking the `Breeze` cursor theme as an example, it includes cursors of the following pixel sizes:

- 12 (0.5)
- 18 (0.75)
- 24 (1.0)    (default)
- 30 (1.25)
- 36 (1.5)
- 42 (1.75)
- 48 (2.0)
- 54 (2.25)
- 60 (2.5)
- 66 (2.75)
- 72 (3.0)

Typically, standard cursor themes only provide cursor sizes in integer multiples such as `24`, `48`, and `72` pixels. Better themes also offer cursor sizes like `36` (1.5) and `60` (2.5) pixels, which are fractional multiples. The Breeze theme, as mentioned in the example above, also provides a wider range of cursor sizes to cover the majority of screen scaling ratios.

- Nominal size
- Image size

"Nominal size" is the "cursor size" we are talking about above. It makes the list of sizes you choose from in the cursor theme settings UI. It's also the size you set in `XCURSOR_SIZE`. "Image size" is the actual size of the cursor image.

1. image size == nominal size
2. image size >  nominal size

GNOME's default cursor theme (`Adwaita`) meets the first condition.

KDE Plasma's default cursor theme (`Breeze`) meets the second condition. It displays without issues on applications built with frameworks like `QT` and `Electron`, but if you use this theme on a `GTK4` application, you will likely see a magnified and blurry cursor.

## References

- [GTK issues#7722](https://gitlab.gnome.org/GNOME/gtk/-/merge_requests/7722)
- [GTK issues#7749](https://gitlab.gnome.org/GNOME/gtk/-/merge_requests/7749)
- [Cursor Size Problems In Wayland, Explained](https://blogs.kde.org/2024/10/09/cursor-size-problems-in-wayland-explained/)
- [SVG cursors: everything that you need to know about them](https://blog.vladzahorodnii.com/2024/10/06/svg-cursors-everything-that-you-need-to-know-about-them/)
- [Wayland Protocol: Cursor shape](https://wayland.app/protocols/cursor-shape-v1)
