#!/bin/bash

# ---------------------------------------------------------------------------------------------------------------------

# Set script parts to run.
INITIALISE_PACKAGE_MANAGER=true
INSTALL_SYSTEM_PACKAGES=true
REMOVE_BLOATWARE=true
CLEANUP_PACKAGE_MANAGER=true

INSTALL_WEB_APPS=true
INSTALL_DESKTOP_APPS=true
INSTALL_SERVICES=true

INSTALL_EXTENSIONS=true
INSTALL_THEMES=true
INSTALL_ICONS=true
SETUP_APP_GRID=true
CONFIGURE_SHELL=true
CONFIGURE_TERMINAL=true
CONFIGURE_FILES=true
REMOVE_CONTENT_DIRECTORIES=true

MOUNT_NVME=true

INSTALL_GPU_DRIVERS=true

# ---------------------------------------------------------------------------------------------------------------------

clearTerminal()
{
	# Clear any debug command execution traps.
	trap - DEBUG
	trap

	# Refresh the command output.
	clear
	cat output.log
}

printText()
{
	# Ensure the terminal is reset to the default clean state.
	clearTerminal

	# Print the specified text.
	printf "%s\n" "$1" | tee -a output.log
}

printLine()
{
	# Ensure the terminal is reset to the default clean state.
	clearTerminal

	# Clear to the next line.
	echo "" | tee -a output.log

	# Loop 80 times to fill the terminal line character limit
	for i in {1..80}
	do
		# Print the tick message
		printf "%s" "-" | tee -a output.log

		# Add artificial slowness to make the script look good.
		sleep 0.005
	done

	# Clear to the next line.
	echo "" | tee -a output.log
}

printSection()
{
	# Ensure the terminal is reset to the default clean state.
	clearTerminal

	# Add artificial slowness to make the script look good.
	sleep 1

	# Get the title label and terminal size.
	TITLE=$1
	COLS=80

	# Print the title label.
	printLine

	echo "" | tee -a output.log
	printf "\e[1m\e[32m%*s\e[0m\n" $(((${#TITLE}+$COLS)/2)) "$TITLE" | tee -a output.log
	echo "" | tee -a output.log
}

printTitle()
{
	# Ensure the terminal is reset to the default clean state.
	clearTerminal

	# Add artificial slowness to make the script look good.
	sleep 1

	# Get the block label & function.
	LABEL=$1
	FUNCTION=$2
	COLS=80

	# Print the block label.
	echo "" | tee -a output.log
	printf "%*s\n" $(((${#LABEL}+$COLS)/2)) "$LABEL" | tee -a output.log
	echo "" | tee -a output.log
}

startRun()
{
	# Ensure the terminal is reset to the default clean state.
	clearTerminal

	# Get the command label and action.
	LABEL=$1

	# Print the command started message.
	echo -ne "$LABEL $(printf '%0.1s' " "{1..40})" | head -c 40 | tee -a output.log

	# Attempt to run each of the supplied commands.
	echo ""
	echo ""
	echo ""
	echo "--------------------------------------------------------------------------------"
	echo ""

	# Start trapping command execution to pretty print the command being run in green above the command output.
	trap 'echo -e "\n  \e[1m\e[32m$BASH_COMMAND\e[0m\n"' DEBUG
}

endRun()
{
	# Ensure the terminal is reset to the default clean state.
	clearTerminal

	# Print the command completed message.
	echo -e " \e[1m\e[32mDONE\e[0m" | tee -a output.log
}

requestAuthorisation()
{
	printLine
	echo "" | tee -a output.log
	sudo echo ""
}

# ---------------------------------------------------------------------------------------------------------------------

aptSetup()
{
	startRun "Update package list"
		sudo apt-get -y update
	endRun

	startRun "Download & install updates"
		sudo apt-get -y upgrade
	endRun

	startRun "Remove unused packages"
		sudo apt-get -y autoremove
	endRun

	startRun "Fix broken packages (if any)"
		sudo apt-get -y -f install
	endRun
}

aptCleanUp()
{
	startRun "Remove empty cache folders"
		rm -rf $HOME/.cache/chromium
		rm -rf $HOME/.cache/evolution
		rm -rf $HOME/.cache/mozilla
	endRun

	startRun "Remove empty config folders"
		rm -rf $HOME/.cache/chromium
		rm -rf $HOME/.cache/evolution
	endRun
}

uninstallAPT()
{
	startRun "$1"
		sudo apt-get -y -q purge --auto-remove $1
	endRun
}

installAPT()
{
	# Get the package ID.
	PACKAGE_ID=$1

	# Install the package
	startRun "$PACKAGE_ID"
		sudo apt-get -y install $PACKAGE_ID
	endRun
}

installWebApp()
{
	# Get the package ID & icon path.
	PACKAGE_ID=$1
	ICON_PATH=$HOME/.local/share/icons/hicolor

	# Install the web app package.
	startRun "$PACKAGE_ID"

		# Install 16px icon (if available).
		if [ -e "./webapps/$PACKAGE_ID/icons/16.png" ]; then
			mkdir -p $ICON_PATH/16x16/apps
			cp ./webapps/$PACKAGE_ID/icons/16.png $ICON_PATH/16x16/apps/$PACKAGE_ID.png
		fi

		# Install 32px icon (if available).
		if [ -e "./webapps/$PACKAGE_ID/icons/32.png" ]; then
			mkdir -p $ICON_PATH/32x32/apps
			cp ./webapps/$PACKAGE_ID/icons/32.png $ICON_PATH/32x32/apps/$PACKAGE_ID.png
		fi

		# Install 48px icon (if available).
		if [ -e "./webapps/$PACKAGE_ID/icons/48.png" ]; then
			mkdir -p $ICON_PATH/48x48/apps
			cp ./webapps/$PACKAGE_ID/icons/48.png $ICON_PATH/48x48/apps/$PACKAGE_ID.png
		fi

		# Install 64px icon (if available).
		if [ -e "./webapps/$PACKAGE_ID/icons/64.png" ]; then
			mkdir -p $ICON_PATH/64x64/apps
			cp ./webapps/$PACKAGE_ID/icons/64.png $ICON_PATH/64x64/apps/$PACKAGE_ID.png
		fi

		# Install 96px icon (if available).
		if [ -e "./webapps/$PACKAGE_ID/icons/96.png" ]; then
			mkdir -p $ICON_PATH/96x96/apps
			cp ./webapps/$PACKAGE_ID/icons/96.png $ICON_PATH/96x96/apps/$PACKAGE_ID.png
		fi

		# Install 128px icon (if available).
		if [ -e "./webapps/$PACKAGE_ID/icons/128.png" ]; then
			mkdir -p $ICON_PATH/128x128/apps
			cp ./webapps/$PACKAGE_ID/icons/128.png $ICON_PATH/128x128/apps/$PACKAGE_ID.png
		fi
		
		# Install 144px icon (if available).
		if [ -e "./webapps/$PACKAGE_ID/icons/144.png" ]; then
			mkdir -p $ICON_PATH/144x144/apps
			cp ./webapps/$PACKAGE_ID/icons/144.png $ICON_PATH/144x144/apps/$PACKAGE_ID.png
		fi

		# Install 192px icon (if available).
		if [ -e "./webapps/$PACKAGE_ID/icons/192.png" ]; then
			mkdir -p $ICON_PATH/192x192/apps
			cp ./webapps/$PACKAGE_ID/icons/192.png $ICON_PATH/192x192/apps/$PACKAGE_ID.png
		fi

		# Install 256px icon (if available).
		if [ -e "./webapps/$PACKAGE_ID/icons/256.png" ]; then
			mkdir -p $ICON_PATH/256x256/apps
			cp ./webapps/$PACKAGE_ID/icons/256.png $ICON_PATH/256x256/apps/$PACKAGE_ID.png
		fi

		# Install 512px icon (if available).
		if [ -e "./webapps/$PACKAGE_ID/icons/512.png" ]; then
			mkdir -p $ICON_PATH/512x512/apps
			cp ./webapps/$PACKAGE_ID/icons/512.png $ICON_PATH/512x512/apps/$PACKAGE_ID.png
		fi

		# Install the web app desktop manifest.
		cp ./webapps/$PACKAGE_ID/app.desktop $HOME/.local/share/applications/$PACKAGE_ID.desktop

	endRun
}

installDesktopApp()
{
	# Get the package ID.
	PACKAGE_ID=$1

	# Run the specified app install function.
	$PACKAGE_ID
}

installService()
{
	# Get the package ID.
	PACKAGE_ID=$1

	# Run the specified app install function.
	$PACKAGE_ID
}

installExtension()
{
	# Get the package ID.
	PACKAGE_ID=$1

	# Run the specified app install function.
	$PACKAGE_ID
}

installThemePack()
{
	# Get the package ID.
	PACKAGE_ID=$1

	# Run the specified app install function.
	$PACKAGE_ID
}

installIconPack()
{
	# Get the package ID.
	PACKAGE_ID=$1

	# Run the specified app install function.
	$PACKAGE_ID
}

setupAppGrid()
{
	startRun "Create app folders"
		gsettings set org.gnome.desktop.app-folders folder-children "['Development', 'Games', 'System', 'Utilities']"
	endRun

	startRun "Add apps to /Development"
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Development/ name ' Development '
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Development/ categories "[]"
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Development/ apps "['insomnia.desktop', 'code.desktop']"	
	endRun

	startRun "Add apps to /Games"
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Games/ name ' Games '
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Games/ categories "[]"
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Games/ apps "['minecraft-launcher.desktop', 'steam.desktop']"
	endRun

	startRun "Add apps to /System"
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/System/ name ' System '
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/System/ categories "[]"
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/System/ apps "['eog.desktop', 'org.gnome.SoundRecorder.desktop', 'org.gnome.Screenshot.desktop', 'org.gnome.Software.desktop', 'software-properties-gnome.desktop', 'org.gnome.gedit.desktop', 'org.gnome.Weather.Application.desktop', 'org.gnome.Documents.desktop', 'org.gnome.Evince.desktop', 'org.gnome.Contacts.desktop', 'org.gnome.Calendar.desktop', 'org.gnome.clocks.desktop', 'org.gnome.Nautilus.desktop']"
	endRun

	startRun "Add apps to /Utilities"
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Utilities/ name ' Utilities '
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Utilities/ categories "[]"
		gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Utilities/ apps "['uim.desktop', 'im-config.desktop', 'vinagre.desktop', 'seahorse.desktop', 'nvidia-settings.desktop', 'mlterm.desktop', 'org.gnome.Logs.desktop', 'gnome-system-monitor.desktop', 'org.gnome.Terminal.desktop', 'org.gnome.tweaks.desktop', 'org.gnome.DiskUtility.desktop', 'ca.desrt.dconf-editor.desktop', 'nm-connection-editor.desktop', 'org.gnome.FileRoller.desktop', 'org.gnome.Characters.desktop', 'org.gnome.font-viewer.desktop', 'fcitx-configtool.desktop', 'fcitx.desktop', 'org.gnome.baobab.desktop', 'gnome-control-center.desktop', 'yelp.desktop']"
	endRun

	startRun "Set app favourites"
		gsettings set org.gnome.shell favorite-apps "['org.gnome.Nautilus.desktop', 'gmail.desktop', 'calendar.desktop', 'keep.desktop', 'trello.desktop', 'drive.desktop', 'photos.desktop', 'youtube.desktop', 'google-chrome.desktop', 'code.desktop', 'org.gnome.Terminal.desktop', 'steam.desktop']"
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
}

configureTerminal()
{
	# Get terminal profile ID.
	TERMINAL_PROFILE=$(gsettings get org.gnome.Terminal.ProfilesList default)
	TERMINAL_PROFILE=${TERMINAL_PROFILE:1:-1} # remove leading and trailing single quotes

	# Run terminal customisations.
	startRun "Hide menu bar"
		gsettings set org.gnome.Terminal.Legacy.Settings default-show-menubar false
	endRun

	startRun "Apply dark theme"
		gsettings set org.gnome.Terminal.Legacy.Settings theme-variant dark
	endRun

	startRun "Dark grey background"
		gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$TERMINAL_PROFILE/ background-color "#2E3436"
	endRun

	startRun "Light-gray font"
		gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$TERMINAL_PROFILE/ foreground-color "#D3D7CF"
	endRun
}

configureFiles()
{
	startRun "Show location bar"
		gsettings set org.gnome.nautilus.preferences always-use-location-entry true
	endRun

	startRun "Double click to open"
		gsettings set org.gnome.nautilus.preferences click-policy double
	endRun

	startRun "Icon view"
		gsettings set org.gnome.nautilus.preferences default-folder-viewer icon-view
	endRun

	startRun "Show symlink button"
		gsettings set org.gnome.nautilus.preferences show-create-link true
	endRun
	
	startRun "Sort folders before files"
		gsettings set org.gtk.Settings.FileChooser sort-directories-first true
	endRun
}

removeContentDirectories()
{
	startRun "Activate desktop"
		xdg-user-dirs-update --set DESKTOP $HOME/Desktop
	endRun

	startRun "Remove content directories"
		xdg-user-dirs-update --set MUSIC $HOME/
		xdg-user-dirs-update --set PICTURES $HOME/
		xdg-user-dirs-update --set VIDEOS $HOME/
		rm -fd ~/Music
		rm -fd ~/Pictures
		rm -fd ~/Videos
	endRun
}

mountNVMEStorage()
{
	# Read the following to learn more:
	# https://www.linuxbabe.com/desktop-linux/how-to-automount-file-systems-on-linux
	
	# Set the drive to mount.
	MOUNT_NAME="nvme0n1p1"

	# Lookup the UUID & filesystem type for the automount drive.	
	NVME_UUID=$(sudo blkid -s UUID -o value /dev/$MOUNT_NAME)

	# Configure the FSTAB auto-mount entry.
	NVME_FSTAB="UUID=$NVME_UUID /mnt/$MOUNT_NAME    auto nosuid,nodev,nofail,x-gvfs-show 0 0"


	# Create a mounting point directory for the drive.
	startRun "Create mount point"
		sudo mkdir -p /mnt/$MOUNT_NAME
	endRun

	# Symlink the mounting point directory to the home folder.
	startRun "Adding mount to desktop folder"
		ln -s -f /mnt/$MOUNT_NAME/ $HOME/Desktop/Content
	endRun

	# Write the automount instruction for the drive to FSTAB.
	if ! grep -q "$NVME_FSTAB" /etc/fstab; then
		startRun "Write automount to FSTAB"
			echo "$NVME_FSTAB" | sudo tee -a /etc/fstab
		endRun
	else
		startRun "Automount exists in FSTAB"
			echo 0
		endRun
	fi
}

installNvidiaDrivers()
{
	# Read the following to learn more:
	# https://wiki.debian.org/NvidiaGraphicsDrivers
	# https://linuxusers.net/debian/how_install_debian_10_buster_with_nvidia.php#install_nvidia5

	startRun "Register package source"

		# Register the repositories containing NVidia drivers in app.
		sudo add-apt-repository non-free
		sudo add-apt-repository contrib
		
		# Refresh the APT package list.
		sudo apt-get -y update

		# Upgrade existing packages.
		sudo apt-get -y dist-upgrade

	endRun

	startRun "Install driver"
		sudo apt-get -fy install nvidia-driver
	endRun

	startRun "Verify driver"
		sudo apt-get install lshw
		sudo lshw -c display
	endRun
}

# ---------------------------------------------------------------------------------------------------------------------

desktopChrome()
{
	# Read the following to learn more:
	# https://www.itzgeek.com/how-tos/linux/debian/simple-way-to-install-google-chrome-on-debian-9.html

	startRun "Chrome"
		
		# Register the Google Chrome source repositories in APT.
		wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -v -
		echo deb http://dl.google.com/linux/chrome/deb/ stable main | sudo tee /etc/apt/sources.list.d/google-chrome.list
		
		# Refresh the APT package list.
		sudo apt-get -y update

		# Install the package.
		sudo apt-get -y install google-chrome-stable

	endRun
}

desktopDiscord()
{
	PACKAGE_URL="https://discordapp.com/api/download?platform=linux&format=deb"
	PACKAGE_PATH="packages/discord.deb"

	startRun "Discord"

		# Download the package installer if it was not pre-shipped with the script.
		if [ ! -f "$PACKAGE_PATH" ]; then
			wget $PACKAGE_URL -O $PACKAGE_PATH -q --show-progress
		fi
		
		# Install the package & it's dependencies.
		sudo dpkg -i $PACKAGE_PATH 2>&1
		sudo apt-get -y -f install

	endRun
}

desktopInsomnia()
{
	PACKAGE_URL="https://updates.insomnia.rest/downloads/ubuntu/latest"
	PACKAGE_PATH="packages/insomnia.deb"

	startRun "Insomnia"

		# Download the package installer if it was not pre-shipped with the script.
		if [ ! -f "$PACKAGE_PATH" ]; then
			wget $PACKAGE_URL -O $PACKAGE_PATH -q --show-progress
		fi
		
		# Install the package & it's dependencies.
		sudo dpkg -i $PACKAGE_PATH 2>&1
		sudo apt-get -y -f install

	endRun
}

desktopMinecraft()
{
	PACKAGE_URL="https://launcher.mojang.com/download/Minecraft.deb"
	PACKAGE_PATH="packages/minecraft.deb"

	startRun "Minecraft"

		# Download the package installer if it was not pre-shipped with the script.
		if [ ! -f "$PACKAGE_PATH" ]; then
			wget $PACKAGE_URL -O $PACKAGE_PATH -q --show-progress
		fi
		
		# Install the package & it's dependencies.
		sudo dpkg -i $PACKAGE_PATH 2>&1
		sudo apt-get -y -f install

	endRun
}

desktopSteam()
{
	# Read the following to learn more:
	# https://linuxconfig.org/how-to-install-steam-with-steam-play-on-debian-10-buster

	PACKAGE_URL="https://steamcdn-a.akamaihd.net/client/installer/steam.deb"
	PACKAGE_PATH="packages/steam.deb"

	startRun "Steam"

		# Download the package installer if it was not pre-shipped with the script.
		if [ ! -f "$PACKAGE_PATH" ]; then
			wget $PACKAGE_URL -O $PACKAGE_PATH -q --show-progress
		fi

		# Enable i386 packages (cus steam sucks).
		sudo dpkg --add-architecture i386

		# Refresh the APT package list.
		sudo apt-get -y update

		# Install package dependencies.
		sudo apt-get -y install libc6-i386
		sudo apt-get -y install libgl1-mesa-dri:i386
		sudo apt-get -y install libgl1-mesa-glx:i386
		
		# Install the package & it's dependencies.
		sudo dpkg -i $PACKAGE_PATH 2>&1
		sudo apt-get -y -f install
		
	endRun

}

desktopTeams()
{
	PACKAGE_URL="https://go.microsoft.com/fwlink/p/?linkid=2112886"
	PACKAGE_PATH="packages/teams.deb"

	startRun "Teams"

		# Download the package installer if it was not pre-shipped with the script.
		if [ ! -f "$PACKAGE_PATH" ]; then
			wget $PACKAGE_URL -O $PACKAGE_PATH -q --show-progress
		fi
		
		# Install the package & it's dependencies.
		sudo dpkg -i $PACKAGE_PATH 2>&1
		sudo apt-get -y -f install

	endRun
}

desktopVSCode()
{
	PACKAGE_URL="https://go.microsoft.com/fwlink/?LinkID=760868"
	PACKAGE_PATH="packages/vscode.deb"

	startRun "VSCode"

		# Download the package installer if it was not pre-shipped with the script.
		if [ ! -f "$PACKAGE_PATH" ]; then
			wget $PACKAGE_URL -O $PACKAGE_PATH -q --show-progress
		fi
		
		# Install the package & it's dependencies.
		sudo dpkg -i $PACKAGE_PATH 2>&1
		sudo apt-get -y -f install

		# Configure default settings
		mkdir -p $HOME/.config/Code/User
		cp ./settings/vscode.json $HOME/.config/Code/User/settings.json

	endRun
}

desktopGIMP()
{
	startRun "GIMP"
		
		# Install the package & it's dependencies.
		sudo apt-get -y install gimp

	endRun
}

desktopRaspberryPiImager()
{
	PACKAGE_URL="https://downloads.raspberrypi.org/imager/imager_amd64.deb"
	PACKAGE_PATH="packages/raspberryPiImager.deb"

	startRun "Raspberry Pi Imager"

		# Download the package installer if it was not pre-shipped with the script.
		if [ ! -f "$PACKAGE_PATH" ]; then
			wget $PACKAGE_URL -O $PACKAGE_PATH -q --show-progress
		fi
		
		# Install the package & it's dependencies.
		sudo dpkg -i $PACKAGE_PATH 2>&1
		sudo apt-get -y -f install

		# Configure default settings
		mkdir -p $HOME/.config/Code/User
		cp ./settings/vscode.json $HOME/.config/Code/User/settings.json

	endRun
}

# ---------------------------------------------------------------------------------------------------------------------

serviceGit()
{
	startRun "Git"
		sudo apt-get -y install git
	endRun
}

serviceNode()
{
	NODEREPO="node_14.x"

	startRun "Node"

		# Register the Node source repositories in APT.
		wget -q -O - https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add -
		echo deb https://deb.nodesource.com/${NODEREPO} buster main | sudo tee /etc/apt/sources.list.d/nodesource.list
		echo deb-src https://deb.nodesource.com/${NODEREPO} buster main | sudo tee -a /etc/apt/sources.list.d/nodesource.list
		
		# Refresh the APT package list.
		sudo apt-get -y update
		
		# Install the package.
		sudo apt-get -y install nodejs

	endRun
}

serviceNordvpn()
{
	# Read the following to learn more:
	# https://support.nordvpn.com/Connectivity/Linux/1325531132/Installing-and-using-NordVPN-on-Debian-Ubuntu-and-Linux-Mint.htm

	startRun "NordVPN"
		
		# Register the NordVPN source repositories in APT.
		wget -q -O - https://repo.nordvpn.com/gpg/nordvpn_public.asc | sudo apt-key add -
		echo deb https://repo.nordvpn.com/deb/nordvpn/debian stable main | sudo tee /etc/apt/sources.list.d/nordvpn.list
		
		# Refresh the APT package list.
		sudo apt-get -y update

		# Install the package.
		sudo apt-get -y install nordvpn

	endRun

}

# ---------------------------------------------------------------------------------------------------------------------

extensionDashToPanel()
{
	# Get the package ID and URL.
	PACKAGE_URL="https://extensions.gnome.org/extension-data/dash-to-paneljderose9.github.com.v35.shell-extension.zip"
	PACKAGE_PATH="extensions/dash-to-panel.zip"
	
	startRun "Dash to Panel"

		# Download the package installer if it was not pre-shipped with the script.
		if [ ! -f "$PACKAGE_PATH" ]; then
			wget $PACKAGE_URL -O $PACKAGE_PATH -q --show-progress
		fi

		# Lookup the extension UUID.
		EXTENSTION_UUID=$(unzip -c $PACKAGE_PATH metadata.json | grep uuid | cut -d \" -f4)

		# Extract the extension into Gnome shell.
		mkdir -p $HOME/.local/share/gnome-shell/extensions/$EXTENSTION_UUID
		unzip -q -o $PACKAGE_PATH -d $HOME/.local/share/gnome-shell/extensions/$EXTENSTION_UUID

		# Enable or reload the extension.
		gnome-shell-extension-tool -e $EXTENSTION_UUID || gnome-shell-extension-tool -r $EXTENSTION_UUID

		# Load the extension configuration into DConf.
		cat ./settings/dash-to-panel.conf | dconf load /org/gnome/shell/extensions/dash-to-panel/
	endRun
}

extensionArcMenu()
{
	# Get the package ID and URL.
	PACKAGE_URL="https://extensions.gnome.org/extension-data/arc-menulinxgem33.com.v42.shell-extension.zip"
	PACKAGE_PATH="extensions/arc-menu.zip"
	
	startRun "Arc Menu"

		# Download the package installer if it was not pre-shipped with the script.
		if [ ! -f "$PACKAGE_PATH" ]; then
			wget $PACKAGE_URL -O $PACKAGE_PATH -q --show-progress
		fi

		# Lookup the extension UUID.
		EXTENSTION_UUID=$(unzip -c $PACKAGE_PATH metadata.json | grep uuid | cut -d \" -f4)

		# Extract the extension into Gnome shell.
		mkdir -p $HOME/.local/share/gnome-shell/extensions/$EXTENSTION_UUID
		unzip -q -o $PACKAGE_PATH -d $HOME/.local/share/gnome-shell/extensions/$EXTENSTION_UUID

		# Enable or reload the extension.
		gnome-shell-extension-tool -e $EXTENSTION_UUID || gnome-shell-extension-tool -r $EXTENSTION_UUID

		# Load the extension configuration into DConf.
		cat ./settings/arc-menu.conf | dconf load /org/gnome/shell/extensions/arc-menu/

	endRun
}

extensionAppFolders()
{
	# Get the package ID and URL.
	PACKAGE_URL="https://extensions.gnome.org/extension-data/appfolders-managermaestroschan.fr.v16.shell-extension.zip"
	PACKAGE_PATH="extensions/app-folders.zip"
	
	startRun "App Folders"

		# Download the package installer if it was not pre-shipped with the script.
		if [ ! -f "$PACKAGE_PATH" ]; then
			wget $PACKAGE_URL -O $PACKAGE_PATH -q --show-progress
		fi

		# Lookup the extension UUID.
		EXTENSTION_UUID=$(unzip -c $PACKAGE_PATH metadata.json | grep uuid | cut -d \" -f4)

		# Extract the extension into Gnome shell.
		mkdir -p $HOME/.local/share/gnome-shell/extensions/$EXTENSTION_UUID
		unzip -q -o $PACKAGE_PATH -d $HOME/.local/share/gnome-shell/extensions/$EXTENSTION_UUID

		# Enable or reload the extension.
		gnome-shell-extension-tool -e $EXTENSTION_UUID || gnome-shell-extension-tool -r $EXTENSTION_UUID

	endRun
}

extensionStartOverlayInAppView()
{
	# Get the package ID and URL.
	PACKAGE_URL="https://extensions.gnome.org/extension-data/start-overlay-in-application-view%40cis.net.v2.shell-extension.zip"
	PACKAGE_PATH="extensions/start-overlay-in-app-view.zip"
	
	startRun "Start Overlay in App View"

		# Download the package installer if it was not pre-shipped with the script.
		if [ ! -f "$PACKAGE_PATH" ]; then
			wget $PACKAGE_URL -O $PACKAGE_PATH -q --show-progress
		fi

		# Lookup the extension UUID.
		EXTENSTION_UUID=$(unzip -c $PACKAGE_PATH metadata.json | grep uuid | cut -d \" -f4)

		# Extract the extension into Gnome shell.
		mkdir -p $HOME/.local/share/gnome-shell/extensions/$EXTENSTION_UUID
		unzip -q -o $PACKAGE_PATH -d $HOME/.local/share/gnome-shell/extensions/$EXTENSTION_UUID

		# Enable or reload the extension.
		gnome-shell-extension-tool -e $EXTENSTION_UUID || gnome-shell-extension-tool -r $EXTENSTION_UUID

	endRun
}

extensionEscapeToCloseOverlay()
{
	# Get the package ID and URL.
	PACKAGE_URL="https://extensions.gnome.org/extension-data/ESC_to_close_overview%40daniel.badawi.me.v3.shell-extension.zip"
	PACKAGE_PATH="extensions/escape-to-close-overlay.zip"
	
	startRun "Escape to Close Overlay"

		# Download the package installer if it was not pre-shipped with the script.
		if [ ! -f "$PACKAGE_PATH" ]; then
			wget $PACKAGE_URL -O $PACKAGE_PATH -q --show-progress
		fi

		# Lookup the extension UUID.
		EXTENSTION_UUID=$(unzip -c $PACKAGE_PATH metadata.json | grep uuid | cut -d \" -f4)

		# Extract the extension into Gnome shell.
		mkdir -p $HOME/.local/share/gnome-shell/extensions/$EXTENSTION_UUID
		unzip -q -o $PACKAGE_PATH -d $HOME/.local/share/gnome-shell/extensions/$EXTENSTION_UUID

		# Enable or reload the extension.
		gnome-shell-extension-tool -e $EXTENSTION_UUID || gnome-shell-extension-tool -r $EXTENSTION_UUID

	endRun
}

extensionShowDesktopIcons()
{
	# Get the package ID and URL.
	PACKAGE_URL="https://extensions.gnome.org/extension-data/desktop-iconscsoriano.v15.shell-extension.zip"
	PACKAGE_PATH="extensions/show-desktop-icons.zip"
	
	startRun "Show Desktop Icons"

		# Download the package installer if it was not pre-shipped with the script.
		if [ ! -f "$PACKAGE_PATH" ]; then
			wget $PACKAGE_URL -O $PACKAGE_PATH -q --show-progress
		fi

		# Lookup the extension UUID.
		EXTENSTION_UUID=$(unzip -c $PACKAGE_PATH metadata.json | grep uuid | cut -d \" -f4)

		# Extract the extension into Gnome shell.
		mkdir -p $HOME/.local/share/gnome-shell/extensions/$EXTENSTION_UUID
		unzip -q -o $PACKAGE_PATH -d $HOME/.local/share/gnome-shell/extensions/$EXTENSTION_UUID

		# Enable or reload the extension.
		gnome-shell-extension-tool -e $EXTENSTION_UUID || gnome-shell-extension-tool -r $EXTENSTION_UUID

	endRun
}

extensionNordvpnStatus()
{
	# Get the package ID and URL.
	PACKAGE_URL="https://extensions.gnome.org/extension-data/nordvpn_statusjcmartinez.dev.v5.shell-extension.zip"
	PACKAGE_PATH="extensions/nordvpn-status.zip"
	
	startRun "NordVPN Status"

		# Download the package installer if it was not pre-shipped with the script.
		if [ ! -f "$PACKAGE_PATH" ]; then
			wget $PACKAGE_URL -O $PACKAGE_PATH -q --show-progress
		fi

		# Lookup the extension UUID.
		EXTENSTION_UUID=$(unzip -c $PACKAGE_PATH metadata.json | grep uuid | cut -d \" -f4)

		# Extract the extension into Gnome shell.
		mkdir -p $HOME/.local/share/gnome-shell/extensions/$EXTENSTION_UUID
		unzip -q -o $PACKAGE_PATH -d $HOME/.local/share/gnome-shell/extensions/$EXTENSTION_UUID

		# Enable or reload the extension.
		gnome-shell-extension-tool -e $EXTENSTION_UUID || gnome-shell-extension-tool -r $EXTENSTION_UUID

	endRun
}

# ---------------------------------------------------------------------------------------------------------------------

themeVimix()
{
	# Get the package ID and URL.
	PACKAGE_ID="vimix-gtk-themes"
	PACKAGE_VERSION="2020-02-24"

	ACTIVE_SET="vimix-doder"

	PACKAGE_URL="https://codeload.github.com/vinceliuice/$PACKAGE_ID/zip/$PACKAGE_VERSION"
	PACKAGE_PATH="themes/$PACKAGE_ID.zip"

	startRun "Vimix"

		# Download the package installer if it was not pre-shipped with the script.
		if [ ! -f "$PACKAGE_PATH" ]; then
			wget $PACKAGE_URL -O $PACKAGE_PATH -q --show-progress
		fi

		# Extract the theme package.
		unzip -q -o $PACKAGE_PATH -d themes/$PACKAGE_ID

		# Install the theme package.
		./themes/$PACKAGE_ID/$PACKAGE_ID-$PACKAGE_VERSION/install.sh

		# Activate the theme.
		gsettings set org.gnome.desktop.interface gtk-theme $ACTIVE_SET

		# Remove the extracted source folder.
		rm -r themes/$PACKAGE_ID

	endRun
}

# ---------------------------------------------------------------------------------------------------------------------

iconsPapirus()
{
	# Get the package ID and URL.
	PACKAGE_ID="papirus-icon-theme"
	PACKAGE_VERSION="20200405"
	
	ACTIVE_SET="Papirus"

	PACKAGE_URL="https://codeload.github.com/PapirusDevelopmentTeam/$PACKAGE_ID/zip/$PACKAGE_VERSION"
	PACKAGE_PATH="icons/$PACKAGE_ID.zip"

	startRun "Papirus"

		# Download the package installer if it was not pre-shipped with the script.
		if [ ! -f "$PACKAGE_PATH" ]; then
			wget $PACKAGE_URL -O $PACKAGE_PATH -q --show-progress
		fi

		# Extract the icons package.
		unzip -q -o $PACKAGE_PATH -d icons/$PACKAGE_ID

		# Install the icons package.
		./icons/$PACKAGE_ID/$PACKAGE_ID-$PACKAGE_VERSION/install.sh

		# Activate the icon set.
		gsettings set org.gnome.desktop.interface icon-theme $ACTIVE_SET

		# Remove the extracted source folder.
		rm -r icons/$PACKAGE_ID

	endRun
}

# ---------------------------------------------------------------------------------------------------------------------

# Stop the script if we encounter an error.
set -e

# Create a new output log, removing any previous version.
rm -f output.log
touch output.log
clear

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

printSection "Setup Package Manager"

if [ $INITIALISE_PACKAGE_MANAGER = true ]; then

	printTitle "Ensure Everything is Setup Correctly"

	aptSetup

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

	installDesktopApp "desktopChrome"
	installDesktopApp "desktopDiscord"
	installDesktopApp "desktopInsomnia"
	installDesktopApp "desktopMinecraft"
	installDesktopApp "desktopSteam"
	installDesktopApp "desktopTeams"
	installDesktopApp "desktopVSCode"
	installDesktopApp "desktopGIMP"
	installDesktopApp "desktopRaspberyPiImager"
fi

if [ $INSTALL_SERVICES = true ]; then

	printTitle "Sevices"

	installService "serviceGit"
	installService "serviceNode"
	installService "serviceNordvpn"
fi

# ---------------------------------------------------------------------------------------------------------------------

printSection "Make things look pretty"

if [ $INSTALL_EXTENSIONS = true ]; then

	printTitle "Install Extensions"

	installExtension "extensionDashToPanel"
	installExtension "extensionArcMenu"
	installExtension "extensionAppFolders"
	installExtension "extensionShowDesktopIcons"
	installExtension "extensionStartOverlayInAppView"
	installExtension "extensionEscapeToCloseOverlay"
	installExtension "extensionNordvpnStatus"
fi

if [ $INSTALL_THEMES = true ]; then

	printTitle "Install Themes"

	installThemePack "themeVimix"
fi


if [ $INSTALL_ICONS = true ]; then

	printTitle "Install Icon Sets"

	installIconPack "iconsPapirus"
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