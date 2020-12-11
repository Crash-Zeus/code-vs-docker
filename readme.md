# code-vs-docker

VsCode containerisé intégrant
- outillage bash
- modules recommandés

## Reste à faire
- Problème mapping user 1000 / non 1000
- Remap le $HOME/.ssh host sur le $HOME/.ssh de l'user du container

## Installation
```bash
# Installation des alias (rajouter le basic-auth)
curl -k https://gitlab.mios.maxicoffee.domains/jonas/vsdocker/-/blob/master/install.sh
chmod +x install.sh && ./install.sh && rm install.sh

# Redémarrer
reboot

# installation des modules recommandés
tty-mccode install
```

## Utilisation
Une icone doit apparaitre via le launcher ubuntu, cherche "mccode" ou "Maxi VSCode".  
Il est également possible de lancer "Maxi VSCode" via la commande "mccode"