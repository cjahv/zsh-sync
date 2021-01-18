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

## Warning

THE FILE WILL BE DELETED
