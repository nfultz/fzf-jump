# fzf-jump
This tiny script, inspired by [fzf-marks](https://github.com/urbainvaes/fzf-marks), can be used to navigate folders in Bash. It is based on the command-line fuzzy-finder [fzf](https://github.com/junegunn/fzf) written by Junegunn Choi. Although the script is very short and simple, it is very convenient and can very quickly become an important part of your workflow.

Instead of listing just a hardcoded list of bookmarks, this lists the directories in the current directory, and the directories on the `pushd` stack.

## Installation
[fzf](https://github.com/junegunn/fzf) is required to use this plugin. Once this condition is met, it is sufficient to source the script from your shell configuration file.

## Usage
Most of the key mappings in the search window are the default fzf ones. The most relevant ones are:

- **Enter** to accept a match.
- **ctrl-c** do nothing.
- **ctrl-f** recursively jump into selection.
- **ctrl-b** recursively jump into the parent directory (`..`).
- **ctrl-g** flip to the next directory on the `pushd` stack.
- **ctrl-h** jump into the directory being listed, not the selection.
- **ctrl-x** change to the directory exactly as typed

In Bash, the script creates a commands:

- **jump** to jump to a given bookmark using fzf. 
- You can bind this to a shortcut in your configuration files, for example using `bind '"\C-g":" jump\n"'	`. I recommend prefixing the command with a space, so jump will not appear in your history if you have `HISTCONTROL=ignorespace` set.

## Sources

- https://github.com/junegunn/fzf
- https://github.com/urbainvaes/fzf-marks

## Author

Urbain Vaes (original), Neal Fultz (rewrite)
