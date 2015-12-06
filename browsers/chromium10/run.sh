#!/bin/bash

#fluxbox -display $DISPLAY -log /tmp/fluxbox.log &
jwm -display $DISPLAY &

http_proxy="http://netcapsule_pywb_1:8080" wget "http://pywb.proxy/pywb-ca.pem"

mkdir -p $HOME/.pki/nssdb
certutil -d $HOME/.pki/nssdb -N
certutil -d sql:$HOME/.pki/nssdb -A -t "C,," -n "pywb" -i /home/browser/pywb-ca.pem 

mkdir ~/.config/
mkdir ~/.config/chromium
touch ~/.config/chromium/First\ Run

if [ -n "$NO_PROXY" ]; then
    run_browser /home/browser/chrome-linux/chrome "$URL"
else
    run_browser /home/browser/chrome-linux/chrome --proxy-server="netcapsule_pywb_1:8080"  "$URL"
fi

