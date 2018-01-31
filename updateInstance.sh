#!/bin/bash

# Set this value to the amount of seconds it takes to download a modpack for you.
maxDiff=150

if [ $# -eq 0 ] || [ $1 == "-h" ] || [ $1 == "--help" ]; then # CLI help message
    script=`basename "$0"`
    echo "Usage: ./$script <old instance folder> <new instance folder>"
    exit 1
fi

# Copies basic files
cp "$1/minecraft/options.txt" "$2/minecraft/"
cp "$1/minecraft/optionsof.txt" "$2/minecraft/" 2>/dev/null # May not be on user's system so errors discarded
cp "$1/minecraft/servers.dat" "$2/minecraft/"
cp -r "$1/minecraft/config/" "$2/minecraft/tempconfig"
rsync -a $2/minecraft/config/* "$2/minecraft/tempconfig/"
mv "$2/minecraft/config/" "$2/minecraft/configold"
mv "$2/minecraft/tempconfig/" "$2/minecraft/config"
cp -r "$1/minecraft/screenshots/" "$2/minecraft/"
cp -r "$1/minecraft/saves/" "$2/minecraft/"
cp -r "$1/minecraft/resourcepacks/" "$2/minecraft/"
cp -r "$1/minecraft/shaderpacks/" "$2/minecraft/" 2>/dev/null
cp -r "$1/minecraft/journeymap/" "$2/minecraft/" 2>/dev/null

currentTime=$(date +%s)
timeArray=()
declare -A modArray
arrayAmt=0
for i in "$1"/minecraft/mods/*.jar; do # Adds all mods and the unix timestamp to an associative table
    modArray["$i"]=$(date -r "$i" +%s)
    let "arrayAmt++"
done

# From Gilles on StackExchange unix.stackexchange.com/q/187488/
# Sets associative table into mod:timestamp format
IFS=$'\n'; set -f
sortedArray=($(
    for key in "${!modArray[@]}"; do
      printf '%s:%s\n' "$key" "${modArray[$key]}"
    done | sort -t : -k 2n))
unset IFS; set +f

quickIndex=0 # Very lazy table counter
for i in ${!sortedArray[@]}; do
    let "quickIndex++"
    if [[ "$quickIndex" == "$((${#sortedArray[@]}/2))" ]]; then # Finds the median mod
        median=${sortedArray["$i"]: -10} # Gets just date portion
    fi
done

for i in ${!sortedArray[@]}; do
    timeDiff="$((${sortedArray[$i]: -10}-$median))" # Sets variable to the difference of the median mod timestamp and the iterating mod timestamp
    if [[ "${timeDiff#-}" -gt "$maxDiff" ]]; then # Detects if mod installation is 150 seconds before/after median mod installation time
        cp "${sortedArray["$i"]:0: -11}" "$2/minecraft/mods/"
    fi
done