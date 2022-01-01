#!/bin/bash

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

snapSetup()
{
	startRun "Install Snap CLI"
		sudo apt install snapd
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

installPackage()
{
	# Get the package ID.
	PACKAGE_ID=$1

	# Run the specified app install function.
	$PACKAGE_ID
}

# ---------------------------------------------------------------------------------------------------------------------

removeContentDirectories()
{
	startRun "Activate desktop"
		xdg-user-dirs-update --set DESKTOP $HOME/Desktop
	endRun

	startRun "Remove content directories"
		xdg-user-dirs-update --set MUSIC $HOME/
		xdg-user-dirs-update --set PICTURES $HOME/
		xdg-user-dirs-update --set VIDEOS $HOME/
		rm -fd $HOME/Music
		rm -fd $HOME/Pictures
		rm -fd $HOME/Videos
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

# Stop the script if we encounter an error.
set -e

# Create a new output log, removing any previous version.
rm -f output.log
touch output.log
clear