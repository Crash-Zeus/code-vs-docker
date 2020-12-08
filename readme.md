# Vscode containeriser

Docker image size : 844 MB with new font

## Usage

Lacement du compose
Le tout premier démarrage est accompagner de l'installation des extensions, la vitesse dépend de votre connexion mais tout ce fait en arrière plan (voir logs)
```bash
    docker-compose up -d
```

Vérification log
```bash
    docker logs --follow vsdocker
```

Ouverture d'une instance vscode
Le wordir de test est /app
```bash
    docker exec -it vscode code [workdir]
```

Tips:
setup un WORKDIR dans l'image permet d'ajouter un bookmark accès rapide dans le gestionnaire de fichier interne dispo dans le menu vscode => file => open [folder/file/workspace]