#!/bin/bash

# ---------------------------------------------------------------------------------------------------------------------

desktopAndroidStudio()
{
# 	PACKAGE_URL="https://redirector.gvt1.com/edgedl/android/studio/ide-zips/4.1.1.0/android-studio-ide-201.6953283-linux.tar.gz"
# 	PACKAGE_PATH="./packages/android-studio.deb"

# 	startRun "Android Studio"

# 		# Download the package installer if it was not pre-shipped with the script.
# 		if [ ! -f "$PACKAGE_PATH" ]; then
# 			wget $PACKAGE_URL -O $PACKAGE_PATH -q --show-progress
# 		fi
		
# 		# Install the package & it's dependencies.
# 		sudo tar -xf $PACKAGE_PATH -C /opt

# 		# Create a manual desktop icon for Android Studio.
# 		cat > $HOME/.local/share/applications/android-studio.desktop <<EOL
# [Desktop Entry]
# Version=1.0
# Type=Application
# Name=Android Studio
# Icon=/opt/android-studio/bin/studio.svg
# Exec="/opt/android-studio/bin/studio.sh" %f
# Comment=The Drive to Develop
# Categories=Development;IDE;
# Terminal=false
# StartupWMClass=jetbrains-studio
# Name[en_GB]=android-studio.desktop
# ...
# EOL

# 		# Set path variable for Android Studio.
# 		cp ./settings/.profile $HOME/.profile

# 	endRun

	startRun "Android Studio"
		sudo snap install android-studio --classic
	endRun
}

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
	startRun "Discord"
		flatpak install -y flathub com.discordapp.Discord
	endRun
}

desktopDrawIO()
{
	startRun "Draw.io"
		sudo snap install drawio
	endRun
}

desktopGIMP()
{
	startRun "GIMP"
		sudo snap install gimp
	endRun
}

desktopInkscape()
{
	startRun "Inkscape"
		sudo snap install inkscape
	endRun
}

desktopInsomnia()
{
	startRun "Insomnia"
		sudo snap install insomnia
	endRun
}

desktopLibreOffice()
{
	startRun "Libre Office"
		sudo snap install libreoffice
	endRun
}

desktopMinecraft()
{
	PACKAGE_URL="https://launcher.mojang.com/download/Minecraft.deb"
	PACKAGE_PATH="./packages/minecraft.deb"

	startRun "Minecraft"

		# Download the package installer if it was not pre-shipped with the script.
		if [ ! -f "$PACKAGE_PATH" ]; then
			wget $PACKAGE_URL -O $PACKAGE_PATH -q --show-progress
		fi
		
		# Install the package & it's dependencies.
		sudo apt-get -y install $PACKAGE_PATH

	endRun
}

desktopMongoDBCompass()
{
	PACKAGE_URL="https://downloads.mongodb.com/compass/mongodb-compass_1.29.6_amd64.deb"
	PACKAGE_PATH="./packages/mongodb-compass.deb"

	startRun "MongoDB Compass"

		# Download the package installer if it was not pre-shipped with the script.
		if [ ! -f "$PACKAGE_PATH" ]; then
			wget $PACKAGE_URL -O $PACKAGE_PATH -q --show-progress
		fi
		
		# Install the package & it's dependencies.
		sudo apt-get -y install $PACKAGE_PATH

	endRun
}

desktopPeek()
{
	startRun "Peek"
		flatpak install -y flathub com.uploadedlobster.peek
	endRun
}

desktopPinta()
{
	startRun "Pinta"
		flatpak install -y flathub com.github.PintaProject.Pinta
	endRun
}

desktopRaspberryPiImager()
{
	startRun "Raspberry Pi Imager"
		flatpak install -y flathub org.raspberrypi.rpi-imager
	endRun
}

desktopSnapStore()
{
	startRun "Snap Store"
		sudo snap install snap-store
	endRun
}

desktopSteam()
{
	# Read the following to learn more:
	# https://linuxconfig.org/how-to-install-steam-with-steam-play-on-debian-10-buster

	PACKAGE_URL="https://steamcdn-a.akamaihd.net/client/installer/steam.deb"
	PACKAGE_PATH="./packages/steam.deb"

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
		sudo apt-get -y install $PACKAGE_PATH
		
	endRun
}

desktopTeams()
{
	startRun "Teams"
		sudo snap install teams
	endRun
}

desktopVectr()
{
	startRun "Vectr"
		sudo snap install vectr
	endRun
}

desktopVSCode()
{
	startRun "VSCode"
		sudo snap install code --classic
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
	NODEREPO="node_17.x"
	DISTRO="$(lsb_release -s -c)"

	startRun "Node"

		# Register the Node source repositories in APT.
		wget -q -O - https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add -
		echo deb https://deb.nodesource.com/${NODEREPO} ${DISTRO} main | sudo tee /etc/apt/sources.list.d/nodesource.list
		echo deb-src https://deb.nodesource.com/${NODEREPO} ${DISTRO} main | sudo tee -a /etc/apt/sources.list.d/nodesource.list
		
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
	PACKAGE_URL="https://extensions.gnome.org/extension-data/dash-to-paneljderose9.github.com.v40.shell-extension.zip"
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
		echo $EXTENSTION_UUID
		gnome-shell-extension-tool -e $EXTENSTION_UUID || gnome-shell-extension-tool -r $EXTENSTION_UUID

		# Load the extension configuration into DConf.
		cat ./settings/dash-to-panel.conf | dconf load /org/gnome/shell/extensions/dash-to-panel/
	endRun
}

extensionArcMenu()
{
	# Get the package ID and URL.
	PACKAGE_URL="https://extensions.gnome.org/extension-data/arc-menulinxgem33.com.v49.shell-extension.zip"
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
	PACKAGE_URL="https://extensions.gnome.org/extension-data/nordvpn_statusjcmartinez.dev.v7.shell-extension.zip"
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