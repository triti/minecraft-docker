#!/bin/sh

if [ ! -e /minecraft/eula.txt ]; then
    echo 'eula=true' >> eula.txt
fi

exec java $JVM_OPTS -jar minecraft.jar nogui
