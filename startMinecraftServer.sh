#!/bin/sh

# FUCK THIS SCRIPT I'M GONNA GO LEARN PYTHON

# automated minecraft server start script
# made with love by nia <3
# https://github.com/KineticAeon/NSAS

# set server version here
VERSION="spigot-1.20.1"

mv -t ./otherVersions $(find *.jar | sed 's/[^ ]*spigot-1.20.1[^ ]*//ig') 

if [ -f ./otherVersions/$VERSION.jar ]; then
    mv ./otherVersions/$VERSION.jar ./$VERSION.jar

echo "bruh this script is fucking gay why did you make it."
echo "because I am gay. duh."
java -Xms1G -Xmx1G -XX:+UseG1GC -jar $VERSION.jar nogui
