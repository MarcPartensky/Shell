#!/bin/bash

# Répertoire contenant vos projets git
GIT_DIR=~/git

# Lister les dossiers dans le répertoire des projets git
projects=$(find "$GIT_DIR" -maxdepth 1 -mindepth 1 -type d -exec basename {} \;)

# Si aucun projet n'est trouvé, sortir avec un message d'erreur
if [ -z "$projects" ]; then
  echo "Aucun projet trouvé dans $GIT_DIR"
  exit 1
fi

# Utiliser rofi pour sélectionner un projet
selected_project=$(echo "$projects" | rofi -dmenu -p "Sélectionnez un projet git")

# Si aucun projet n'est sélectionné, sortir
if [ -z "$selected_project" ]; then
  exit 1
fi

# Ouvrir une nouvelle fenêtre alacritty avec le répertoire sélectionné en tant que workdir
alacritty --working-directory "$GIT_DIR/$selected_project"

