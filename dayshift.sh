# convert $1 -colorspace gray -format "%[fx:100*mean]%%" info:

#!/bin/bash


threshold=20
wallpapers_path=~/wallpapers

beginning="08:00"
end="21:59"

day_folder="day"
night_folder="night"
active_folder="active"

# Fonction pour évaluer si l'image est claire ou sombre
is_dark() {
    # Chemin de l'image
    image_path="$1"

    # Obtenir le pourcentage de luminosité de l'image
    luminance_percentage_float=$(convert "$image_path" -colorspace gray -format "%[fx:100*mean]%%" info:)
    luminance_percentage=$(echo $luminance_percentage_float | cut -d. -f1)
    # echo luminance_percentage: $luminance_percentage

    # Comparer le pourcentage avec 50
    if (( $(echo "$luminance_percentage > $threshold" | bc -l) )); then
        # echo 1
        return 1
    else
        # echo 0
        return 0
    fi
}

is_day() {
   currenttime=$(date +%H:%M)
   if [[ "$currenttime" > $end ]] || [[ "$currenttime" < $beginning ]]; then
     return 0
   else
     return 1
   fi
}

# Appel de la fonction avec le chemin de l'image
# evaluate_brightness $1

sortwpp() {
    for wallpaper in $wallpapers_path/*; do
        # if folder continue loop
        if [ -d $wallpaper ]; then
            continue
        fi
        if is_dark $wallpaper; then
            cp $wallpaper $wallpapers_path/$night_folder
        else
            cp $wallpaper $wallpapers_path/$day_folder
        fi
    done
}

# clean() {
#     for wallpaper in $wallpapers_path/$active_folder/*; do
#         # if folder continue loop
#         if [ -d $wallpaper ]; then continue; fi
#         if [ -f $wallpaper ]; then rm $wallpaper; fi
#     done
# }

symlink() {
    rm $wallpapers_path/$active_folder
    echo ln -sf $wallpapers_path/$time $wallpapers_path/$active_folder
    ln -sf $wallpapers_path/$time $wallpapers_path/$active_folder
    # time=$1
    # for wallpaper in $wallpapers_path$time/*; do
    #     echo cp $wallpaper  $wallpapers_path/$active_folder
    #     if [ -d $wallpaper ]; then continue; fi
    #     cp $wallpaper $wallpapers_path/$active_folder
    # done
}

if [ $# -eq 0 ]; then
    time=`is_day; [ $? -eq 1 ] && echo $day_folder || echo $night_folder`
else
    time=$1
fi

echo Moving wallpapers for $time time
echo - sort
sortwpp
# echo - clean
# clean
echo - symlink
symlink
echo done
notify-send "Moved wallpapers for $time time"
