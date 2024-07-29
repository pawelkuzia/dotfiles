#!/usr/bin/env bash
# Wallpapers folder path
wpdir="/home/pawelkuzia/.wallpapers"
# List of wallpapers, self generating
wplist="/home/pawelkuzia/.config/waybar/wallpaperlist"
# File containing last set wallpeper, self generating
wplastwall="/home/pawelkuzia/.config/waybar/lastwallpaper"

# Creating wallpaper matrix
declare -a wps
# Saving wallpapers' paths to matrix
while IFS= read -r -d $'\0' file; do
	wps+=("$file")
done < <(find "$wpdir" -type f -print0)

if [ -e "$wplastwall" ]; then
	echo "File $wplastwall found."
else
	echo "File $wplastwall not foiund. Creating."
	echo -e "\n1" > "$wplastwall"
fi
	

# Variables

wplast=$(sed -n '1p;' $wplastwall )
wplastnum=$(sed -n '2p;' $wplastwall )


if [ -e "$wplist" ]; then
    echo "File $wplist found."
else
    echo "File $wplist not found. Creating."
    touch "$wplist"
	find  "$wpdir" -name "*.*" -type f > "$wplist"
fi


# Listing all found matrix
echo "All wallpapers in $wpdir:"
for path in "${wps[@]}"; do
	echo "$path"
done	
echo " "
if [ $(ls -1 $wpdir | wc -l) !=  $(wc -l < $wplist ) ]
then
	echo "Number of wallpapers in $wpdir:"
	ls -1 $wpdir | wc -l
	echo "Amount read from $wplist"
	wc -l $wplist
	echo " "
	echo "Recounting"
	find  "$wpdir" -name "*.*" -type f > "$wplist"
	echo " "
	echo "Corrent read from $wplist:"
	wc -l < $wplist
	echo "Writing to variable"
	echo " "
	wpcount=$(wc -l < ~/.config/waybar/wallpaperlist) 
	echo "Current read:"
	echo $wpcount
	wplastnum=1
	wplast=${$wps[$wplastnum -1 ]}
	
else
	echo "Correct wallpapers amount in $wplist"
	wpcount=$(wc -l < ~/.config/waybar/wallpaperlist) 
	echo "Current read:"
	echo $wpcount

	echo "Last used wallpaper:"
	echo $wplast 
	echo " "
	echo "With this nuber"
	echo $wplastnum
	echo " "
	echo "Current matrix state:"
	echo ${wps[$wplastnum - 1]}
	echo " "
	if [ $wplastnum -lt $wpcount ]
		then
			wplastnum=$((wplastnum+1))
		else
			wplastnum=1
	fi
	echo "Next wallpaper number:"
	echo $wplastnum

fi	

	echo " "
	wplast=${wps[$wplastnum - 1]}
	echo "Saving new wallpaper to variable:"
	echo $wplast
	echo " "
	echo "File update $wplastwall"
	escaped_wplast=$(sed 's/[\/&]/\\&/g' <<< "$wplast")
	#~ sed -i '1s/.*/'"$wplast"'/' '/home/pawelkuzia/.config/waybar/lastwallpaper'
	sed -i '1s/.*/'"$escaped_wplast"'/' $wplastwall
	sed -i '2s/.*/'"$wplastnum"'/' $wplastwall
	cat $wplastwall
	echo " "
	# if pgrep -x "swaybg" > /dev/null
	# 	then
	# 		# Jeśli tak, zatrzymaj proces
	# 		killall swaybg
	# 		echo "Swaybg stopped. Restaring."
	# 	else
	# 		echo "Swaybg not running. Starting up"
	# 	fi
	# nohup swaybg --image $wplast -m fill &
	nohup swww img $wplast --transition-type grow --transition-pos 0.978,0.985 --transition-duration 1 --transition-fps 60
	notify-send -i $wplast "New wallpaper set" "$wplast" --app-name "Wallpaper"
	#~ ln -s "$wplast" "/home/pawelkuzia/.config/rofi/wallpaper" && 
	#~ convert "$wplast" -resize x700 -filter Lanczos -quality 90 "/home/pawelkuzia/.config/rofi/wallpapers.png"
exit 0
