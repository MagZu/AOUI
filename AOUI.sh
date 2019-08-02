#!/bin/bash
HEIGHT=15
WIDTH=60
CHOICE_HEIGHT=2
BACKTITLE="Anarchy Online Installer"
MENU="What engine?"

OPTIONS=(1 "Old Client"
         2 "New Engine")
         
CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
cd /home/$USER
case $CHOICE in

        1)
TITLE="Installation - Old Client"
MENU="Preinstall these Third Party tools:"
CHOICE_HEIGHT=4

dialog --checklist "Choose from following (spacebar to select)" 0 0 0 \
Clicksaver "Tool to look for missions" off \
ItemAssistant "Keep track of your items" off \
RKMap "Improved Rubi-Ka Planet Map" off \
SLMap "Improved ShadowLands Planet Map" off \
2> /var/tmp/optional.out
OPTIONAL=`cat /var/tmp/optional.out | \
    sed -e "s/\"//g" -e "s/ /|/g" -e "s/|$//"`
    echo 'optional :'$OPTIONAL
    
    
    if [[ $OPTIONAL == *"Clicksaver"* ]]; then
  		echo "Clicksaver Selected"
	fi
	if [[ $OPTIONAL == *"ItemAssistant"* ]]; then
  		echo "ItemAssistant Selected"
	fi
	if [[ $OPTIONAL == *"RKMap"* ]]; then
  		echo "Savic's RK map Selected"
	fi
	if [[ $OPTIONAL == *"SLMap"* ]]; then
  		echo "Bitnykk's SLmap Selected"
	fi
    
    
    
                ;;





        2)
TITLE="Installation - New Engine"
MENU="Which version?:"

OPTIONS=(1 "Wined3d - OpenGL"
         2 "d9vk - Vulkan")
         
CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
cd /home/$USER
case $CHOICE in

        1)
echo wined3d

dialog --checklist "Choose from following (spacebar to select)" 0 0 0 \
Clicksaver "Tool to look for missions" off \
RKMap "Improved Rubi-Ka Planet Map" off \
SLMap "Improved ShadowLands Planet Map" off \
TinyDump "damage dumper to see how much damage you do" off \
2> /var/tmp/optional.out
OPTIONAL=`cat /var/tmp/optional.out | \
    sed -e "s/\"//g" -e "s/ /|/g" -e "s/|$//"`
    echo 'optional :'$OPTIONAL


folder="$(zenity --file-selection --directory --title="Choose install directory")"
clear
echo 10 | dialog --title "Installing" --gauge "Creating wineprefix" 10 75 &

WINEPREFIX=$folder WINEARCH=win32 winetricks d3dcompiler_43 d3dx9 > /dev/null

cd $folder
clear
echo 20 | dialog --title "Installing" --gauge "Downloading files" 10 75 &

mkdir dl
cd dl
curl -O http://update.anarchy-online.com/download/AO/AnarchyOnline_EP2.exe > /dev/null

#ThirdParty
	if [[ $OPTIONAL == *"Clicksaver"* ]]; then
  		#echo "Clicksaver Selected" 
  		curl -O http://alt.magzu.net/dl/CS240.zip > /dev/null
  		mkdir ../drive_c/Clicksaver/
  		unzip CS240.zip -d ../drive_c/Clicksaver/
	fi
	if [[ $OPTIONAL == *"SLMap"* ]]; then
  		#echo "Bitnykk's SLmap Selected"
  		curl -O https://rubi-ka.net/bitnykk/SLmap-v2.1-normal.zip > /dev/null
	fi
	if [[ $OPTIONAL == *"RKMap"* ]]; then
  		#echo "Savic's RK map Selected"
  		curl -O http://singsrv.magzu.net/SaavicksMap.zip > /dev/null
	fi
clear
echo 30 | dialog --title "Installing" --gauge "Installing game. Please select defaults" 10 75 &

WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 wine AnarchyOnline_EP2.exe 
clear
echo 95 | dialog --title "Installing" --gauge "Installing addons" 10 75 &
	if [[ $OPTIONAL == *"SLMap"* ]]; then
  		unzip SLmap-v2.1-normal.zip -d ../drive_c/Funcom/Anarchy\ Online/cd_image/textures/PlanetMap/ > /dev/null
  		
	fi
	if [[ $OPTIONAL == *"RKMap"* ]]; then
  		rm ../drive_c/Funcom/Anarchy\ Online/cd_image/textures/PlanetMap/SaavicksMap/*
  		unzip SaavicksMap.zip -d ../drive_c/Funcom/Anarchy\ Online/cd_image/textures/PlanetMap/SaavicksMap/ > /dev/null
  		
	fi
clear
echo 100 | dialog --title "Installing" --gauge "Done" 10 75 &
sleep 3
clear 
echo installation is complete.          

            ;;
        2)
echo d9vk  

dialog --checklist "Choose from following (spacebar to select)" 0 0 0 \
Clicksaver 'Tool to look for missions' off \
ItemAssistant "Keep track of your items" off \
RKMap "Improved Rubi-Ka Planet Map" off \
SLMap "Improved ShadowLands Planet Map" off \
2> /var/tmp/optional.out
OPTIONAL=`cat /var/tmp/optional.out | \
    sed -e "s/\"//g" -e "s/ /|/g" -e "s/|$//"`
	



#New Engine - D9VK

folder="$(zenity --file-selection --directory --title="Choose install directory")"
clear
echo 10 | dialog --title "Installing" --gauge "Creating wineprefix" 10 75 &

WINEPREFIX=$folder WINEARCH=win32 winetricks d3dcompiler_43 d3dx9 d9vk_master > /dev/null

cd $folder
clear
echo 20 | dialog --title "Installing" --gauge "Downloading files" 10 75 &

mkdir dl
cd dl
curl -O http://update.anarchy-online.com/download/AO/AnarchyOnline_EP2.exe > /dev/null

#ThirdParty
	if [[ $OPTIONAL == *"Clicksaver"* ]]; then
  		#echo "Clicksaver Selected" 
  		curl -O http://alt.magzu.net/dl/CS240.zip > /dev/null
  		mkdir ../drive_c/Clicksaver/
  		unzip CS240.zip -d ../drive_c/Clicksaver/
	fi
	if [[ $OPTIONAL == *"SLMap"* ]]; then
  		#echo "Bitnykk's SLmap Selected"
  		curl -O https://rubi-ka.net/bitnykk/SLmap-v2.1-normal.zip > /dev/null
	fi
	if [[ $OPTIONAL == *"RKMap"* ]]; then
  		#echo "Savic's RK map Selected"
  		curl -O http://singsrv.magzu.net/SaavicksMap.zip > /dev/null
	fi
clear
echo 30 | dialog --title "Installing" --gauge "Installing game. Please select defaults" 10 75 &

WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 wine AnarchyOnline_EP2.exe 
clear
echo 95 | dialog --title "Installing" --gauge "Installing addons" 10 75 &
	if [[ $OPTIONAL == *"SLMap"* ]]; then
  		unzip SLmap-v2.1-normal.zip -d ../drive_c/Funcom/Anarchy\ Online/cd_image/textures/PlanetMap/ > /dev/null
  		
	fi
	if [[ $OPTIONAL == *"RKMap"* ]]; then
  		rm ../drive_c/Funcom/Anarchy\ Online/cd_image/textures/PlanetMap/SaavicksMap/*
  		unzip SaavicksMap.zip -d ../drive_c/Funcom/Anarchy\ Online/cd_image/textures/PlanetMap/SaavicksMap/ > /dev/null
  		
	fi
clear
echo 100 | dialog --title "Installing" --gauge "Done" 10 75 &
sleep 3
clear 
echo installation is complete.          

esac
esac
