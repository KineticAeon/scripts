#!/bin/sh

# FUCK THIS SCRIPT I'M GONNA GO LEARN PYTHON
# (after realizing python and rust were both too big for this, she gave up)

# automated minecraft server start script
# needs wget and jq
# made with love by nia <3, 2023
# https://github.com/KineticAeon/NAS

# set server version and ram (in gb) here
VERSION="spigot-1.20.1"
RAM="1"

mv -t ./otherVersions $(find *.jar | sed "s/[^ ]*$VERSION[^ ]*//ig") 

if [ -f ./otherVersions/${VERSION}.jar ]; then
    mv ./otherVersions/${VERSION}.jar ./${VERSION}.jar
fi

echo "bruh this script is fucking gay why did you make it."
echo "because I am gay. duh."
java -Xms1G -Xmx${RAM}G -XX:+UseG1GC -jar ${VERSION}.jar nogui

