# oh-my-zsh plugin to sync

This plugin add `syncd` `syncu` global funtion

## Install & Run

Clone this repo to your local

```zsh
git clone https://github.com/cjahv/zsh-sync.git $ZSH_CUSTOM/plugins/sync
```

To use the plugin, add it in your plugin list in your `.zshrc`

```zsh
SYNC_HOST=mydomainname.com
plugins=(... sync ...)
```

Run `syncd` download

Run `syncu` update

Run `syncdiff` compare

## Exclusion file

`$HOME/.config/sync/exclude.txt`

It should be compatible with the `--exclude-from` parameter of rsync. See [this tutorial](https://sites.google.com/site/rsync2u/home/rsync-tutorial/the-exclude-from-option) for more information.

## Warning

THE FILE WILL BE DELETED
