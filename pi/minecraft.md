# Host a local Minecraft Server on a Raspberry PI

Follow these instructions to setup a Raspberry PI as a Minecraft Server, which can be made optionally accessible over the Internet via port forwarding to play with friends remotely.

Prerequisites:
1. Debian linux machine - to setup and manage the PI remotely.
2. Raspberry PI 3 or higher - to run the server
3. Screen with HMDI - to logon to the PI directly.
4. 16 Micro SD card - to write Raspberry PI OS onto.
5. SD card writer dongle (or port) on the PC - to write Rasberry PI OS to the PI.
6. 2 x Network cables to connect both the PI and PC to your router.
7. Router - Access to a router to setup port forwarding - to access the server over Internet.

For more info refer to these tutorials:
- https://linuxize.com/post/how-to-install-minecraft-server-on-raspberry-pi/



## 1. Getting Started

1. Install Rasberry PI Imager onto your PC (if not already installed).
```bash
wget https://downloads.raspberrypi.org/imager/imager_amd64.deb -O raspberryPiImager.deb -q --show-progress

sudo dpkg -i raspberryPiImager.deb

sudo apt-get -y -f install
```

2. Flash the latest Raspeberry PI OS onto an Micro SD card using the Raspberry PI Imager app.

3. Insert the Micro SD card into the PI and boot up.

4. Login with default credentials.
```
login: pi
password: raspberry
```

5. Ensure all APT package are up to date.
```bash
sudo apt update
```


6. Enter the PI configation manager.
```bash
sudo raspi-config
```

7. Setup the GL Driver by selecting the following options.
```
7 Advanced Options
A8 GL Driver
G2 GL (Fake KMS)
Finish
Reboot
```

8. Login again after reboot.


## 2. Install Dependencies

1. Minecraft needs the latest version of Java to run. Check the latest version number here and install from apt as follows: https://www.java.com/en/download/linux_manual.jsp
```bash
sudo apt-get install -y openjdk-8-jdk-headless
```

2. To compile the Minecraft remote management console we'll need to install the GIT command line interface to download the source code and the C compliers to build the source.
```bash
sudo apt install -y git
sudo apt install -y build-essential
```


## 2. Configure Static IP Address

1. Open the PI's network config file
```bash
sudo nano /etc/dhcpcd.conf
```

2. Copy the following config block to the bottom of the config file in Nano. . 
```bash
# Set PI to run on static IP address.
interface eth0
static ip_address=192.168.0.4/24
static routers=192.168.0.1
static domain_name_servers=192.168.0.1
```

3. Replace the IP address value with your prefered IP address to take on the local nework (keep the /24)

4. Replace & routers DNS values with the IP address of your router.

5. Save and exit Nano.
```
CTRL+S
CTRL+Z
```

6. Reboot the PI and login again.
```bash
reboot
```


## 3. Setup Service Account

1. Create a service account user for Minecraft to run under.
```bash
sudo useradd -r -m -U -d /opt/minecraft -s /bin/bash minecraft
```

2. Switch to the new service user account
```bash
sudo su - minecraft
```


## 4. Install MCrcon Server Management Console

1. Navigate to the user root folder.
```bash
cd ~/
```

1. Download the source code for the management console from GitHub.
```bash
git clone https://github.com/Tiiffi/mcrcon.git
```

2. Navigate to the source folder.
```bash
cd mcrcon
```

3. Compile the source files into an executable.
```bash
gcc -std=gnu11 -pedantic -Wall -Wextra -O2 -s -o mcrcon mcrcon.c
```


## 5. Install Mincraft Server

1. Navigate to the user root folder.
```bash
cd ~/
```

2. Create an empty folder in the PI home directory for the Minecraft Sever files.
```bash
mkdir minecraft_server
cd minecraft_server
```

3. Download the latest install file for Minecraft server. Get the download URL from here: https://www.minecraft.net/en-us/download/server
```bash
wget <minecraft_server_url> -O server.jar -q --show-progress
```

4. Launch the Minecraft server for the first time, this will generate the game configurations file locally and give you a warning to accept the EULA agreement before running again.
```bash
java -Xmx1024M -Xms1024M -jar server.jar nogui
```

5. Accept the EULA agreement by editing the EULA configuration file in the Minecraft server folder.
```bash
nano eula.txt
```

6. Change the eula=false line in the file to true.
```
eula=true
```

7. Save and exit Nano.
```
CTRL+S
CTRL+Z
```

8. Enable the remote management console by editing the server configuration file.
```bash
nano server.properties
```

9. Update the following values:
```
rcon.port=25575
rcon.password=strong-password
enable-rcon=true
```

10. Save and exit Nano.
```
CTRL+S
CTRL+Z
```



```bash
sudo nano /etc/systemd/system/minecraft.service
```


```
[Unit]
Description=Minecraft Server
After=network.target

[Service]
User=minecraft
Nice=1
KillMode=none
SuccessExitStatus=0 1
ProtectHome=true
ProtectSystem=full
PrivateDevices=true
NoNewPrivileges=true
WorkingDirectory=/opt/minecraft/minecraft_server
ExecStart=/usr/bin/java -Xmx1024M -Xms768M -jar server.jar nogui
ExecStop=/opt/minecraft/mcrcon/mcrcon -H 127.0.0.1 -P 25575 -p strong-password stop

[Install]
WantedBy=multi-user.target
```

Save and close the file and reload the systemd configuration:

sudo systemctl daemon-reload
Start the Minecraft server by issuing:

sudo systemctl start minecraft
Check the service status with the following command:

sudo systemctl status minecraft

The first time you start the service, it will generate several configuration files and directories, including the Minecraft world. Use the tail command to monitor the server log file:

tail -f /opt/minecraft/server/logs/latest.log


Enable the Minecraft service to start at boot time automatically:

sudo systemctl enable minecraft








Accessing Minecraft Console
To access the Minecraft Console use the mcrcon utility. You need to specify the host, rcon port, rcon password and use the -t switch which enables the mcrcon terminal mode:

/opt/minecraft/tools/mcrcon/mcrcon -H 127.0.0.1 -P 25575 -p strong-password -t






## 3. Install usefull minecraft server plugins (Optional)























## 4. Enable remote access to the PI (optional)

1. Enable SSH on the Raspberry PI.
```bash
cd /boot
touch ssh
```

2. Reboot the PI.
```bash
reboot
```

3. Connect to the PI from your PC using SSH, then follow the rest of the instructions below within this SSH session.
```bash
ssh pi@<pi_ip_address>
```









## 5. Make Server Accessible Over Internet (optional - at own risk)

1. Protect the PI by changing the login creditials.
```bash

```

2. Disable SSH
```bash
cd /boot
sudo rm ssh
```

3. Reboot the PI.
```bash
sudo reboot
```

4. Log onto the router web console via a browser, e.g. typically 192.168.0.1 as the URL, then configure port forwarding to the static Raspberry PI IP address on port XXX. Steps may vary depending on the router make and model, more info here:
```

```