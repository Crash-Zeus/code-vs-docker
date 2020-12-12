# code-vs-docker
[![](https://img.shields.io/docker/cloud/build/crashzeus/vsdocker?style=for-the-badge)](https://hub.docker.com/r/crashzeus/vsdocker/builds)
[![](https://img.shields.io/docker/image-size/crashzeus/vsdocker/stable?style=for-the-badge)](https://hub.docker.com/r/crashzeus/vsdocker)
[![](https://img.shields.io/docker/stars/crashzeus/vsdocker?style=for-the-badge)](https://hub.docker.com/r/crashzeus/vsdocker)
[![](https://img.shields.io/github/license/Crash-Zeus/code-vs-docker?style=for-the-badge)](https://github.com/Crash-Zeus/code-vs-docker/blob/master/LICENSE)
[![](https://img.shields.io/github/stars/Crash-Zeus/code-vs-docker?style=for-the-badge)](https://github.com/Crash-Zeus/code-vs-docker/)
[![](https://img.shields.io/github/last-commit/Crash-Zeus/code-vs-docker?style=for-the-badge)](https://github.com/Crash-Zeus/code-vs-docker/)

Your favorite IDE as you've never seen it before
(click on gif to view the video on youtube)

[![Alt text](./.gitimage/vsdocker.gif)](https://youtu.be/2nPHDu8KU9c)
## Prerequisite
- [Docker-ce](https://docs.docker.com/get-docker/)
- [Docker-compose](https://docs.docker.com/compose/install/)
- Xorg server (X11)

---
## Parameters

You can parameters you're vscode settings
- Put extension wee need in requirement.txt, if you have vs code local, you can use `cd .config && rm requirement.txt && code --list-extensions > requirement.txt` to freeze you're local extention
- Put you're settings into settings.json

A test sample is already present in the config folder

---
## Installation

```bash
# alias installation and .desktop application
./install.sh

# install extension that specified in config/requirement.txt
tty-dockcode install

# Run container without x11 binding (juste tty)
tty-dockcode bash

# Run container with x11 binding (open vscode window)
dockcode
```

---

## Usage

On cli use dockcode (same as code on host) or tty-dockcode [command] (use bash ton enter in container)

You can use this two commands too :

Run container on window mode (like dockcode alias)
```bash
docker run --rm -d \
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
  --group-add sudo \
  crashzeus/vsdocker:stable launch > /dev/null
```

Run container on window mode (like tty-dockcode alias)
```bash
docker run -it --rm \
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
  --group-add sudo \
  crashzeus/vsdocker:stable
```

---

