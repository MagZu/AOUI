#!/bin/bash

        ###########################################
        ############## Functions ##################
        ###########################################

distro_prereq () {
echo test


}

engine_selection () {

dialog --radiolist "What AO client are you using? (spacebar to select)" 0 0 0 \
		Old-engine "Old Engine" off \
		New-engine "New Engine" off \
		2> /var/tmp/engine.out
		if [ "$?" = "1" ]
		then
			clear
			echo "cancel pressed. Exiting script."
			exit
		fi

		engineopt=`cat /var/tmp/engine.out | \
		    sed -e "s/\"//g" -e "s/ /|/g" -e "s/|$//"`
		    echo 'optional :'$engineopt 
  		clear
  		
  	if [[ $engineopt == *"Old-engine"* ]]; then
  		engine=NE
  	fi
  	if [[ $engineopt == *"New-engine"* ]]; then
  		engine=NE
  	fi


}

dialog_addons () {

	dialog --checklist "Choose from following (spacebar to select)" 0 0 0 \
	Clicksaver "Tool to look for missions" off \
	MishBuddy "Alternative to ClickSaver" off \
	RKMap "Improved Rubi-Ka Planet Map" off \
	SLMap "Improved ShadowLands Planet Map" off \
	TinyDump "damage dumper to see how much damage you do" off \
	Notum-Dovtech "Custom UI for AO with multiple options" off \
	2> /var/tmp/optional.out
	
	if [ "$?" = "1" ]
	then
		clear
		echo "cancel pressed. Exiting script."
		exit
	fi

OPTIONAL=`cat /var/tmp/optional.out | \
    sed -e "s/\"//g" -e "s/ /|/g" -e "s/|$//"`
    echo 'optional :'$OPTIONAL 

}



clicksaver_install () {

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


}


mishbuddy_install () {

  		#echo "MishBuddy Selected"
  		clear
		echo 23 | dialog --title "Installing" --gauge "Downloading MishBuddy." 10 75 &
  		curl -O https://www.mmotoolbox.com/download/mbsetup.exe 
  		clear
		echo 24 | dialog --title "Installing" --gauge "Installing MishBuddy. Please Select Defaults" 10 75 &
		WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 wine mbsetup.exe 
		
		#Shortcut
		echo "#!/bin/bash" > $DIRECTORY/StartMishBuddy.sh
  		echo "cd $folder/drive_c/Program\ Files/MMOToolbox/MishBuddy/" >> $DIRECTORY/StartMishBuddy.sh
		echo "WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 wine MishBuddy.exe" >> $DIRECTORY/StartMishBuddy.sh
		chmod +x $DIRECTORY/StartMishBuddy.sh

}


slmap_install () {

  		#echo "Bitnykk SLmap Selected"
  		clear
		echo 25 | dialog --title "Installing" --gauge "Downloading SLmap." 10 75 &
  		curl -O https://rubi-ka.net/bitnykk/SLmap-v2.1-normal.zip 2> /dev/null

}

slmap_unzip () {

  		unzip SLmap-v2.1-normal.zip -d ../drive_c/Funcom/Anarchy\ Online/cd_image/textures/PlanetMap/ 2> /dev/null
  		
}


rkmap_install () {

  		#echo "Savic RK map Selected"
  		clear
		echo 26 | dialog --title "Installing" --gauge "Downloading SaavicksMap." 10 75 &
  		curl -O http://singsrv.magzu.net/SaavicksMap.zip 2> /dev/null

}

rkmap_unzip () {

  		rm ../drive_c/Funcom/Anarchy\ Online/cd_image/textures/PlanetMap/SaavicksMap/*
  		unzip SaavicksMap.zip -d ../drive_c/Funcom/Anarchy\ Online/cd_image/textures/PlanetMap/SaavicksMap/ 2> /dev/null

}

tinydump_install () {

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

}

dovtech_install () {

  		#echo "Notum-Dovtech Selected"
  		dialog --radiolist "Which flavor of Notum-Dovtech? (spacebar to select)" 0 0 0 \
		Notum-dovvetech "Vanilla theme" off \
		Notum-dovvetech-dark "flat Dark theme" off \
		Notum-dovvetech-edge "Vanilla but transparent window edges" off \
		Notum-darktech "Dark mode theme" off \
		Notum-darktech-mini "Flat dark mode with transparent window edges" off \
		Notum-darktech-mini-HUD 'Flat dark mode with circular health/nano bars' off \
		Notum-darktech-glass 'flat transparent theme' off \
		2> /var/tmp/notumopt.out
		if [ "$?" = "1" ]
		then
			clear
			echo "cancel pressed. Exiting script."
			exit
		fi

		notumopt=`cat /var/tmp/notumopt.out | \
		    sed -e "s/\"//g" -e "s/ /|/g" -e "s/|$//"`
		    echo 'optional :'$notumopt 
  		clear
		echo 29 | dialog --title "Installing" --gauge "Installing Notum-Dovtech." 10 75 &
		
		curl -O https://rubi-ka.net/ndgui/ndGUI_4.3.4.7_Core.zip 2> /dev/null
		mv ndGUI_4.3.4.7_Core.zip ndGUI_Core.zip
		
		if [[ $engine == *"NE"* ]]; then
		curl -O https://rubi-ka.net/ndgui/ndGUI_4.3.4.7_New_Engine_Patch.zip 2> /dev/null
		fi
		
		if [[ $notumopt == *"Notum-dovvetech"* ]]; then
			echo "Vanilla theme"
			curl -O https://rubi-ka.net/ndgui/ndGUI_4.3.4.5_Theme_Dovve.zip 2> /dev/null
			mv ndGUI_4.3.4.5_Theme_Dovve.zip ndGUI_theme.zip
		fi
		if [[ $notumopt == *"Notum-dovvetech-dark"* ]]; then
			echo "flat dark theme"
			curl -O https://rubi-ka.net/ndgui/ndGUI_4.3.4.5_Theme_DovveDark.zip 2> /dev/null
			mv ndGUI_4.3.4.5_Theme_DovveDark.zip ndGUI_theme.zip
		fi
		if [[ $notumopt == *"Notum-dovvetech-edge"* ]]; then
			echo "Vanilla but transparent window edges"
			curl -O https://rubi-ka.net/ndgui/ndGUI_4.3.4.5_Theme_DovveEdge.zip 2> /dev/null
			mv ndGUI_4.3.4.5_Theme_DovveEdge.zip ndGUI_theme.zip
		fi
		if [[ $notumopt == *"Notum-darktech"* ]]; then
			echo "Dark mode theme"
			curl -O https://rubi-ka.net/ndgui/ndGUI_4.3.4.5_Theme_Dark.zip 2> /dev/null
			mv ndGUI_4.3.4.5_Theme_Dark.zip ndGUI_theme.zip
		fi
		if [[ $notumopt == *"Notum-darktech-mini"* ]]; then
			echo "Flat dark mode with transparent window edges"
			curl -O https://rubi-ka.net/ndgui/ndGUI_4.3.4.5_Theme_DarkMini.zip 2> /dev/null
			mv ndGUI_4.3.4.5_Theme_DarkMini.zip ndGUI_theme.zip
		fi
		if [[ $notumopt == *"Notum-darktech-mini-HUD"* ]]; then
			echo "flat dark mode with circular health and nano bars"
			curl -O https://rubi-ka.net/ndgui/ndGUI_4.3.4.5_Theme_DarkMiniHUD.zip 2> /dev/null
			mv ndGUI_4.3.4.5_Theme_DarkMiniHUD.zip ndGUI_theme.zip
		fi
		if [[ $notumopt == *"Notum-darktech-glass"* ]]; then
			echo "flat transparent theme"
			curl -O https://rubi-ka.net/ndgui/ndGUI_4.3.4.5_Theme_DarkGlass.zip 2> /dev/null
			mv ndGUI_4.3.4.5_Theme_DarkGlass.zip ndGUI_theme.zip
		fi
		

}

dovtech_unzip () {

		cd $folder/drive_c/Funcom/Anarchy\ Online/
		WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 wine AnarchyOnline.exe &
		sleep 4
		pkill anarchy.exe
		cd $folder/dl
		
		prefs="../drive_c/users/$USER/Local\ Settings/Application\ Data/Funcom/Anarchy\ Online/70dad3e6/Anarchy\ Online/Prefs/Prefs.xml"
		if [ -f "$prefs" ];
		then
   			sed -i 's/Default/ndGUI/g' ../drive_c/users/$USER/Local\ Settings/Application\ Data/Funcom/Anarchy\ Online/70dad3e6/Anarchy\ Online/Prefs/Prefs.xml
		else
   			mkdir ../drive_c/users/$USER/Local\ Settings/Application\ Data/Funcom/Anarchy\ Online/70dad3e6/Anarchy\ Online/Prefs
			echo "<Root>" > ../drive_c/users/$USER/Local\ Settings/Application\ Data/Funcom/Anarchy\ Online/70dad3e6/Anarchy\ Online/Prefs/Prefs.xml
			echo '<Value name="GUIName"'" value='&quot;ndGUI&quot;' />" >> ../drive_c/users/$USER/Local\ Settings/Application\ Data/Funcom/Anarchy\ Online/70dad3e6/Anarchy\ Online/Prefs/Prefs.xml
			echo "</Root>" >> ../drive_c/users/$USER/Local\ Settings/Application\ Data/Funcom/Anarchy\ Online/70dad3e6/Anarchy\ Online/Prefs/Prefs.xml
		fi

  		unzip ndGUI_Core.zip -d ../drive_c/users/$USER/Local\ Settings/Application\ Data/Funcom/Anarchy\ Online/70dad3e6/Anarchy\ Online/Gui/ 2> /dev/null
  		unzip -o ndGUI_theme.zip -d ../drive_c/users/$USER/Local\ Settings/Application\ Data/Funcom/Anarchy\ Online/70dad3e6/Anarchy\ Online/Gui/ 2> /dev/null
  		
  		if [[ $engine == *"NE"* ]]; then
  		unzip -o ndGUI_NE_patch.zip -d ../drive_c/users/$USER/Local\ Settings/Application\ Data/Funcom/Anarchy\ Online/70dad3e6/Anarchy\ Online/Gui/ 2> /dev/null
		fi

}


install_AO () {

install=$1

folder="$(zenity --file-selection --directory --title="Choose install directory")"
clear

if [[ $install != *"3rd-party"* ]]; then
echo 10 | dialog --title "Installing" --gauge "Creating wineprefix" 10 75 &
fi

if [[ $install == *"old-wined3d"* ]]; then
	WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 winetricks winxp corefonts 
fi
if [[ $install == *"ne-wined3d"* ]]; then
	WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 winetricks d3dcompiler_43 d3dx9 corefonts 
fi
if [[ $install == *"ne-d9vk"* ]]; then
	WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 winetricks d3dcompiler_43 d3dx9 d9vk_master corefonts 
fi

cd $folder
clear
echo 20 | dialog --title "Installing" --gauge "Downloading files" 10 75 &

mkdir dl
cd dl

if [[ $install == *"old-wined3d"* ]]; then
	curl -O http://update.anarchy-online.com/download/AO/AnarchyOnline_EP1.exe 2> /dev/null
fi
if [[ $install == *"ne-wined3d"* ]]; then
	curl -O http://update.anarchy-online.com/download/AO/AnarchyOnline_EP2.exe 2> /dev/null
fi
if [[ $install == *"ne-d9vk"* ]]; then
	curl -O http://update.anarchy-online.com/download/AO/AnarchyOnline_EP2.exe 2> /dev/null
fi       
    
#ThirdParty
	if [[ $OPTIONAL == *"Clicksaver"* ]]; then
		clicksaver_install
	fi
	if [[ $OPTIONAL == *"MishBuddy"* ]]; then
		mishbuddy_install
	fi
	if [[ $OPTIONAL == *"SLMap"* ]]; then
		slmap_install
	fi
	if [[ $OPTIONAL == *"RKMap"* ]]; then
		rkmap_install
	fi
	if [[ $OPTIONAL == *"TinyDump"* ]]; then
		tinydump_install
	fi
	if [[ $OPTIONAL == *"Notum-Dovtech"* ]]; then
		dovtech_install
	fi

clear
echo 30 | dialog --title "Installing" --gauge "Installing game. Please select defaults" 10 75 &
if [[ $install == *"old-wined3d"* ]]; then
	WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 wine AnarchyOnline_EP1.exe
fi
if [[ $install == *"ne-wined3d"* ]]; then
	WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 wine AnarchyOnline_EP2.exe
fi
if [[ $install == *"ne-d9vk"* ]]; then
	WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 wine AnarchyOnline_EP2.exe
fi
clear
echo 95 | dialog --title "Installing" --gauge "Installing addons" 10 75 &


	if [[ $OPTIONAL == *"SLMap"* ]]; then
		slmap_unzip
  		
	fi
	if [[ $OPTIONAL == *"RKMap"* ]]; then
		rkmap_unzip
  		
	fi
	if [[ $OPTIONAL == *"Notum-Dovtech"* ]]; then
		dovtech_unzip
  		
	fi
	
if [[ $install != *"3rd-party"* ]]; then

clear
echo 99 | dialog --title "Installing" --gauge "Creating shortcuts" 10 75 &

create_AO_shortcut

fi

clear
echo 100 | dialog --title "Installing" --gauge "Done" 10 75 &
sleep 3
clear 
echo installation is complete. 


}

create_AO_shortcut () {

cd $DIRECTORY

if [[ $kernel == *"FreeBSD"* ]]; then
	echo "#!/bin/bash" > StartAO.sh
	echo 'env WINEPREFIX="$folder" wine C:\windows\command\start.exe /Unix "$folder/dosdevices/c:/users/Public/Desktop/Anarchy\ Online.lnk"' >> StartAO.sh
fi
if [[ $kernel == *"Linux"* ]]; then
echo "#!/bin/bash" > StartAO.sh
echo "cd $folder/drive_c/Funcom/Anarchy\ Online/" >> StartAO.sh
echo "WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 wine AnarchyOnline.exe" >> StartAO.sh
fi

chmod +x StartAO.sh



}

launch () {

parameter=$1

echo $parameter 'is being launched'
me=$(basename "$0")

if [ -f "$parameter" ]; then
sh $parameter &
sh $me
fi
if [ ! -f "$parameter" ]; then
echo $prog" not Installed"
fi


}



        ######################################################
        ############## Install script start ##################
        ######################################################
DIRECTORY=`pwd`
HEIGHT=15
WIDTH=60
CHOICE_HEIGHT=3
BACKTITLE="Anarchy Online Unix Installer"
MENU="Choose what to do?"

OPTIONS=(1 "Launch"
         2 "Install"
         3 "Configure")
         
CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)


clear
#cd $DIRECTORY
case $CHOICE in
        1)

	HEIGHT=15
	WIDTH=60
	CHOICE_HEIGHT=4
	MENU="Choose what to Launch?"

	OPTIONS=(1 "Anarchy Online"
 	         2 "Clicksaver"
 	         3 "Mishbuddy"
 	         4 "Tinydump")
         
	CHOICE=$(dialog --clear \
    	            --backtitle "$BACKTITLE" \
    	            --title "$TITLE" \
    	            --menu "$MENU" \
    	            $HEIGHT $WIDTH $CHOICE_HEIGHT \
    	            "${OPTIONS[@]}" \
    	            2>&1 >/dev/tty)
    	            
    	            case $CHOICE in
    	            
    	            1)
    	            
    	            echo "launching AO"
    	            prog="Anarchy Online"
    	            launch StartAO.sh
    	            
    	            ;;
    	            
    	            2)
    	            
    	            echo "Lauching Clicksaver"
    	            prog="Clicksaver"
    	            launch StartClicksaver.sh
    	            
    	            
    	            
    	            
    	            ;;
    	            
    	            3)
    	            
    	            echo "Launching Mishbuddy"
    	            prog="MishBuddy"
    	            launch StartMishBuddy.sh
    	            
    	            
    	            ;;
    	            
    	            4)
    	            
    	            echo "Lauching Tinydump"
    	            prog="TinyDump"
    	            launch StartTinyDump
    	           
    	            
    	            exit
    	            esac

        
        
        ;;
        
        
        2)

DIRECTORY=`pwd`
kernel=$(uname -a)
HEIGHT=15
WIDTH=60
CHOICE_HEIGHT=3
BACKTITLE="Anarchy Online Installer"
MENU="What engine?"

OPTIONS=(1 "Old Client"
         2 "New Engine"
         3 "Third Party only")
         
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
        
        
        
        ###########################################
        ######### Old Engine - wined3d ############
        ###########################################        


dialog_addons

install_AO old-wined3d
            
    
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
        
        ###########################################
        ######### NEW Engine - wined3d ############
        ###########################################
        
echo wined3d

dialog_addons

engine=NE

install_AO ne-wined3d
    

            ;;
        2)
        
        
        ###########################################
        ######### NEW Engine - d9vk ###############
        ###########################################
        
        
echo d9vk  

dialog_addons

engine=NE

install_AO ne-d9vk

          

		esac
		;;


		3)
		
		############################################
        ######### Install Thirdparty ###############
        ############################################
		
echo 'Third party only'
dialog_addons

engine_selection

install_AO 3rd-party		

		


		esac
		;;
		
		
		3)
		
		echo "Configure"
		
		HEIGHT=15
		WIDTH=60
		CHOICE_HEIGHT=4
		MENU="What to configure?"

		OPTIONS=(1 "Winecfg"
	 	         2 "Winetricks"
	 	         3 "Update D9VK on New Engine-D9VK install."
	 	         4 "Update AOUI.sh")
         
		CHOICE=$(dialog --clear \
	    	            --backtitle "$BACKTITLE" \
	    	            --title "$TITLE" \
	    	            --menu "$MENU" \
	    	            $HEIGHT $WIDTH $CHOICE_HEIGHT \
	    	            "${OPTIONS[@]}" \
	    	            2>&1 >/dev/tty)
    	            
	    	            case $CHOICE in
    	            
	    	            1)
					#Winecfg
					
					folder='$(zenity --file-selection --directory --title="Select Prefix Folder for AO")'
					WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 winecfg
					echo 'done'
					;;
					
					2)
					#Winetricks
					
					folder='$(zenity --file-selection --directory --title="Select Prefix Folder for AO")'
					WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 winetricks
					echo 'done'
					;;
					
					3)
					#Update D9Vk
					folder='$(zenity --file-selection --directory --title="Select Prefix Folder for AO")'
					WINEDEBUG=-all WINEPREFIX=$folder WINEARCH=win32 winetricks d9vk_master
					echo 'done'
					;;
					4)
		
					echo 'Updating AOUI.sh'
					cd $DIRECTORY
					rm AOUI.sh
					curl -O https://raw.githubusercontent.com/magzu/AOUI/master/AOUI.sh
					bash $DIRECTORY/AOUI.sh
					esac
		
esac
