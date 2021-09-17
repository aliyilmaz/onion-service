#!/bin/bash

SRC="src/"
TOR_VERSION=10.5.6

echo "

  ___  _   _ ___ ___  _   _      ____  _____ ______     _____ ____ _____ 
 / _ \| \ | |_ _/ _ \| \ | |    / ___|| ____|  _ \ \   / /_ _/ ___| ____|
| | | |  \| || | | | |  \| |____\___ \|  _| | |_) \ \ / / | | |   |  _|  
| |_| | |\  || | |_| | |\  |_____|__) | |___|  _ < \ V /  | | |___| |___ 
 \___/|_| \_|___\___/|_| \_|    |____/|_____|_| \_\ \_/  |___\____|_____|
                                                                         
TOR VERSION: $TOR_VERSION

"


read -p "Server IP (eg. 127.0.0.1): " SERVER_IP
read -p "Server PORT (eg. 80): " SERVER_PORT
read -p "Choose language:

1) English (en-US)
2) عربية (ar)
3) Català (ca)
4) Čeština (cs)
5) Dansk (da)
6) Deutsch (de)
7) ελληνικά (el)
8) Español (es-ES)
9) Español Arg. (es-AR)
10) فارسی (fa)
11) Français (fr)
12) Gaeilge (ga-IE)
13) עברית (he)
14) Magyar (hu)	
15) Indonesia (id)
16) Islenska (is)
17) Italiano (it)
18) 日本語 (ja)
19) ქართული ენა (ka)
20) 한국어 (ko)
21) Lietuvių (lt)
22) македонски (mk)
23) Melayu (ms)
24) မြန်မာစာ (my)
25) Norsk Bokmål (nb-NO)
26) Nederlands (nl)
27) Polszczyzna (pl)
28) Português Brasil(pt-BR)
29) Română (ro)
30) Русский (ru)
31) Svenska (sv-SE)
32) ภาษาไทย (th)
33) Türkçe (tr)
34) Tiếng Việt (vi)
35) 简体中文 (zh-CN)
36) 正體字 (zh-TW)

" response

if [ ! 1 -lt 36 ]
   then
    echo  "The installation has been cancelled."
    exit
fi

[ $response -eq 1 ] && LANG="en-US"
[ $response -eq 2 ] && LANG="ar"
[ $response -eq 3 ] && LANG="ca"
[ $response -eq 4 ] && LANG="cs"
[ $response -eq 5 ] && LANG="da"
[ $response -eq 6 ] && LANG="de"
[ $response -eq 7 ] && LANG="el"
[ $response -eq 8 ] && LANG="es-ES"
[ $response -eq 9 ] && LANG="es-AR"
[ $response -eq 10 ] && LANG="fa"
[ $response -eq 11 ] && LANG="fr"
[ $response -eq 12 ] && LANG="ga-IE"
[ $response -eq 13 ] && LANG="he"
[ $response -eq 14 ] && LANG="hu"
[ $response -eq 15 ] && LANG="id"
[ $response -eq 16 ] && LANG="is"
[ $response -eq 17 ] && LANG="it"
[ $response -eq 18 ] && LANG="ja"
[ $response -eq 19 ] && LANG="ka"
[ $response -eq 20 ] && LANG="ko"
[ $response -eq 21 ] && LANG="lt"
[ $response -eq 22 ] && LANG="mk"
[ $response -eq 23 ] && LANG="ms"
[ $response -eq 24 ] && LANG="my"
[ $response -eq 25 ] && LANG="nb-NO"
[ $response -eq 26 ] && LANG="nl"
[ $response -eq 27 ] && LANG="pl"
[ $response -eq 28 ] && LANG="pt-BR"
[ $response -eq 29 ] && LANG="ro"
[ $response -eq 30 ] && LANG="ru"
[ $response -eq 31 ] && LANG="sv-SE"
[ $response -eq 32 ] && LANG="th"
[ $response -eq 33 ] && LANG="tr"
[ $response -eq 34 ] && LANG="vi"
[ $response -eq 35 ] && LANG="zh-CN"
[ $response -eq 36 ] && LANG="zh-TW"

[ ! -d "$SRC" ] && mkdir "$SRC"

FILE="$SRC"tor-browser-linux64-"$TOR_VERSION"_"$LANG".tar.xz
[ ! -f "$FILE" ] && wget -O "$SRC"tor-browser-linux64-"$TOR_VERSION"_"$LANG".tar.xz https://dist.torproject.org/torbrowser/"$TOR_VERSION"/tor-browser-linux64-"$TOR_VERSION"_"$LANG".tar.xz 

[ ! -f "$FILE" ] && sudo chmod -R 0644 "$SRC"tor-browser-linux64-"$TOR_VERSION"_"$LANG".tar.xz

FOLDER=tor-browser_"$LANG"
[ ! -d "$FOLDER" ] && tar xf "$SRC"tor-browser-linux64-"$TOR_VERSION"_"$LANG".tar.xz

TOR_FOLDER="$(pwd)"/tor-browser_"$LANG"/Browser/TorBrowser/Data/Tor/
ONION_FOLDER="$TOR_FOLDER"HiddenServiceDir/
[ ! -d "$ONION_FOLDER" ] && mkdir "$ONION_FOLDER"

[ -d "$ONION_FOLDER" ] && chmod -R 0700 "$ONION_FOLDER"

TORRC_FILE="$TOR_FOLDER"torrc
TOTAL_LINE=`wc "$TORRC_FILE" | awk '{print $1}'`


if [ $TOTAL_LINE -eq 0 ]
  then
    TORRC_LINE1="# This file was generated by Tor; if you edit it, comments will not be preserved"
    echo $TORRC_LINE1 >> $TORRC_FILE 

    TORRC_LINE2="# The old torrc file was renamed to torrc.orig.1, and Tor will ignore it"
    echo $TORRC_LINE2 >> $TORRC_FILE 

    TORRC_LINE3=""
    echo $TORRC_LINE3 >> $TORRC_FILE 
    
    TORRC_LINE4="ClientOnionAuthDir "$TOR_FOLDER"onion-auth"
    echo $TORRC_LINE4 >> $TORRC_FILE 

    TORRC_LINE5="DataDirectory $TOR_FOLDER"
    echo $TORRC_LINE5 >> $TORRC_FILE 

    TORRC_LINE6="GeoIPFile "$TOR_FOLDER"geoip"
    echo $TORRC_LINE6 >> $TORRC_FILE 

    TORRC_LINE7="GeoIPv6File "$TOR_FOLDER"geoip6"
    echo $TORRC_LINE7 >> $TORRC_FILE 


fi

TOTAL_LINE=`wc "$TORRC_FILE" | awk '{print $1}'`

if [ $TOTAL_LINE -eq 7 ]
  then
    HiddenServiceDirContent="HiddenServiceDir $ONION_FOLDER"
    echo $HiddenServiceDirContent >> $TORRC_FILE 
fi

TOTAL_LINE=`wc "$TORRC_FILE" | awk '{print $1}'`

if [ $TOTAL_LINE -eq 8 ]
  then
    HiddenServicePortContent="HiddenServicePort "$SERVER_PORT" "$SERVER_IP":"$SERVER_PORT""
    echo $HiddenServicePortContent >> $TORRC_FILE
fi
 
sh -c 'timeout 3s "./tor-browser_$LANG/Browser/start-tor-browser"' 

TOTAL_LINE=`wc "$TORRC_FILE" | awk '{print $1}'`

if [ -f "$ONION_FOLDER"hostname ]
then
echo "          

Your onion address: `cat "$ONION_FOLDER"hostname`
Server IP: $SERVER_IP
Server PORT: $SERVER_PORT
"
echo "Installation is complete."
else
echo "The installation has been cancelled."
fi