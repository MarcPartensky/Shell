#!/bin/bash

# Fichier de log
LOGFILE=~/hyprland_window_mover.log

# Fonction pour écrire des messages dans le fichier de log
log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# Fonction pour déplacer une fenêtre à un autre workspace
move_window_to_workspace() {
  local window=$1
  local workspace=$2
  hyprctl dispatch movetoworkspace "$workspace,address:$window"
  if [ $? -eq 0 ]; then
    log "Fenêtre $window déplacée vers le workspace $workspace"
  else
    log "Erreur lors du déplacement de la fenêtre $window vers le workspace $workspace"
  fi
}

# Démarrer le log
log "Script de déplacement des fenêtres démarré"

# Obtenir la liste des fenêtres dans le workspace 1
windows=$(hyprctl clients -j | jq -r '.[] | select(.workspace.id == 1) | .address')

# Vérifier s'il y a des fenêtres dans le workspace 1
if [ -z "$windows" ]; then
  log "Aucune fenêtre trouvée dans le workspace 1"
  echo "Aucune fenêtre trouvée dans le workspace 1"
  exit 1
fi

# Loguer les fenêtres trouvées
log "Fenêtres trouvées dans le workspace 1 : $windows"

# Déplacer chaque fenêtre du workspace 1 au workspace 2
for window in $windows; do
  move_window_to_workspace "$window" 2
done

# Fin du log
log "Toutes les fenêtres du workspace 1 ont été déplacées au workspace 2"
echo "Toutes les fenêtres du workspace 1 ont été déplacées au workspace 2"

