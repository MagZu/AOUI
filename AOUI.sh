#!/bin/bash
DIRECTORY=`pwd`
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
MishBuddy "Alternative to ClickSaver" off \
RKMap "Improved Rubi-Ka Planet Map" off \
SLMap "Improved ShadowLands Planet Map" off \
TinyDump "WIP - damage dumper to see how much damage you do" off \
2> /var/tmp/optional.out
if [ "$?" != "0" ]
then
	clear
	echo "cancel pressed. Exiting script."
	exit
fi

OPTIONAL=`cat /var/tmp/optional.out | \
    sed -e "s/\"//g" -e "s/ /|/g" -e "s/|$//"`
    echo 'optional :'$OPTIONAL


folder="$(zenity --file-selection --directory --title="Choose install directory")"
clear
echo 10 | dialog --title "Installing" --gauge "Creating wineprefix" 10 75 &

WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 winetricks winxp > /dev/null
cd $folder
clear
echo 20 | dialog --title "Installing" --gauge "Downloading files" 10 75 &

mkdir dl
cd dl
curl -O http://update.anarchy-online.com/download/AO/AnarchyOnline_EP1.exe 2> /dev/null
    
    
#ThirdParty
	if [[ $OPTIONAL == *"Clicksaver"* ]]; then
  		#echo "Clicksaver Selected" 
  		clear
		echo 21 | dialog --title "Installing" --gauge "Downloading Clicksaver." 10 75 &
  		curl -O http://singsrv.magzu.net/CS240.zip 2> /dev/null
  		clear
		echo 22 | dialog --title "Installing" --gauge "Installing Clicksaver." 10 75 &
  		mkdir ../drive_c/Clicksaver/
  		unzip CS240.zip -d ../drive_c/Clicksaver/ 2> /dev/null
  		
  		#Shortcut
  		echo "#!/bin/bash" > $DIRECTORY/StartClicksaver.sh
  		echo "cd $folder/drive_c/Clicksaver/" >> $DIRECTORY/StartClicksaver.sh
		echo "WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 wine ClickSaver.exe" >> $DIRECTORY/StartClicksaver.sh
		chmod +x $DIRECTORY/StartClicksaver.sh
	fi
	if [[ $OPTIONAL == *"MishBuddy"* ]]; then
  		#echo "MishBuddy Selected"
  		clear
		echo 23 | dialog --title "Installing" --gauge "Downloading MishBuddy." 10 75 &
  		curl -O curl -O https://www.mmotoolbox.com/download/mbsetup.exe 2> /dev/null
  		clear
		echo 24 | dialog --title "Installing" --gauge "Installing MishBuddy. Please Select Defaults" 10 75 &
		WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 wine mbsetup.exe
		
		#Shortcut
		echo "#!/bin/bash" > $DIRECTORY/StartMishBuddy.sh
  		echo "cd $folder/drive_c/Program\ Files/MMOToolbox/MishBuddy/" >> $DIRECTORY/StartMishBuddy.sh
		echo "WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 wine MishBuddy.exe" >> $DIRECTORY/StartMishBuddy.sh
		chmod +x $DIRECTORY/StartMishBuddy.sh
	fi
	if [[ $OPTIONAL == *"SLMap"* ]]; then
  		#echo "Bitnykk SLmap Selected"
  		clear
		echo 25 | dialog --title "Installing" --gauge "Downloading SLmap." 10 75 &
  		curl -O https://rubi-ka.net/bitnykk/SLmap-v2.1-normal.zip 2> /dev/null
	fi
	if [[ $OPTIONAL == *"RKMap"* ]]; then
  		#echo "Savic RK map Selected"
  		clear
		echo 26 | dialog --title "Installing" --gauge "Downloading SaavicksMap." 10 75 &
  		curl -O http://singsrv.magzu.net/SaavicksMap.zip 2> /dev/null
	fi
	if [[ $OPTIONAL == *"TinyDump"* ]]; then
  		#echo "TinyDump selected"
  		clear
		echo 27 | dialog --title "Installing" --gauge "Downloading TinyDump." 10 75 &
  		curl -O http://tinydump.adams1.de/dateien/SetupTinyDump_1_1_1.exe 2> /dev/null
  		clear
		echo 28 | dialog --title "Installing" --gauge "Installing TinyDump." 10 75 &
  		WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 wine SetupTinyDump_1_1_1.exe /silent
  		
  		#Shortcut
  		echo "#!/bin/bash" > $DIRECTORY/StartTinyDump.sh
  		echo "cd $folder/drive_c/Program\ Files/TinyDump/" >> $DIRECTORY/StartTinyDump.sh
		echo "WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 wine TinyDump.exe" >> $DIRECTORY/StartTinyDump.sh
		chmod +x $DIRECTORY/StartTinyDump.sh
	fi

clear
echo 30 | dialog --title "Installing" --gauge "Installing game. Please select defaults" 10 75 &

WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 wine AnarchyOnline_EP1.exe 
clear
echo 95 | dialog --title "Installing" --gauge "Installing addons" 10 75 &
	if [[ $OPTIONAL == *"SLMap"* ]]; then
  		unzip SLmap-v2.1-normal.zip -d ../drive_c/Funcom/Anarchy\ Online/cd_image/textures/PlanetMap/ 2> /dev/null
  		
	fi
	if [[ $OPTIONAL == *"RKMap"* ]]; then
  		rm ../drive_c/Funcom/Anarchy\ Online/cd_image/textures/PlanetMap/SaavicksMap/*
  		unzip SaavicksMap.zip -d ../drive_c/Funcom/Anarchy\ Online/cd_image/textures/PlanetMap/SaavicksMap/ 2> /dev/null
  		
	fi
clear
echo 99 | dialog --title "Installing" --gauge "Creating shortcuts" 10 75 &

cd $DIRECTORY
echo "#!/bin/bash" > StartAO.sh
echo "cd $folder/drive_c/Funcom/Anarchy\ Online/" >> StartAO.sh
echo "WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 wine AnarchyOnline.exe" >> StartAO.sh
chmod +x StartAO.sh


clear
echo 100 | dialog --title "Installing" --gauge "Done" 10 75 &
sleep 3
clear 
echo installation is complete.          

    
    
                ;;





        2)
TITLE="Installation - New Engine"
MENU="Which version?"

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
MishBuddy "Alternative to ClickSaver" off \
RKMap "Improved Rubi-Ka Planet Map" off \
SLMap "Improved ShadowLands Planet Map" off \
TinyDump "WIP - damage dumper to see how much damage you do" off \
2> /var/tmp/optional.out
if [ "$?" != "0" ]
then
	clear
	echo "cancel pressed. Exiting script."
	exit
fi

OPTIONAL=`cat /var/tmp/optional.out | \
    sed -e "s/\"//g" -e "s/ /|/g" -e "s/|$//"`
    echo 'optional :'$OPTIONAL

folder="$(zenity --file-selection --directory --title="Choose install directory")"
clear
echo 10 | dialog --title "Installing" --gauge "Creating wineprefix" 10 75 &

WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 winetricks d3dcompiler_43 d3dx9 > /dev/null

cd $folder
clear
echo 20 | dialog --title "Installing" --gauge "Downloading files" 10 75 &

mkdir dl
cd dl
curl -O http://update.anarchy-online.com/download/AO/AnarchyOnline_EP2.exe 2> /dev/null

#ThirdParty
	if [[ $OPTIONAL == *"Clicksaver"* ]]; then
  		#echo "Clicksaver Selected" 
  		clear
		echo 21 | dialog --title "Installing" --gauge "Downloading Clicksaver." 10 75 &
  		curl -O http://singsrv.magzu.net/CS240.zip 2> /dev/null
  		clear
		echo 22 | dialog --title "Installing" --gauge "Installing Clicksaver." 10 75 &
  		mkdir ../drive_c/Clicksaver/
  		unzip CS240.zip -d ../drive_c/Clicksaver/ 2> /dev/null
  		
  		#Shortcut
  		echo "#!/bin/bash" > $DIRECTORY/StartClicksaver.sh
  		echo "cd $folder/drive_c/Clicksaver/" >> $DIRECTORY/StartClicksaver.sh
		echo "WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 wine ClickSaver.exe" >> $DIRECTORY/StartClicksaver.sh
		chmod +x $DIRECTORY/StartClicksaver.sh
	fi
	if [[ $OPTIONAL == *"MishBuddy"* ]]; then
  		#echo "MishBuddy Selected"
  		clear
		echo 23 | dialog --title "Installing" --gauge "Downloading MishBuddy." 10 75 &
  		curl -O curl -O https://www.mmotoolbox.com/download/mbsetup.exe 2> /dev/null
  		clear
		echo 24 | dialog --title "Installing" --gauge "Installing MishBuddy. Please Select Defaults" 10 75 &
		WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 wine mbsetup.exe
		
		#Shortcut
		echo "#!/bin/bash" > $DIRECTORY/StartMishBuddy.sh
  		echo "cd $folder/drive_c/Program\ Files/MMOToolbox/MishBuddy/" >> $DIRECTORY/StartMishBuddy.sh
		echo "WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 wine MishBuddy.exe" >> $DIRECTORY/StartMishBuddy.sh
		chmod +x $DIRECTORY/StartMishBuddy.sh
	fi
	if [[ $OPTIONAL == *"SLMap"* ]]; then
  		#echo "Bitnykk SLmap Selected"
  		clear
		echo 25 | dialog --title "Installing" --gauge "Downloading SLmap." 10 75 &
  		curl -O https://rubi-ka.net/bitnykk/SLmap-v2.1-normal.zip 2> /dev/null
	fi
	if [[ $OPTIONAL == *"RKMap"* ]]; then
  		#echo "Savic RK map Selected"
  		clear
		echo 26 | dialog --title "Installing" --gauge "Downloading SaavicksMap." 10 75 &
  		curl -O http://singsrv.magzu.net/SaavicksMap.zip 2> /dev/null
	fi
	if [[ $OPTIONAL == *"TinyDump"* ]]; then
  		#echo "TinyDump selected"
  		clear
		echo 27 | dialog --title "Installing" --gauge "Downloading TinyDump." 10 75 &
  		curl -O http://tinydump.adams1.de/dateien/SetupTinyDump_1_1_1.exe 2> /dev/null
  		clear
		echo 28 | dialog --title "Installing" --gauge "Installing TinyDump." 10 75 &
  		WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 wine SetupTinyDump_1_1_1.exe /silent
  		
  		#Shortcut
  		echo "#!/bin/bash" > $DIRECTORY/StartTinyDump.sh
  		echo "cd $folder/drive_c/Program\ Files/TinyDump/" >> $DIRECTORY/StartTinyDump.sh
		echo "WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 wine TinyDump.exe" >> $DIRECTORY/StartTinyDump.sh
		chmod +x $DIRECTORY/StartTinyDump.sh
	fi
clear
echo 30 | dialog --title "Installing" --gauge "Installing game. Please select defaults" 10 75 &

WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 wine AnarchyOnline_EP2.exe 
clear
echo 95 | dialog --title "Installing" --gauge "Installing addons" 10 75 &
	if [[ $OPTIONAL == *"SLMap"* ]]; then
  		unzip SLmap-v2.1-normal.zip -d ../drive_c/Funcom/Anarchy\ Online/cd_image/textures/PlanetMap/ 2> /dev/null
  		
	fi
	if [[ $OPTIONAL == *"RKMap"* ]]; then
  		rm ../drive_c/Funcom/Anarchy\ Online/cd_image/textures/PlanetMap/SaavicksMap/*
  		unzip SaavicksMap.zip -d ../drive_c/Funcom/Anarchy\ Online/cd_image/textures/PlanetMap/SaavicksMap/ 2> /dev/null
  		
	fi
clear
echo 99 | dialog --title "Installing" --gauge "Creating shortcuts" 10 75 &

cd $DIRECTORY
echo "#!/bin/bash" > StartAO.sh
echo "cd $folder/drive_c/Funcom/Anarchy\ Online/" >> StartAO.sh
echo "WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 wine AnarchyOnline.exe" >> StartAO.sh
chmod +x StartAO.sh

clear
echo 100 | dialog --title "Installing" --gauge "Done" 10 75 &
sleep 3
clear 
echo installation is complete.          

            ;;
        2)
echo d9vk  

dialog --checklist "Choose from following (spacebar to select)" 0 0 0 \
Clicksaver "Tool to look for missions" off \
MishBuddy "Alternative to ClickSaver" off \
RKMap "Improved Rubi-Ka Planet Map" off \
SLMap "Improved ShadowLands Planet Map" off \
TinyDump "WIP - damage dumper to see how much damage you do" off \
2> /var/tmp/optional.out
if [ "$?" != "0" ]
then
	clear
	echo "cancel pressed. Exiting script."
	exit
fi

OPTIONAL=`cat /var/tmp/optional.out | \
    sed -e "s/\"//g" -e "s/ /|/g" -e "s/|$//"`
    echo 'optional :'$OPTIONAL


#New Engine - D9VK

folder="$(zenity --file-selection --directory --title="Choose install directory")"
clear
echo 10 | dialog --title "Installing" --gauge "Creating wineprefix" 10 75 &

WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 winetricks d3dcompiler_43 d3dx9 d9vk_master > /dev/null

cd $folder
clear
echo 20 | dialog --title "Installing" --gauge "Downloading files" 10 75 &

mkdir dl
cd dl
curl -O http://update.anarchy-online.com/download/AO/AnarchyOnline_EP2.exe 2> /dev/null

#ThirdParty
	if [[ $OPTIONAL == *"Clicksaver"* ]]; then
  		#echo "Clicksaver Selected" 
  		clear
		echo 21 | dialog --title "Installing" --gauge "Downloading Clicksaver." 10 75 &
  		curl -O http://singsrv.magzu.net/CS240.zip 2> /dev/null
  		clear
		echo 22 | dialog --title "Installing" --gauge "Installing Clicksaver." 10 75 &
  		mkdir ../drive_c/Clicksaver/
  		unzip CS240.zip -d ../drive_c/Clicksaver/ 2> /dev/null
  		
  		#Shortcut
  		echo "#!/bin/bash" > $DIRECTORY/StartClicksaver.sh
  		echo "cd $folder/drive_c/Clicksaver/" >> $DIRECTORY/StartClicksaver.sh
		echo "WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 wine ClickSaver.exe" >> $DIRECTORY/StartClicksaver.sh
		chmod +x $DIRECTORY/StartClicksaver.sh
	fi
	if [[ $OPTIONAL == *"MishBuddy"* ]]; then
  		#echo "MishBuddy Selected"
  		clear
		echo 23 | dialog --title "Installing" --gauge "Downloading MishBuddy." 10 75 &
  		curl -O curl -O https://www.mmotoolbox.com/download/mbsetup.exe 2> /dev/null
  		clear
		echo 24 | dialog --title "Installing" --gauge "Installing MishBuddy. Please Select Defaults" 10 75 &
		WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 wine mbsetup.exe
		
		#Shortcut
		echo "#!/bin/bash" > $DIRECTORY/StartMishBuddy.sh
  		echo "cd $folder/drive_c/Program\ Files/MMOToolbox/MishBuddy/" >> $DIRECTORY/StartMishBuddy.sh
		echo "WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 wine MishBuddy.exe" >> $DIRECTORY/StartMishBuddy.sh
		chmod +x $DIRECTORY/StartMishBuddy.sh
	fi
	if [[ $OPTIONAL == *"SLMap"* ]]; then
  		#echo "Bitnykk SLmap Selected"
  		clear
		echo 25 | dialog --title "Installing" --gauge "Downloading SLmap." 10 75 &
  		curl -O https://rubi-ka.net/bitnykk/SLmap-v2.1-normal.zip 2> /dev/null
	fi
	if [[ $OPTIONAL == *"RKMap"* ]]; then
  		#echo "Savic RK map Selected"
  		clear
		echo 26 | dialog --title "Installing" --gauge "Downloading SaavicksMap." 10 75 &
  		curl -O http://singsrv.magzu.net/SaavicksMap.zip 2> /dev/null
	fi
	if [[ $OPTIONAL == *"TinyDump"* ]]; then
  		#echo "TinyDump selected"
  		clear
		echo 27 | dialog --title "Installing" --gauge "Downloading TinyDump." 10 75 &
  		curl -O http://tinydump.adams1.de/dateien/SetupTinyDump_1_1_1.exe 2> /dev/null
  		clear
		echo 28 | dialog --title "Installing" --gauge "Installing TinyDump." 10 75 &
  		WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 wine SetupTinyDump_1_1_1.exe /silent
  		
  		#Shortcut
  		echo "#!/bin/bash" > $DIRECTORY/StartTinyDump.sh
  		echo "cd $folder/drive_c/Program\ Files/TinyDump/" >> $DIRECTORY/StartTinyDump.sh
		echo "WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 wine TinyDump.exe" >> $DIRECTORY/StartTinyDump.sh
		chmod +x $DIRECTORY/StartTinyDump.sh
	fi
clear
echo 30 | dialog --title "Installing" --gauge "Installing game. Please select defaults" 10 75 &

WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 wine AnarchyOnline_EP2.exe 
clear
echo 95 | dialog --title "Installing" --gauge "Installing addons" 10 75 &
	if [[ $OPTIONAL == *"SLMap"* ]]; then
  		unzip SLmap-v2.1-normal.zip -d ../drive_c/Funcom/Anarchy\ Online/cd_image/textures/PlanetMap/ 2> /dev/null
  		
	fi
	if [[ $OPTIONAL == *"RKMap"* ]]; then
  		rm ../drive_c/Funcom/Anarchy\ Online/cd_image/textures/PlanetMap/SaavicksMap/*
  		unzip SaavicksMap.zip -d ../drive_c/Funcom/Anarchy\ Online/cd_image/textures/PlanetMap/SaavicksMap/ 2> /dev/null
  		
	fi
clear
echo 99 | dialog --title "Installing" --gauge "Creating shortcuts" 10 75 &

cd $DIRECTORY
echo "#!/bin/bash" > StartAO.sh
echo "cd $folder/drive_c/Funcom/Anarchy\ Online/" >> StartAO.sh
echo "WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 wine AnarchyOnline.exe" >> StartAO.sh
chmod +x StartAO.sh




clear
echo 100 | dialog --title "Installing" --gauge "Done" 10 75 &
sleep 3
clear 
echo installation is complete.          

esac
esac
