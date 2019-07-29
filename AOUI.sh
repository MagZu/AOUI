#!/bin/bash





#D9VK install part

folder="$(zenity --file-selection --directory --title="Choose install directory")"

WINEPREFIX=$folder WINEARCH=win32 winetricks d3dcompiler_43 d3dx9 d9vk_master

cd $folder



mkdir dl
cd dl
wget http://update.anarchy-online.com/download/AO/AnarchyOnline_EP2.exe

#ThirdParty
wget https://datapacket.dl.sourceforge.net/project/aoiaplus/AO%20Item%20Assistant%2B%202019%20Edition%20v1.3.0.4.exe
wget https://rubi-ka.net/bitnykk/SLmap-v2.1-normal.zip
wget http://alt.magzu.net/dl/SaavicksMap.zip

WINEPREFIX=$folder WINEARCH=win32 wine AnarchyOnline_EP2.exe

