# code-vs-docker

## Reste à faire
- Problème mapping user 1000 / non 1000
- Remap le $HOME/.ssh host sur le $HOME/.ssh de l'user du container

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