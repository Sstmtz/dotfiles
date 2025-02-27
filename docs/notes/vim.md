# Vim

| Keys                                                 | Action                          |
| :--------------------------------------------------- | :------------------------------ |
| <kbd>j</kbd>                                         | Move down                       |
| <kbd>k</kbd>                                         | Move up                         |
| <kbd>h</kbd>                                         | Move left                       |
| <kbd>l</kbd>                                         | Move right                      |
| <kbd>g</kbd> * 2                                     | Move to the first line          |
| <kbd>Shift</kbd> + <kbd>g</kbd>                      | Move to the last line           |

> [!NOTE]
> Punctuation (such as `,`, `!`,`?`) are also considered separate words.

| Keys                                                 | Action                          |
| :--------------------------------------------------- | :------------------------------ |
| <kbd>b</kbd>                                         | Jump to the beginning of the next word         |
| <kbd>e</kbd>                                         | Jump to the end of the next word               |
| <kbd>0</kbd>                                         | Jump to the beginning of the current line         |
| <kbd>Shift</kbd> + <kbd>4</kbd>                      | Jump to the end of the current line               |
| <kbd>Shift</kbd> + <kbd>%</kbd>                      | Toggle between the left and right parentheses     |

| Keys                                                 | Action                          |
| :--------------------------------------------------- | :------------------------------ |
| <kbd>w</kbd>                                         | Stop at punctuation(such as `,`,`!`,`?`)         |
| <kbd>Shift</kbd> + <kbd>w</kbd>                      | Stop at whitespace                         |

| Keys                                                 | Action                          |
| :--------------------------------------------------- | :------------------------------ |
| <kbd>d</kbd> * 2                                              | Delete the current line         |
| <kbd>Shift</kbd> + <kbd>d</kbd>                               |  Delete all content to the right        |
| <kbd>d</kbd> + <kbd>i</kbd> + <kbd>Shift</kbd> + <kbd>9</kbd> |  Delete all content in the parentheses  |
| <kbd>c</kbd> + <kbd>i</kbd> + <kbd>Shift</kbd> + <kbd>9</kbd> |  Delete all content in the parentheses and enter insert mode  |

This is a example, try use `w` and `W` individually:

```text
These,are,many,words but,noly,two,WORDS.
```

```c
printf("Hello, World!");
```
