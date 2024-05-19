#!/bin/bash

# Fonction pour écrire des messages dans stdout
log() {
  echo "$@"
}

# Fonction pour déplacer une fenêtre à un autre workspace
move_window_to_workspace() {
  local window=$1
  local workspace=$2
  hyprctl dispatch movetoworkspace "$workspace,address:$window" >/dev/null
  # if [ $? -eq 0 ]; then
  #   log "Fenêtre $window déplacée vers le workspace $workspace"
  # else
  #   log "Erreur lors du déplacement de la fenêtre $window vers le workspace $workspace"
  # fi
}

# Lire les règles de fenêtres à partir du fichier de configuration
CONFIG_FILE=~/.config/hypr/hyprland.conf

# Tableau associatif pour stocker les règles windowrule
declare -A window_rules

# Récupérer les règles windowrule du fichier de configuration
while IFS= read -r line; do
  if [[ $line =~ ^windowrule=workspace.* ]]; then
    rule=$(echo "$line" | cut -d'=' -f2 | xargs)
    workspace=$(echo "$rule" | grep -oP '(?<=workspace )[0-9]+')
    condition=$(echo "$rule" | grep -oP '\(.*\)')
    condition="${condition:1:${#condition}-2}"
    window_rules["$condition"]=$workspace
    # log "Règle lue : workspace $workspace, title: $condition"
  fi
done < "$CONFIG_FILE"

declare -A reversed_window_rules
for key in $(echo "${!window_rules[@]}" | tac); do
  reversed_window_rules["$key"]=${window_rules["$key"]}
done
window_rules=()
for key in $(echo "${!reversed_window_rules[@]}"); do
  window_rules["$key"]=${reversed_window_rules["$key"]}
done

# Déplacer chaque fenêtre vers le workspace attribué
for window in $(hyprctl clients -j | jq -r '.[] | .address'); do
  window_class=$(hyprctl clients -j | jq -r ".[] | select(.address == \"$window\") | .class")
  # log "Fenêtre trouvée : $window (class: $window_class)"
  for condition in "${!window_rules[@]}"; do
    workspace=${window_rules[$condition]}
    if [[ ${window_class,,} =~ ${condition,,} ]]; then
      log $window_class "->" $workspace
      move_window_to_workspace "$window" "$workspace"
      break
    fi
  done
done

hyprctl dispatch workspace 1 >/dev/null
