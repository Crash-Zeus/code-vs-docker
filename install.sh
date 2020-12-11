#!/bin/bash
sudo echo "Install vsdocker"

docker_img=crashzeus/vsdocker:stable

read -p "Build localy ? Y/n " build_local

if [ "$build_local" == "Y" ] || [ "$build_local" == "y" ] || [ "$build_local" == "" ] || [ "$build_local" == "yes" ] || [ "$build_local" == "Yes" ] ; then
  echo "Build local image"
  docker build -t $docker_img .
else
  echo "Pull $docker_img"
  docker pull $docker_img
fi

# Création du fichier des alias 
alias_file="$HOME/.dockcode-alias"
echo "- Create alias file : $alias_file"
echo "# - ALIAS dockcode ----------
alias dockcode=\"docker run --rm -d \\
    --user \$(id -u):\$(id -g) \\
    -v \${HOME}:/home/\$(whoami):rw \\
    -v \${HOME}/.ssh:/home/vscode/.ssh:rw \\
    -v \${HOME}/.gitconfig:/home/vscode/.gitconfig:ro \\
    -v /srv:/srv:rw \\
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \\
    -v /srv/vsdocker/.vscode:/home/\$(whoami)/.vscode:rw \\
    -v /srv/vsdocker/.config/Code:/home/\$(whoami)/.config/Code:rw \\
    -v /var/run/docker.sock:/var/run/docker.sock:rw \\
    -v \$(which docker):/usr/bin/docker:ro \\
    -v \$(which docker-compose):/usr/bin/docker-compose:ro \\
    --network=host \\
    -e DISPLAY=unix\${DISPLAY} \\
    -e HOME=/home/\$(whoami) \\
    -w /home/\$(whoami) \\
    --group-add \$(stat -c '%g' /var/run/docker.sock) \\
    --group-add sudo \\
    crashzeus/vsdocker:stable launch > /dev/null\"

# - ALIAS TTY-dockcode -------
alias tty-dockcode=\"docker run -it --rm \\
    --user \$(id -u):\$(id -g) \\
    -v \${HOME}:/home/\$(whoami):rw \\
    -v \${HOME}/.ssh:/home/vscode/.ssh:rw \\
    -v \${HOME}/.gitconfig:/home/vscode/.gitconfig:ro \\
    -v /srv:/srv:rw \\
    -v /srv/vsdocker/.vscode:/home/\$(whoami)/.vscode:rw \\
    -v /srv/vsdocker/.config/Code:/home/\$(whoami)/.config/Code:rw \\
    -v /var/run/docker.sock:/var/run/docker.sock:rw \\
    -v \$(which docker):/usr/bin/docker:ro \\
    -v \$(which docker-compose):/usr/bin/docker-compose:ro \\
    --network=host \\
    -e HOME=/home/\$(whoami) \\
    -w /home/\$(whoami) \\
    --group-add \$(stat -c '%g' /var/run/docker.sock) \\
    --group-add sudo \\
    crashzeus/vsdocker:stable \"
" > $alias_file

# launcher file
desktop_file="/usr/share/applications/dockcode.desktop"
echo "- Create file : $desktop_file"
echo "[Desktop Entry]
Name=Docker-VSCode
Comment=Code Editing. Redefined. Dockerise.
GenericName=Text Editor
Exec=dockcode
Icon=com.visualstudio.code
Type=Application
StartupNotify=false
StartupWMClass=Code
Categories=Utility;TextEditor;Development;IDE;
MimeType=text/plain;inode/directory;application/x-code-workspace;
Actions=new-empty-window;
Keywords=dockcode;
X-Desktop-File-Install-Version=0.24

[Desktop Action new-empty-window]
Name=New Empty Window
Exec=dockcode
Icon=com.visualstudio.code
" > /tmp/dockcode.desktop
sudo mv /tmp/dockcode.desktop $desktop_file

# add to bashrc
bashrcFile="$HOME/.bashrc"
aliasSrc="source $alias_file"
if grep -q "$aliasSrc" "$bashrcFile"; then
  echo "- Alias already exist in .bashrc"
else
  printf "\n$aliasSrc\n\n" >> $bashrcFile
  echo "- Alias add to .bashrc"
fi

read -p "Need to reboot - reboot now ? Y/n " reboot_ok

if [ "$reboot_ok" == "Y" ] || [ "$reboot_ok" == "y" ] || [ "$reboot_ok" == "" ] || [ "$reboot_ok" == "yes" ] || [ "$reboot_ok" == "Yes" ] ; then
  sudo reboot
else
  echo "Installation finish"
  echo "Need to be reboot"
fi