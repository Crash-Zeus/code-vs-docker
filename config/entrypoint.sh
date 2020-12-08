#!/usr/bin/env bash

fix_rights() {
    echo "Creating folder and check rights"
    mkdir -p /home/dev/.vscode && mkdir -p /home/dev/.config
    mkdir -p /home/dev/.config/Code/User
    chown -R dev /home/dev/.vscode && chmod 777 -R /home/dev/.vscode
    chown -R dev /home/dev/.config && chmod 777 -R /home/dev/.config
}

function install_ext() {
    echo
    echo "Installing extension"
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

install_ext

echo
if [ !-f "/home/dev/.config/Code/User/settings.json" ] ; then
    echo "Copy settings.json"
    mv /init/settings.json /home/dev/.config/Code/User/settings.json
else
    echo "Skip copy settings.json file existing"
fi

echo
echo "Launching command $@"
$@
