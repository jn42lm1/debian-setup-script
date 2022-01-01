#!/bin/bash

source $(dirname $0)/common.sh
source $(dirname $0)/packages.sh

# ---------------------------------------------------------------------------------------------------------------------

# Set script parts to run.
INITIALISE_PACKAGE_MANAGER=true
INSTALL_SYSTEM_PACKAGES=true
REMOVE_BLOATWARE=true
CLEANUP_PACKAGE_MANAGER=true

INSTALL_WEB_APPS=false
INSTALL_DESKTOP_APPS=false
INSTALL_SERVICES=false

INSTALL_EXTENSIONS=true
INSTALL_THEMES=true
INSTALL_ICONS=true
SETUP_APP_GRID=true
CONFIGURE_SHELL=true
REMOVE_CONTENT_DIRECTORIES=true

MOUNT_NVME=false

INSTALL_GPU_DRIVERS=false

# ---------------------------------------------------------------------------------------------------------------------

setupAppGrid()
{
	startRun "Create app folders"
		gsettings set org.gnome.desktop.app-folders folder-children "['Development', 'Games', 'Creative', 'Office', 'System', 'Utilities']"
	endRun

	startRun "Add apps to /Development"
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Development/ name ' Development '
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Development/ categories "[]"
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Development/ apps "['android-studio.desktop', 'insomnia.desktop', 'code.desktop', 'omnidb-app.desktop', 'mongodb-compass.desktop', 'rpi-imager.desktop', 'jetbrains-studio.desktop', 'code_code.desktop', 'rpi-imager_rpi-imager.desktop']"
	endRun

	startRun "Add apps to /Games"
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Games/ name ' Games '
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Games/ categories "[]"
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Games/ apps "['minecraft-launcher.desktop', 'steam.desktop']"
	endRun

	startRun "Add apps to /Graphics"
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Creative/ name ' Creative '
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Creative/ categories "[]"
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Creative/ apps "['inkscape.desktop', 'drawio.desktop', 'pinta-james-carroll_pinta.desktop', 'vectr_vectr.desktop', 'inkscape_inkscape.desktop', 'gimp_gimp.desktop', 'drawio_drawio.desktop']"
	endRun

	startRun "Add apps to /Office"
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Office/ name ' Office '
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Office/ categories "[]"
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Office/ apps "['libreoffice_base.desktop', 'libreoffice_calc.desktop', 'libreoffice_draw.desktop', 'libreoffice_impress.desktop', 'libreoffice_math.desktop', 'libreoffice_writer.desktop', 'libreoffice-base.desktop', 'libreoffice_libreoffice.desktop']"
	endRun

	startRun "Add apps to /System"
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/System/ name ' System '
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/System/ categories "[]"
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/System/ apps "['eog.desktop', 'org.gnome.SoundRecorder.desktop', 'org.gnome.Screenshot.desktop', 'org.gnome.Software.desktop', 'software-properties-gnome.desktop', 'org.gnome.gedit.desktop', 'org.gnome.Weather.Application.desktop', 'org.gnome.Documents.desktop', 'org.gnome.Evince.desktop', 'org.gnome.Contacts.desktop', 'org.gnome.Calendar.desktop', 'org.gnome.clocks.desktop', 'org.gnome.Nautilus.desktop', 'snap-store_snap-store.desktop']"
	endRun

	startRun "Add apps to /Utilities"
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Utilities/ name ' Utilities '
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Utilities/ categories "[]"
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Utilities/ apps "['uim.desktop', 'im-config.desktop', 'vinagre.desktop', 'seahorse.desktop', 'nvidia-settings.desktop', 'mlterm.desktop', 'org.gnome.Logs.desktop', 'gnome-system-monitor.desktop', 'org.gnome.Terminal.desktop', 'org.gnome.tweaks.desktop', 'org.gnome.DiskUtility.desktop', 'ca.desrt.dconf-editor.desktop', 'nm-connection-editor.desktop', 'org.gnome.FileRoller.desktop', 'org.gnome.Characters.desktop', 'org.gnome.font-viewer.desktop', 'fcitx-configtool.desktop', 'fcitx.desktop', 'org.gnome.baobab.desktop', 'gnome-control-center.desktop', 'yelp.desktop']"
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
		gsettings set org.gnome.desktop.interface clock-show-date true
	endRun

	startRun "Show minimize/maximise buttons"
		gsettings set org.gnome.desktop.wm.preferences button-layout appmenu:minimize,maximize,close
	endRun

	startRun "Set background"
		gsettings set org.gnome.desktop.background picture-options zoom
		gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/gnome/Icescape.jpg
		gsettings set org.gnome.desktop.background primary-color "#ffffff"
		gsettings set org.gnome.desktop.background secondary-color "#000000"
	endRun

	startRun "Set screensaver"
		gsettings set org.gnome.desktop.screensaver picture-options zoom
		gsettings set org.gnome.desktop.screensaver picture-uri file:///usr/share/backgrounds/gnome/Icescape.jpg
		gsettings set org.gnome.desktop.screensaver primary-color "#ffffff"
		gsettings set org.gnome.desktop.screensaver secondary-color "#000000"
	endRun
	
	# Get terminal profile ID.
	TERMINAL_PROFILE=$(gsettings get org.gnome.Terminal.ProfilesList default)
	TERMINAL_PROFILE=${TERMINAL_PROFILE:1:-1} # remove leading and trailing single quotes

	startRun "Configure terminal"
		dconf write /org/gnome/terminal/legacy/theme-variant "'dark'"

		gsettings set org.gnome.Terminal.Legacy.Settings default-show-menubar false # Hide menu bar
		gsettings set org.gnome.Terminal.Legacy.Settings theme-variant dark # Apply dark theme
		gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$TERMINAL_PROFILE/ background-color "#2E3436" # Dark grey background
		gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$TERMINAL_PROFILE/ foreground-color "#D3D7CF" # Light-gray font
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
printText "                  ██████╗ ███████╗██████╗ ██╗ █████╗ ███╗   ██╗                 "
printText "                  ██╔══██╗██╔════╝██╔══██╗██║██╔══██╗████╗  ██║                 "
printText "                  ██║  ██║█████╗  ██████╔╝██║███████║██╔██╗ ██║                 "
printText "                  ██║  ██║██╔══╝  ██╔══██╗██║██╔══██║██║╚██╗██║                 "
printText "                  ██████╔╝███████╗██████╔╝██║██║  ██║██║ ╚████║                 "
printText "                  ╚═════╝ ╚══════╝╚═════╝ ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝                 "
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

	uninstallAPT "firefox-esr"
	uninstallAPT "chromium"
	uninstallAPT "debian-reference-common"
	uninstallAPT "evolution"
	uninstallAPT "libreoffice-common"
	uninstallAPT "lightsoff"
	uninstallAPT "khmerconverter"
	uninstallAPT "aisleriot"
	uninstallAPT "anthy"
	uninstallAPT "kasumi"
	uninstallAPT "five-or-more"
	uninstallAPT "four-in-a-row"
	uninstallAPT "goldendict"
	uninstallAPT "hitori"
	uninstallAPT "iagno"
	uninstallAPT "gnome-chess"
	uninstallAPT "gnome-klotski"
	uninstallAPT "gnome-mahjongg"
	uninstallAPT "gnome-maps"
	uninstallAPT "gnome-music"
	uninstallAPT "gnome-mines"
	uninstallAPT "gnome-nibbles"
	uninstallAPT "gnome-robots"
	uninstallAPT "gnome-taquin"
	uninstallAPT "gnome-tetravex"
	uninstallAPT "gnome-sudoku"
	uninstallAPT "gnome-todo"
	uninstallAPT "mozc-utils-gui"
	uninstallAPT "mozc-data"
	uninstallAPT "mozc-server"
	uninstallAPT "mlterm"
	uninstallAPT "quadrapassel"
	uninstallAPT "rhythmbox"
	uninstallAPT "shotwell"
	uninstallAPT "simple-scan"
	uninstallAPT "swell-foop"
	uninstallAPT "tali"
	uninstallAPT "thunderbird"
	uninstallAPT "transmission-gtk"
	uninstallAPT "xterm"
	uninstallAPT "xiterm+thai"
	uninstallAPT "totem"
	uninstallAPT "hdate-applet"
	uninstallAPT "vim-common"
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
	installPackage "desktopSnapStore"
	installPackage "desktopLibreOffice"
	
	installPackage "desktopDiscord"
	installPackage "desktopTeams"
	
	installPackage "desktopDrawIO"
	installPackage "desktopInkscape"
	installPackage "desktopGIMP"
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
	installPackage "serviceNordvpn"
fi

# ---------------------------------------------------------------------------------------------------------------------

printSection "Make Things Look Pretty"

if [ $INSTALL_EXTENSIONS = true ]; then

	printTitle "Install Extensions"

	installPackage "extensionDashToPanel"
	installPackage "extensionArcMenu"
	installPackage "extensionAppFolders"
	installPackage "extensionShowDesktopIcons"
	installPackage "extensionStartOverlayInAppView"
	installPackage "extensionEscapeToCloseOverlay"
	installPackage "extensionNordvpnStatus"
fi

if [ $INSTALL_THEMES = true ]; then

	printTitle "Install Themes"

	installPackage "themeVimix"
fi

if [ $INSTALL_ICONS = true ]; then

	printTitle "Install Icon Sets"

	installPackage "iconsPapirus"
fi

if [ $SETUP_APP_GRID = true ]; then

	printTitle "Setup App Grid"

	setupAppGrid
fi

if [ $CONFIGURE_SHELL = true ]; then

	printTitle "Configure Shell"

	configureShell
fi

if [ $CONFIGURE_TERMINAL = true ]; then

	printTitle "Configure Terminal App"

	configureTerminal
fi

if [ $CONFIGURE_FILES = true ]; then

	printTitle "Configure Files App"

	configureFiles
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

	installNvidiaDrivers
fi

# ---------------------------------------------------------------------------------------------------------------------

printSection "ALL DONE!"
