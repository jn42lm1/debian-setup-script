#!/bin/bash

source $(dirname $0)/common.sh
source $(dirname $0)/packages.sh

# ---------------------------------------------------------------------------------------------------------------------

# Set script parts to run.
INITIALISE_PACKAGE_MANAGER=false
INSTALL_SYSTEM_PACKAGES=false
REMOVE_BLOATWARE=false
CLEANUP_PACKAGE_MANAGER=false

INSTALL_WEB_APPS=false
INSTALL_DESKTOP_APPS=true
INSTALL_SERVICES=false

INSTALL_EXTENSIONS=false
INSTALL_THEMES=true
INSTALL_ICONS=false
SETUP_APP_GRID=true
CONFIGURE_SHELL=true
REMOVE_CONTENT_DIRECTORIES=true

MOUNT_NVME=false

INSTALL_GPU_DRIVERS=false

# ---------------------------------------------------------------------------------------------------------------------

setupAppGrid()
{
	startRun "Create app folders"
		gsettings set org.gnome.desktop.app-folders folder-children "['Development', 'Games', 'Creative', 'Office', 'Utilities', 'System']"
	endRun

	startRun "Add apps to /Development"
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Development/ name ' Development '
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Development/ categories "[]"
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Development/ apps "['code_code.desktop', 'android-studio_android-studio.desktop', 'insomnia_insomnia.desktop', 'mongodb-compass.desktop', 'drawio_drawio.desktop', 'org.raspberrypi.rpi-imager.desktop']"
	endRun

	startRun "Add apps to /Games"
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Games/ name ' Games '
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Games/ categories "[]"
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Games/ apps "['minecraft-launcher.desktop', 'steam.desktop']"
	endRun

	startRun "Add apps to /Creative"
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Creative/ name ' Creative '
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Creative/ categories "[]"
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Creative/ apps "['gimp.desktop', 'inkscape_inkscape.desktop', 'com.github.PintaProject.Pinta.desktop', 'vectr_vectr.desktop', 'org.pitivi.Pitivi.desktop', 'rhythmbox.desktop']"
	endRun

	startRun "Add apps to /Office"
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Office/ name ' Office '
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Office/ categories "[]"
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Office/ apps "['libreoffice-writer.desktop', 'libreoffice-calc.desktop', 'libreoffice-draw.desktop', 'libreoffice-impress.desktop', 'libreoffice-startcenter.desktop']"
	endRun

	startRun "Add apps to /System"
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/System/ name ' System '
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/System/ categories "[]"
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/System/ apps "['calendar.desktop', 'org.gnome.clocks.desktop', 'org.gnome.Calculator.desktop', 'org.gnome.gedit.desktop', 'org.gnome.Cheese.desktop', 'org.gnome.SoundRecorder.desktop', 'org.gnome.Contacts.desktop', 'org.gnome.Photos.desktop', 'org.gnome.Totem.desktop', 'org.gnome.Screenshot.desktop', 'com.uploadedlobster.peek.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.eog.desktop', 'org.gnome.Evince.desktop', 'simple-scan.desktop', 'org.gnome.Tour.desktop', 'zorin-connect.desktop']"
	endRun

	startRun "Add apps to /Utilities"
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Utilities/ name ' Utilities '
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Utilities/ categories "[]"
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Utilities/ apps "['gnome-system-monitor.desktop', 'org.gnome.Terminal.desktop', 'zorin-appearance.desktop', 'org.gnome.tweaks.desktop', 'ca.desrt.dconf-editor.desktop', 'org.gnome.Extensions.desktop', 'gnome-control-center.desktop', 'org.gnome.DiskUtility.desktop', 'org.gnome.baobab.desktop', 'update-manager.desktop', 'software-properties-gtk.desktop', 'software-properties-drivers.desktop', 'nvidia-settings.desktop', 'gufw.desktop', 'org.remmina.Remmina.desktop', 'org.gnome.seahorse.Application.desktop', 'org.gnome.DejaDup.desktop', 'org.gnome.Logs.desktop', 'gnome-session-properties.desktop', 'alacarte.desktop', 'org.gnome.PowerStats.desktop', 'org.gnome.FileRoller.desktop', 'org.gnome.Characters.desktop', 'org.gnome.font-viewer.desktop', 'gnome-language-selector.desktop', 'yelp.desktop', 'zorin-os-feedback.desktop']"
	endRun

	startRun "Set app favourites"
		gsettings set org.gnome.shell favorite-apps "['org.gnome.Nautilus.desktop', 'gmail.desktop', 'calendar.desktop', 'keep.desktop', 'trello.desktop', 'drive.desktop', 'photos.desktop', 'youtube.desktop', 'google-chrome.desktop', 'code_code.desktop', 'org.gnome.Terminal.desktop', 'steam.desktop']"
	endRun

	startRun "Sort app groups"
		gsettings set org.gnome.shell app-picker-layout "[{'Games': <{'position': <0>}>, 'Development': <{'position': <1>}>, 'Creative': <{'position': <2>}>, 'Office': <{'position': <3>}>, 'System': <{'position': <4>}>, 'Utilities': <{'position': <5>}>}]"
	endRun
}

configureShell()
{
	startRun "Show date on clock"
		dconf write /org/gnome/desktop/interface/clock-show-date true
	endRun

	startRun "Hide hot corners"
		dconf write /org/gnome/desktop/interface/enable-hot-corners false
	endRun

	startRun "Show minimize/maximise buttons"
		dconf write /org/gnome/desktop/wm/preferences/button-layout "'appmenu:minimize,maximize,close'"
	endRun

	startRun "Set background"
		gsettings set org.gnome.desktop.background color-shading-type solid
		gsettings set org.gnome.desktop.background picture-options zoom
		gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/Rocky-Mountain-by-Luca-Bravo.jpg
		gsettings set org.gnome.desktop.background primary-color "#000000"
		gsettings set org.gnome.desktop.background secondary-color "#000000"
	endRun

	startRun "Set screensaver"
		gsettings set org.gnome.desktop.screensaver color-shading-type solid
		gsettings set org.gnome.desktop.screensaver picture-options zoom
		gsettings set org.gnome.desktop.screensaver picture-uri file:///usr/share/backgrounds/Rocky-Mountain-by-Luca-Bravo.jpg
		gsettings set org.gnome.desktop.screensaver primary-color "#ffffff"
		gsettings set org.gnome.desktop.screensaver secondary-color "#000000"
	endRun

	startRun "Pin app favourites"
		dconf write /org/gnome/shell/favorite-apps "['org.gnome.Nautilus.desktop', 'org.gnome.Terminal.desktop', 'google-chrome.desktop', 'com.visualstudio.code.desktop']"
	endRun
	
	startRun "Activate shell layout"
		dconf write /org/gnome/shell/disabled-extensions "['zorin-dash@zorinos.com', 'zorin-hide-activities-move-clock@zorinos.com', 'zorin-menu@zorinos.com']"
		dconf write /org/gnome/shell/disable-user-extensions false
		dconf write /org/gnome/shell/enabled-extensions "['drive-menu@gnome-shell-extensions.gcampax.github.com', 'remove-dropdown-arrows@mpdeimos.com', 'user-theme@gnome-shell-extensions.gcampax.github.com', 'x11gestures@joseexposito.github.io', 'zorin-appindicator@zorinos.com', 'zorin-desktop-icons@zorinos.com', 'zorin-printers@zorinos.com', 'zorin-connect@zorinos.com', 'zorin-taskbar@zorinos.com']"
	endRun

	startRun "Activate dark theme"
		dconf write /org/gnome/shell/extensions/user-theme/name "'ZorinGrey-Dark'"
	endRun

	startRun "Show desktop icons"
		dconf write /org/gnome/shell/extensions/zorin-desktop-icons/show-home true # Show home icon
		dconf write /org/gnome/shell/extensions/zorin-desktop-icons/show-network-volumes true # Show network volumes
		dconf write /org/gnome/shell/extensions/zorin-desktop-icons/show-trash true # Show trash icon
		dconf write /org/gnome/shell/extensions/zorin-desktop-icons/show-volumes false # Hide mounted storage volumes
	endRun

	startRun "Configure taskbar"
		dconf write /org/gnome/shell/extensions/zorin-taskbar/animate-show-apps false # Disable app grid animations
		dconf write /org/gnome/shell/extensions/zorin-taskbar/click-action "'TOGGLE-SHOWPREVIEW'" # ??
		dconf write /org/gnome/shell/extensions/zorin-taskbar/multi-monitors false # Show taskbar on main monitor only
		dconf write /org/gnome/shell/extensions/zorin-taskbar/show-window-previews true # Show window previews on hover
		dconf write /org/gnome/shell/extensions/zorin-taskbar/panel-element-positions "'{\"0\":[{\"element\":\"showAppsButton\",\"visible\":true,\"position\":\"stackedTL\"},{\"element\":\"activitiesButton\",\"visible\":true,\"position\":\"stackedTL\"},{\"element\":\"leftBox\",\"visible\":true,\"position\":\"stackedTL\"},{\"element\":\"taskbar\",\"visible\":true,\"position\":\"centerMonitor\"},{\"element\":\"centerBox\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"rightBox\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"systemMenu\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"dateMenu\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"desktopButton\",\"visible\":false,\"position\":\"stackedBR\"}],\"1\":[{\"element\":\"showAppsButton\",\"visible\":true,\"position\":\"stackedTL\"},{\"element\":\"activitiesButton\",\"visible\":true,\"position\":\"stackedTL\"},{\"element\":\"leftBox\",\"visible\":true,\"position\":\"stackedTL\"},{\"element\":\"taskbar\",\"visible\":true,\"position\":\"centerMonitor\"},{\"element\":\"centerBox\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"rightBox\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"systemMenu\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"dateMenu\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"desktopButton\",\"visible\":false,\"position\":\"stackedBR\"}]}'"
		dconf write /org/gnome/shell/extensions/zorin-taskbar/panel-size 54 # Taskbar height
		dconf write /org/gnome/shell/extensions/zorin-taskbar/trans-use-custom-opacity true # Taskbar transparency active
		dconf write /org/gnome/shell/extensions/zorin-taskbar/trans-panel-opacity 0.60 # Taskbar transparency value
	endRun
	
	startRun "Configure terminal"
		dconf write /org/gnome/terminal/legacy/theme-variant "'dark'"
	endRun
	
	startRun "Configure text editor"
		dconf write /org/gnome/gedit/preferences/editor/wrap-mode "'none'" # Disable line wrapping
		dconf write /org/gnome/gedit/preferences/editor/tab-size 4 # Set tab size
	endRun
	
	startRun "Configure file manager"
		dconf write /org/gnome/nautilus/preferences/always-use-location-entry true # Show location bar
		dconf write /org/gnome/nautilus/preferences/click-policy "'double'" # Double click to open
		dconf write /org/gnome/nautilus/preferences/default-folder-viewer "'icon-view'" # View as icons
		dconf write /org/gnome/nautilus/preferences/show-create-link true # Show symlink button
		dconf write /org/gtk/settings/filechooser/sort-directories-first true # Sort folders before files
	endRun
}

# ---------------------------------------------------------------------------------------------------------------------

printText ""
printText ""
printText "               ███████╗ ██████╗ ██████╗ ██╗███╗   ██╗     ██╗ ██████╗           "
printText "               ╚══███╔╝██╔═══██╗██╔══██╗██║████╗  ██║    ███║██╔════╝           "
printText "                 ███╔╝ ██║   ██║██████╔╝██║██╔██╗ ██║    ╚██║███████╗           "
printText "                ███╔╝  ██║   ██║██╔══██╗██║██║╚██╗██║     ██║██╔═══██╗          "
printText "               ███████╗╚██████╔╝██║  ██║██║██║ ╚████║     ██║╚██████╔╝          "
printText "               ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝     ╚═╝ ╚═════╝           "
printText ""
printText "                                Clean and Simple                                "

# ---------------------------------------------------------------------------------------------------------------------

requestAuthorisation

# ---------------------------------------------------------------------------------------------------------------------

printSection "Configure System Defaults"

if [ $INITIALISE_PACKAGE_MANAGER = true ]; then

	printTitle "Ensure Everything is Setup Correctly"

	aptSetup
	snapSetup
fi

if [ $INSTALL_SYSTEM_PACKAGES = true ]; then

	printTitle "Install System Packages"

	installAPT "wget"
	installAPT "curl"
	installAPT "xdg-utils"
	installAPT "dconf-editor"
	installAPT "gnome-tweaks"
fi

if [ $REMOVE_BLOATWARE = true ]; then

	printTitle "Remove Bloatware"

	uninstallAPT "aisleriot"
	uninstallAPT "brasero"
	uninstallAPT "evolution"
	uninstallAPT "firefox"
	uninstallAPT "gnome-calendar"
	uninstallAPT "gnome-mahjongg"
	uninstallAPT "gnome-maps"
	uninstallAPT "gnome-mines"
	uninstallAPT "gnome-sudoku"
	uninstallAPT "gnome-todo"
	uninstallAPT "gnome-weather"
	uninstallAPT "quadrapassel"
fi

if [ $CLEANUP_PACKAGE_MANAGER = true ]; then

	printTitle "Clean Up"

	aptCleanUp
fi

# ---------------------------------------------------------------------------------------------------------------------

printSection "Install Apps & Services"

if [ $INSTALL_WEB_APPS = true ]; then

	printTitle "Web Apps"

	installWebApp "calendar"
	installWebApp "drive"
	installWebApp "gmail"
	installWebApp "keep"
	installWebApp "maps"
	installWebApp "photos"
	installWebApp "trello"
	installWebApp "youtube"
fi

if [ $INSTALL_DESKTOP_APPS = true ]; then

	printTitle "Desktop Apps"

	installPackage "desktopChrome"
	
	installPackage "desktopDiscord"
	#installPackage "desktopTeams"
	
	installPackage "desktopDrawIO"
	installPackage "desktopInkscape"
	#installPackage "desktopGIMP"
	installPackage "desktopPinta"
	installPackage "desktopVectr"
	
	installPackage "desktopVSCode"
	installPackage "desktopInsomnia"
	installPackage "desktopMongoDBCompass"
	installPackage "desktopRaspberryPiImager"
	installPackage "desktopAndroidStudio"

	installPackage "desktopSteam"
	installPackage "desktopMinecraft"

	installPackage "desktopPeek"

fi

if [ $INSTALL_SERVICES = true ]; then

	printTitle "Sevices"

	installPackage "serviceGit"
	installPackage "serviceNode"
	#installPackage "serviceNordvpn"
fi

# ---------------------------------------------------------------------------------------------------------------------

printSection "Make Things Look Pretty"

if [ $INSTALL_EXTENSIONS = true ]; then

	printTitle "Install Extensions"

	#installExtension "XXX"
fi

if [ $INSTALL_THEMES = true ]; then

	printTitle "Install Themes"

	installPackage "themeVimix"
fi

if [ $INSTALL_ICONS = true ]; then

	printTitle "Install Icon Sets"

	#installPackage "iconsPapirus"
fi

if [ $SETUP_APP_GRID = true ]; then

	printTitle "Setup App Grid"

	setupAppGrid
fi

if [ $CONFIGURE_SHELL = true ]; then

	printTitle "Configure Shell"

	configureShell
fi

if [ $REMOVE_CONTENT_DIRECTORIES = true ]; then

	printTitle "Remove Content Directories"

	removeContentDirectories
fi

# ---------------------------------------------------------------------------------------------------------------------

if [ $MOUNT_NVME = true ]; then

	printSection "Mount NVME Storage Drive"

	mountNVMEStorage
fi

# ---------------------------------------------------------------------------------------------------------------------

if [ $INSTALL_GPU_DRIVERS = true ]; then

	printSection "Install NVidia Drivers"

	#installNvidiaDrivers
fi

# ---------------------------------------------------------------------------------------------------------------------

printSection "ALL DONE!"
