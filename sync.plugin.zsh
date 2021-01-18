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
        rsync -avpz --delete $USER@$SYNC_HOST:$dir/ $dir/
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
        rsync -avpz --delete $dir/ $USER@$SYNC_HOST:$dir/
    fi
}
