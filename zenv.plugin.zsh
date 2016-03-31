function chpwd {
    local zenv_pwd="$(zenv_locate_root)"

    if [ "$zenv_pwd" = "" ] && [ "$ZENV_ROOT" != "" ]; then
        echo "exit env"
        unset ZENV_ROOT
        return
        # This should have worked
        # exec $SHELL -l
    fi

    if [ "$zenv_pwd" != "" ]; then
        if [ "$ZENV_ROOT" = "" ]; then
            export ZENV_ROOT="$zenv_pwd"
            source "$zenv_pwd/.zenv"
        fi
    fi
}

function zenv_locate_root {
    local zenv_root
    zenv_root=$(pwd -P 2>/dev/null || command pwd)
    while [ ! -e "$zenv_root/.zenv" ]; do
        zenv_root=${zenv_root%/*}
        if [ "$zenv_root" = "" ]; then break; fi
    done
    echo $zenv_root
}
