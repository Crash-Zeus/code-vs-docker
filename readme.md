# code-vs-docker

## Installation
```bash
# Installation des alias (rajouter le basic-auth)
./install.sh

# Redémarrer
reboot

# installation des modules recommandés
tty-dockcode install
```

## Usage
On cli use dockcode (same as code on host) or tty-dockcode [command] (use bash ton enter in container)


alias dockcode="docker run --rm -d \
  --user $(id -u):$(id -g) \
  -v ${HOME}:/home/$(whoami):rw \
  -v ${HOME}/.ssh:/home/vscode/.ssh:rw \
  -v ${HOME}/.gitconfig:/home/vscode/.gitconfig:ro \
  -v /srv:/srv:rw \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  -v /srv/vsdocker/.vscode:/home/$(whoami)/.vscode:rw \
  -v /srv/vsdocker/.config/Code:/home/$(whoami)/.config/Code:rw \
  -v /var/run/docker.sock:/var/run/docker.sock:rw \
  -v $(which docker):/usr/bin/docker:ro \
  -v $(which docker-compose):/usr/bin/docker-compose:ro \
  --network=host \
  -e DISPLAY=unix${DISPLAY} \
  -e HOME=/home/$(whoami) \
  -e USER=$(whoami) \
  -w /home/$(whoami) \
  --group-add $(stat -c '%g' /var/run/docker.sock) \
  crashzeus/vsdocker:latest launch > /dev/null"

alias tty-dockcode="docker run -it --rm \
  --user $(id -u):$(id -g) \
  -v ${HOME}:/home/$(whoami):rw \
  -v ${HOME}/.ssh:/home/vscode/.ssh:rw \
  -v ${HOME}/.gitconfig:/home/vscode/.gitconfig:ro \
  -v /srv:/srv:rw \
  -v /srv/vsdocker/.vscode:/home/$(whoami)/.vscode:rw \
  -v /srv/vsdocker/.config/Code:/home/$(whoami)/.config/Code:rw \
  -v /var/run/docker.sock:/var/run/docker.sock:rw \
  -v $(which docker):/usr/bin/docker:ro \
  -v $(which docker-compose):/usr/bin/docker-compose:ro \
  --network=host \
  -e HOME=/home/$(whoami) \
  -e USER=$(whoami) \
  -w /home/$(whoami) \
  --group-add $(stat -c '%g' /var/run/docker.sock) \
  crashzeus/vsdocker:latest "
