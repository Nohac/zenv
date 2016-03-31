# TODO: If ZENV_ROOT!=zenv_pwd, source new .zenv and reset ZENV_ROOT
# TODO: Add verification for new zenv and updated zenv

function chpwd {
    local zenv_pwd="$(zenv_locate_root)"
    zenv_eval_interface
    local interface=$?

    if [ "$zenv_pwd" = "" ] && [ "$ZENV_ROOT" != "" ] ; then
        echo "exit env"
        if [ $interface -eq 0 ] ; then
            echo "Downing environment"
            zenv_down
            unfunction zenv_down
            unfunction zenv_up
        fi
        unset ZENV_ROOT
        
        return
    fi

    if [ "$zenv_pwd" != "" ] ; then
        if [ "$ZENV_ROOT" = "" ] ; then
            export ZENV_ROOT="$zenv_pwd"
            source "$zenv_pwd/.zenv"
            zenv_eval_interface
            interface=$?

            if [ $interface -eq 0 ] ; then
                echo "Upping environment"
                zenv_up
            fi
        fi
    fi
}

function zenv_eval_interface {
    which zenv_up 1>/dev/null 2>&1
    local up=$?
    which zenv_down 1>/dev/null 2>&1
    local down=$?

    if [ $up -eq 0 ] && [ $down -eq 0 ] ; then
        return 0
    fi

    return 1
}

function zenv_locate_root {
    local zenv_root
    zenv_root=$(pwd -P 2>/dev/null || command pwd)
    while [ ! -e "$zenv_root/.zenv" ] ; do
        zenv_root=${zenv_root%/*}
        if [ "$zenv_root" = "" ] ; then break; fi
    done
    echo $zenv_root
}
