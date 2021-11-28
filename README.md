# oh-my-zsh plugin to sync

oh-my-zsh 多 pc 同步插件

同步依赖 `rsync`

## Install & Run

```zsh
git clone https://github.com/cjahv/zsh-sync.git $ZSH_CUSTOM/plugins/sync
```

添加插件到 `.zshrc`

```zsh
# 同步的远程地址，用户为当前登录用户，授权请使用ssh密钥
SYNC_HOST=mydomainname.com
plugins=(... sync ...)
```

`syncd <dir>` 同步远程到本地

`syncu <dir>` 同步本地到远程

`syncdiff <dir>` 比较本地和远程

## 排除文件

全局排除文件 `$HOME/.config/sync/exclude.txt`

目录排除文件 `<dir>/.syncignore`

It should be compatible with the `--exclude-from` parameter of rsync. See [this tutorial](https://sites.google.com/site/rsync2u/home/rsync-tutorial/the-exclude-from-option) for more information.

## Warning

同步时会删除文件
