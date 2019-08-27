#!/bin/bash

echo "Atualizando repositorios"
apt-get update 
echo "Atualizando pacotes instalados"
apt-get upgrade -y
#echo "Pacotes atualizados"

echo "Instalacao dos pacotes"
apt-get install -y goldendict python-matplotlib vim pdftk ispell gcc kile maxima inkscape eclipse openssh-server gparted build-essential pstoedit okular nfs-common python-scitools ipython python-sklearn python-pywt libcv-dev opencv-doc python-opencv libhighgui-dev kdiff3 texlive-full icedax id3v2 lame libflac++6v5 libjpeg-progs mencoder regionset sox uudeview vorbis-tools x264 arj p7zip p7zip-full p7zip-rar unrar unace-nonfree vlc gimp screen htop cpufrequtils ntp aspell aspell-pt-br djvulibre-desktop libclang-dev cmake ipython-notebook python-{sympy,scipy,numpy} bpython terminator stow libdbus-1-dev libcups2 openssl libcups2-dev cups-bsd cups-client libsane-dev libusb-1.0.0-dev libcupsimage2-dev libsnmp-dev snmp-mibs-downloader libtool opencl-headers lsb-core mono-devel git gitk fftw-dev libfftw3-dev libeigen3-dev libcgal-dev libopenmpi-dev gnome-session-flashback x11proto-xf86bigfont-dev xfstt t1-xfree86-nonfree ttf-xfree86-nonfree ttf-xfree86-nonfree-syriac xfonts-75dpi xfonts-100dpi x11-xfs-utils xfstt curl autoconf autoconf-archive autogen automake libmnl-dev python-pymongo uuid-dev 2>&1 > /dev/null
echo "Istalacao concluida"

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg --install google-chrome-stable_current_amd64.deb
apt-get update
apt-get install google-chrome-stable

echo "Criacao dos repos"
mkdir -p /opt/repo-admin && mkdir -p /opt/repo-processamento && mkdir -p /opt/repo-alunos

echo "greeter-show-manual-login=true" >>  /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf

