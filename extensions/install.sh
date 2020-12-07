#!/usr/bin/env bash



cat /init_extention/requirement.txt | while read extension || [[ -n $extension ]];
do
    exist=$(code --list-extensions | grep $extension)
    if [ "$exist" != "" ] ; then
        echo "$exist already installed, skipping"
    else
        echo "Installing ext $extension"
        code --install-extension $extension
    fi
done
