# Introduction

This is a repository for my personal dotfiles

# Usage

The naming of the files can be a bit confusing as the files are named from the point of view of the repo.

Import &#8594; import from local config to the repo
Export &#8594; export repo config to local

## Importing and Exporting

Generally these two are used the same, they just do the opposite.

Example: Export everything to the local config
```sh
> lua export.lua
```

By passing arguments in form of the name of a config you can only import/export a single config

Example: Import NeoVim to the repo
```sh
> lua import.lua nvim
```

## Configuration

In the `directories.lua` file configs can be added, they are discerned by their parent directory (i.e. `~/.config/`) and then the config name.

# ToDo
- [ ] Refactor `directories.lua` to be per directory
- [ ] Undo function
