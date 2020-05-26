#! /bin/bash

# Set d-bus machine-id
if [ ! -s /etc/machine-id ]; then
  dbus-uuidgen > /etc/machine-id
fi
# Properly start DBus
export DISPLAY=:0 # workaround dbus asks for DISPLAY to be set
#export GTK_DEBUG=all
#export GDK_DEBUG=all  
echo "eclipse:x:$(id -u):0:root:/root:/bin/bash" >> /etc/passwd
mkdir -p /var/run/dbus
dbus-daemon --system --fork &
#export G_MESSAGES_DEBUG=all
export DBUS_SESSION_BUS_ADDRESS=$(dbus-daemon --session --fork --print-address)

broadwayd $BROADWAY_DISPLAY -p $BROADWAY_PORT
