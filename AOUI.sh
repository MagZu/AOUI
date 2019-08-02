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
ItemAssistant "Keep track of your items" off \
RKMap "Improved Rubi-Ka Planet Map" off \
SLMap "Improved ShadowLands Planet Map" off \
2> /var/tmp/optional.out
OPTIONAL=`cat /var/tmp/optional.out | \
    sed -e "s/\"//g" -e "s/ /|/g" -e "s/|$//"`
    echo 'optional :'$OPTIONAL


folder="$(zenity --file-selection --directory --title="Choose install directory")"

WINEPREFIX=$folder WINEARCH=win32 winetricks d3dcompiler_43 d3dx9

cd $folder



mkdir dl
cd dl
wget http://update.anarchy-online.com/download/AO/AnarchyOnline_EP2.exe

#ThirdParty
	if [[ $OPTIONAL == *"Clicksaver"* ]]; then
  		echo "Clicksaver Selected"
	fi
	if [[ $OPTIONAL == *"SLMap"* ]]; then
  		echo "Bitnykk's SLmap Selected"
  		wget https://rubi-ka.net/bitnykk/SLmap-v2.1-normal.zip
	fi
	if [[ $OPTIONAL == *"RKMap"* ]]; then
  		echo "Savic's RK map Selected"
  		wget http://alt.magzu.net/dl/SaavicksMap.zip
	fi
	if [[ $OPTIONAL == *"ItemAssistant"* ]]; then
  		echo "WIP - ItemAssistant Selected"
      wget https://datapacket.dl.sourceforge.net/project/aoiaplus/AO%20Item%20Assistant%2B%202019%20Edition%20v1.3.0.4.exe
	fi

WINEPREFIX=$folder WINEARCH=win32 wine AnarchyOnline_EP2.exe

echo installation is complete.

            ;;
        2)
echo d9vk  

dialog --checklist "Choose from following (spacebar to select)" 0 0 0 \
Clicksaver "Tool to look for missions" off \
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

WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 winetricks d3dcompiler_43 d3dx9 d9vk_master 

cd $folder
clear
echo 20 | dialog --title "Installing" --gauge "Downloading files" 10 75 &

mkdir dl
cd dl
wget http://update.anarchy-online.com/download/AO/AnarchyOnline_EP2.exe -q

#ThirdParty
	if [[ $OPTIONAL == *"Clicksaver"* ]]; then
  		echo "Clicksaver Selected" > /dev/null
  		
	fi
	if [[ $OPTIONAL == *"SLMap"* ]]; then
  		#echo "Bitnykk's SLmap Selected"
  		wget https://rubi-ka.net/bitnykk/SLmap-v2.1-normal.zip -q
	fi
	if [[ $OPTIONAL == *"RKMap"* ]]; then
  		#echo "Savic's RK map Selected"
  		wget http://alt.magzu.net/dl/SaavicksMap.zip -q
	fi
	if [[ $OPTIONAL == *"ItemAssistant"* ]]; then
  		#echo "WIP - ItemAssistant Selected"
  		wget https://datapacket.dl.sourceforge.net/project/aoiaplus/AO%20Item%20Assistant%2B%202019%20Edition%20v1.3.0.4.exe -q
	fi
clear
echo 30 | dialog --title "Installing" --gauge "Installing game. Please select defaults" 10 75 &

WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 wine AnarchyOnline_EP2.exe 
clear
echo 100 | dialog --title "Installing" --gauge "Done" 10 75 &
sleep 3
clear 
echo installation is complete.          

esac
esac
