#!/usr/bin/env bash

fix_rights() {
    if [ -f "/home/dev/.vscode/argv.json" ] && [ -f "/home/dev/.config/Code/machineid" ] ; then
        echo "Folder existing, skipping"
    else
        echo "[CREATING FOLDER AND APPLY CORRECT RIGHT]"
        sudo -u root mkdir -p /home/dev/.vscode && sudo -u root mkdir -p /home/dev/.config && sudo -u root mkdir -p /home/dev/.config/Code/User
        sudo -u root chown -R dev /home/dev/.vscode && chmod 777 -R /home/dev/.vscode
        sudo -u root chown -R dev /home/dev/.config && chmod 777 -R /home/dev/.config/Code
    fi
}

function install_ext() {
    echo
    echo "[Installing extension]"
    cat /init/requirement.txt | while read extension || [[ -n $extension ]];
    do
        exist=$(code --list-extensions | grep $extension)
        if [ "$exist" != "" ] ; then
            echo "$exist already installed, skipping"
        else
            echo
               echo "" | sudo -u dev code --install-extension $extension
        fi
    done
}

fix_rights

echo
if [ -f "/home/dev/.config/Code/User/settings.json" ] ; then
    echo "Skip copy settings.json file existing"
else
    echo "Copy settings.json"
    cp /init/settings.json /home/dev/.config/Code/User/settings.json
fi

install_ext

echo
echo "Launching command $@"
$@
