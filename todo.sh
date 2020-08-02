# Set GIT user

git config --global user.name "First Last"
git config --global user.email "example@example.com"


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


