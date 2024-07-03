# dotfiles

My dotfiles, managed by [chezmoi](https://www.chezmoi.io/).

> Currently very Window's focused.

## Future plans

- [ ] Migrate to `mise-en-place` for managing toolchains (N.B. currently does not support Windows)
- [ ] Migrate to `nix` flakes

## Installation

```sh
./install.sh
```

## Add a new stuff to the source state (your local dotfile repo)

```sh
# for the initial addition
chezmoi add ~/path/to/new/stuff

# if you accidentally make changes to the destination (the actual file)
chezmoi re-add ~/path/to/new/stuff
```

## Modify dotfiles

Chezmoi uses a `git`-like workflow. You modify the dotfiles in the source state (your local dotfile repo) and then apply the changes to the destination (the actual file).

```sh
# Opens your default text editor (set by $EDITOR or $VISUAL)
chezmoi edit

# apply the changes
chezmoi apply -v
```

## Pull and apply the latest changes from the remote repo

```sh
chezmoi update -v
```

## Clear the state of all `run_onchange` and `run_once` scripts

```sh
# for run_onchange scripts
chezmoi state delete-bucket --bucket=entryState

# for run_once scripts
chezmoi state delete-bucket --bucket=scriptState
```
