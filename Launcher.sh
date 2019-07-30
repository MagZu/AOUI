#!/bin/bash

GTKDIALOG=gtkdialog 
export MAIN_DIALOG=' 

<window title="Anarchy Online Launcher" icon-name="gtk-about" resizable="false" width-request="640" height-request="480"> 

  <vbox>
	  <pixmap>
		  <input file>/home/magzu/Bilder/AO.png</input><height>256</height>
	  </pixmap>
  </vbox>

</window> 
' 

case $1 in 
	-d | --dump) echo "$MAIN_DIALOG" ;; 
	*) $GTKDIALOG --program=MAIN_DIALOG --center ;; 

esac 
