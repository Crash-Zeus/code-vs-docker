#!/usr/bin/env bash

#------------------------------------
# FUNCTIONS
#------------------------------------

fix_rights() {
    if [ -f "$HOME/.vscode/argv.json" ] && [ -f "$HOME/.config/Code/machineid" ] ; then
        echo "Folder existing, skipping"
    else
        echo "[CREATING FOLDER AND APPLY CORRECT RIGHT]"
        sudo -u root mkdir -p $HOME/.vscode && sudo -u root mkdir -p $HOME/.config && sudo -u root mkdir -p $HOME/.config/Code/User
        sudo -u root chown -R vscode $HOME/.vscode && chmod 777 -R $HOME/.vscode
        sudo -u root chown -R vscode $HOME/.config && chmod 777 -R $HOME/.config/Code
    fi
    sudo -u root mkdir -p $HOME/.local/share/nano && sudo -u root chmod 777 $HOME/.local/share/nano
}

function install_ext() {
    echo
    echo "[Installing extensions]"
    cat /init/requirement.txt | while read extension || [[ -n $extension ]];
    do
        exist=$(code --list-extensions | grep $extension)
        if [ "$exist" != "" ] ; then
            echo "$exist already installed, skipping"
        else
            echo
               echo "" | sudo -u vscode code --extensions-dir="$HOME/.vscode/extensions" --user-data-dir="$HOME/.vscode" --install-extension $extension
        fi
    done
}

function fix_group() {
    if [ -S /var/run/docker.sock ]; then
        DOCKER_GID=$(stat -c '%g' /var/run/docker.sock)
        sudo groupadd -for -g ${DOCKER_GID} docker
    fi
}

#------------------------------------
# MAIN
#------------------------------------

fix_rights
fix_group

echo
if [ -f "$HOME/.config/Code/User/settings.json" ] ; then
    echo "Skip copy settings.json file existing"
else
    echo "Copy settings.json"
    cp /init/settings.json $HOME/.config/Code/User/settings.json
fi

case $1 in

  "launch")
    code
    while pgrep -n code > /dev/null; do sleep 1; done
    ;;

  "install")
    install_ext
    ;;

  *)
    echo "Launching command $@"
    $@
    ;;
esac


