if [ ! $SYNC_HOST ];then
    echo "没有设置SYNC_HOST"
fi

function syncd() {
    dir=$1
    [ ! "$dir" ] && dir=`pwd`
    [[ "${dir:0:1}" != "/" ]] && dir=$(realpath "`pwd`/${dir}")
    echo ''
    mkdir -p $dir
    dir="${dir}/"
    dir=${dir%/*}
    dir="${dir// /\\ }/"
    [ -f $HOME/.config/sync/exclude.txt ] && exclude_from="--exclude-from=$HOME/.config/sync/exclude.txt"
    [ -f $dir.syncignore ] && exclude_from="--exclude-from=$dir.syncignore $exclude_from"
    echo "rsync --rsync-path=/usr/local/bin/rsync -avpzls --delete $exclude_from $USER@$SYNC_HOST:"${dir}" "$dir""
    eval "/usr/local/bin/rsync --rsync-path=/usr/local/bin/rsync --dry-run -avpzls --delete $exclude_from $USER@$SYNC_HOST:"${dir}" "$dir""
    echo "向下同步$dir?[y/n] "
    read -q input
    if [[ "$input" == "y" ]];then
        eval "/usr/local/bin/rsync --rsync-path=/usr/local/bin/rsync -avpzls --delete $exclude_from $USER@$SYNC_HOST:"${dir}" "$dir""
    fi
}

function syncu() {
    dir=$1
    [ ! "$dir" ] && dir=`pwd`
    [[ "${dir:0:1}" != "/" ]] && dir=$(realpath "`pwd`/${dir}")
    echo ''
    [ -d "$dir" ] && dir="$dir/"
    [ -f $HOME/.config/sync/exclude.txt ] && exclude_from="--exclude-from=$HOME/.config/sync/exclude.txt"
    [ -f $dir.syncignore ] && exclude_from="--exclude-from=$dir.syncignore $exclude_from"
    dir="${dir}/"
    dir=${dir%/*}
    dir="${dir// /\\ }/"
    echo "rsync --rsync-path=/usr/local/bin/rsync -avpzls --delete $exclude_from $dir $USER@$SYNC_HOST:$dir"
    eval "/usr/local/bin/rsync --rsync-path=/usr/local/bin/rsync --dry-run -avpzls --delete $exclude_from $dir $USER@$SYNC_HOST:$dir"
    echo "向上覆盖$dir?[y/n] "
    read -q input
    if [[ "$input" == "y" ]];then
        eval "/usr/local/bin/rsync --rsync-path=/usr/local/bin/rsync -avpzls --delete $exclude_from $dir $USER@$SYNC_HOST:$dir"
    fi
}

function syncdiff() {
    dir=$1
    [ ! "$dir" ] && dir=`pwd`
    [[ "${dir:0:1}" != "/" ]] && dir=$(realpath "`pwd`/${dir}")
    [ -d "$dir" ] && dir="$dir/"
    [ -f $HOME/.config/sync/exclude.txt ] && exclude_from="--exclude-from=$HOME/.config/sync/exclude.txt"
    [ -f $dir.syncignore ] && exclude_from="--exclude-from=$dir.syncignore $exclude_from"
    dir="${dir}/"
    dir=${dir%/*}
    dir="${dir// /\\ }/"
    eval "/usr/local/bin/rsync --rsync-path=/usr/local/bin/rsync --dry-run -avpzlsn --delete $exclude_from "$dir" $USER@$SYNC_HOST:"$dir""
}

function syncl() {
    dir=$1
    [ ! "$dir" ] && dir=`pwd`
    [[ "${dir:0:1}" != "/" ]] && dir=$(realpath "`pwd`/${dir}")
    [ -d "$dir" ] && dir="$dir/"
    [ -f $HOME/.config/sync/exclude.txt ] && exclude_from="--exclude-from=$HOME/.config/sync/exclude.txt"
    [ -f $dir.syncignore ] && exclude_from="--exclude-from=$dir.syncignore $exclude_from"
    dir="${dir// /\\ }/"
    dir=${dir%/*}
    ssh $USER@$SYNC_HOST "ls $dir | sed "s:^:$dir:""
}
