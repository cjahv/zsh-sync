if [ ! $SYNC_HOST ];then
    echo "没有设置SYNC_HOST"
fi

function syncd() {
    dir=$1
    [ ! "$dir" ] && dir=`pwd`
    [[ "${dir:0:1}" != "/" ]] && dir=$(realpath "`pwd`/${dir}")
    echo "向下同步$dir?[y/n] "
    read -q input
    if [[ "$input" == "y" ]];then
        echo ''
        mkdir -p $dir
        dir="$dir/"
        [ -f $HOME/.config/sync/exclude.txt ] && exclude_from="--exclude-from=$HOME/.config/sync/exclude.txt"
        echo $dir
        /usr/local/bin/rsync --rsync-path=/usr/local/bin/rsync -avpzls --delete $exclude_from $USER@$SYNC_HOST:"${dir}" "$dir"
    fi
}

function syncu() {
    dir=$1
    [ ! "$dir" ] && dir=`pwd`
    [[ "${dir:0:1}" != "/" ]] && dir=$(realpath "`pwd`/${dir}")
    echo "向上覆盖$dir?[y/n] "
    read -q input
    if [[ "$input" == "y" ]];then
        echo ''
        [ -d "$dir" ] && dir="$dir/"
        [ -f $HOME/.config/sync/exclude.txt ] && exclude_from="--exclude-from=$HOME/.config/sync/exclude.txt"
        /usr/local/bin/rsync --rsync-path=/usr/local/bin/rsync -avpzls --delete $exclude_from $dir $USER@$SYNC_HOST:$dir
    fi
}

function syncdiff() {
    dir=$1
    [ ! "$dir" ] && dir=`pwd`
    [[ "${dir:0:1}" != "/" ]] && dir=$(realpath "`pwd`/${dir}")
    [ -d "$dir" ] && dir="$dir/"
    [ -f $HOME/.config/sync/exclude.txt ] && exclude_from="--exclude-from=$HOME/.config/sync/exclude.txt"
    /usr/local/bin/rsync --rsync-path=/usr/local/bin/rsync -avpzlsn --delete $exclude_from "$dir" $USER@$SYNC_HOST:"$dir"
}
