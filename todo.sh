# Set GIT user

git config --global user.name "First Last"
git config --global user.email "example@example.com"

# Get ESO to work

	# manually - run this, then enable the mozilla/twathe certificates
	sudo dpkg-reconfigure ca-certificates 

	# automated
	# maybe need to run this (unsure): sudo dpkg -i ca-certificates_20190110_all.deb
	sudo nano /etc/ca-certificates.conf
	#remove ! from all 3 the mozilla/thawte certificate lines
	#custom/thawte_Primary_Root_CA.crt
	#custom/thawte_Primary_Root_CA_-_G2.crt
	#custom/thawte_Primary_Root_CA_-_G3.crt
	sudo update-ca-certificates
	#disable esync launch variable?
	#proton version 4?

sudo cp -r certificates/custom /usr/share/ca-certificates

sudo nano /etc/ca-certificates.conf
#add these 3 lines
#custom/thawte_Primary_Root_CA.crt
#custom/thawte_Primary_Root_CA_-_G2.crt
#custom/thawte_Primary_Root_CA_-_G3.crt

sudo update-ca-certificates


#
# Speed up boot-loader
#

#https://mike42.me/blog/how-to-boot-debian-in-4-seconds

#https://askubuntu.com/questions/1013830/slow-boot-long-kernel-load-time-due-to-wrong-resume-device

#/etc/initramfs-tools/conf.d/resume
#resume=none
#sudo bash -c 'mv /etc/initramfs-tools/conf.d/resume /tmp/resume.bak; echo RESUME=$(blkid | \grep -I swap | head -n 1 | cut -d : -f 1) > /etc/initramfs-tools/conf.d/resume'


#sudo update-initramfs -u


#
# Add boot-loader skin
#

#https://wiki.debian.org/plymouth
#https://www.gnome-look.org/p/1236548/

#sudo apt-get -y install plymouth plymouth-themes
#sudo plymouth-set-default-theme -R lines

#/etc/initramfs-tools/modules
#drm
#nouveau modeset=1

#/etc/default/grub 
#GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
#GRUB_GFXMODE=1024x768

#sudo update-grub2


