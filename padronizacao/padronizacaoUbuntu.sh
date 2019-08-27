#!/bin/bash

echo "Atualizando repositorios"
apt-get update 2>&1 > /dev/null
echo "Atualizando pacotes instalados"
apt-get upgrade -y 2>&1 > /dev/null
#echo "Pacotes atualizados"

echo "Instalacao dos pacotes"
apt-get install -y goldendict python-matplotlib vim pdftk ispell gcc kile maxima inkscape eclipse openssh-server gparted build-essential pstoedit okular nfs-common python-scitools ipython python-sklearn python-pywt libcv-dev opencv-doc python-opencv libhighgui-dev kdiff3 texlive-full icedax id3v2 lame libflac++6v5 libjpeg-progs mencoder regionset sox uudeview vorbis-tools x264 arj p7zip p7zip-full p7zip-rar unrar unace-nonfree vlc gimp screen htop cpufrequtils ntp aspell aspell-pt-br djvulibre-desktop libclang-dev cmake ipython-notebook python-{sympy,scipy,numpy} bpython stow libdbus-1-dev libcups2 openssl libcups2-dev cups-bsd cups-client libsane-dev libusb-1.0.0-dev libcupsimage2-dev libsnmp-dev snmp-mibs-downloader libtool opencl-headers lsb-core mono-devel git gitk fftw-dev libfftw3-dev libeigen3-dev libcgal-dev libopenmpi-dev gnome-session-flashback x11proto-xf86bigfont-dev xfstt t1-xfree86-nonfree ttf-xfree86-nonfree ttf-xfree86-nonfree-syriac xfonts-75dpi xfonts-100dpi x11-xfs-utils xfstt curl autoconf autoconf-archive autogen automake libmnl-dev python-pymongo uuid-dev compizconfig-settings-manager compiz-plugins libx11-dev   libxt-dev 2>&1 > /dev/null
if [ $? -eq 0 ];
then
	echo "Istalacao concluida"
else
	echo "Erro na instalacao dos pacotes. Refazer"
	exit 1
fi

echo 'Instalacao octave'
apt-add-repository -y ppa:octave/stable 
aptitude update
apt-get -y install octave
if [ $? -eq 0 ];
then
	echo "Istalacao do octave concluida"
else
	echo "Erro na instalacao do octave. Refazer"
fi

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg --install google-chrome-stable_current_amd64.deb
apt-get update 2>&1 > /dev/null
apt-get install google-chrome-stable 2>&1 > /dev/null
if [ $? -eq 0 ];
then
	echo "Istalacao do chrome concluida"
else
	echo "Erro ao instalar o chrome"
fi

echo "Criando arquivo ntp"
cp /etc/ntp.conf /etc/ntp.conf.save
rm /etc/ntp.conf
touch /etc/ntp.conf

echo "driftfile /var/lib/ntp/ntp.drift" >> /etc/ntp.conf
echo "tatistics loopstats peerstats clockstats" >> /etc/ntp.conf
echo "filegen loopstats file loopstats type day enable" >> /etc/ntp.conf
echo "filegen peerstats file peerstats type day enable" >> /etc/ntp.conf
echo "filegen clockstats file clockstats type day enable" >> /etc/ntp.conf
echo "server ntp.unicamp.br" >> /etc/ntp.conf
echo "server ntp1.unicamp.br" >> /etc/ntp.conf
echo "server ntp2.unicamp.br" >> /etc/ntp.conf
echo "server ntp3.unicamp.br" >> /etc/ntp.conf
echo "server ntp4.unicamp.br" >> /etc/ntp.conf
echo "server ntp.org.br" >> /etc/ntp.conf
echo "restrict -4 default kod notrap nomodify nopeer noquery" >> /etc/ntp.conf
echo "restrict -6 default kod notrap nomodify nopeer noquery" >> /etc/ntp.conf
echo "restrict 127.0.0.1" >> /etc/ntp.conf
echo "restrict ::1" >> /etc/ntp.conf
echo "Configuracao de ntp concluida"

echo "Modificando id do Manutencao"
usermod --uid 999 manutencao
if [ $? -eq 0 ];
then
	echo "Id de manutencao modificado"
else
	echo "Erro ao modificar id de manutencao"
    exit 1
fi
groupmod -g 999 manutencao
if [ $? -eq 0 ];
then
	echo "Gid de manutencao modificado"
else
	echo "Erro ao modificar gid de manutencao"
    exit 1
fi

echo "Configuracao de fstab com o NFS"
cp /etc/fstab /etc/fstab.save

echo "#HOME" >> /etc/fstab
echo "172.16.0.10:/home       /home   nfs     rw,auto,exec,tcp,nfsvers=3,rsize=65536,wsize=65536      0       2" >> /etc/fstab
echo "#REPOS >>" /etc/fstab
echo "172.16.0.6:/opt/repo-admin     /opt/repo-admin nfs     auto,users,exec,tcp,nfsvers=3,intr,async,rsize=32768,wsize=32768        0       2" >> /etc/fstab
echo "172.16.0.6:/opt/repo-processamento     /opt/repo-processamento nfs     auto,users,exec,tcp,nfsvers=3,intr,async,rsize=32768,wsize=32768    0       2" >> /etc/fstab
echo "172.16.0.6:/opt/repo-alunos    /opt/repo-alunos        nfs     auto,users,exec,tcp,nfsvers=3,intr,async,rsize=32768,wsize=32768        0       2" >> /etc/fstab

echo "Criacao dos repos"
mkdir -p /opt/repo-admin && mkdir -p /opt/repo-processamento && mkdir -p /opt/repo-alunos

echo "Configuracao de Nis"
apt-get install nis
if [ "$?" -eq 0 ];
then
	echo "Istalacao concluida" && cp /etc/yp.conf /etc/yp.conf.save && echo "domain hpg server 172.16.0.10" >> /etc/yp.conf
else
	echo "Erro na instalacao do Nis. Refazer"
fi

echo "Configuracao de nsswitch.conf"
cp /etc/nsswitch.conf /etc/nsswitch.conf.save
rm /etc/nsswitch.conf
echo "passwd:         nis files compat ">> /etc/nsswitch.conf
echo "group:          nis files compat ">> /etc/nsswitch.conf
echo "shadow:         nis files compat ">> /etc/nsswitch.conf
echo "hosts:          nis files dns ">> /etc/nsswitch.conf
echo "networks:       files ">> /etc/nsswitch.conf
echo "protocols:      db files ">> /etc/nsswitch.conf
echo "services:       db files ">> /etc/nsswitch.conf
echo "ethers:         db files ">> /etc/nsswitch.conf
echo "rpc:            db files ">> /etc/nsswitch.conf
echo "netgroup:       nis ">> /etc/nsswitch.conf

echo "Padronizacao tela de login"
echo "greeter-show-manual-login=true" >>  /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf
echo "allow-guest=false" >> /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf
echo "greeter-hide-users=true" >> /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf

echo "Instalacao singulatity"
VERSION=2.4
#VERSION=2.5.2
wget https://github.com/singularityware/singularity/releases/download/$VERSION/singularity-$VERSION.tar.gz
tar xvf singularity-$VERSION.tar.gz
cd singularity-$VERSION
./configure --prefix=/usr/local
make
make install

echo "Adicionando alias para o promax"
cp /etc/bash.bashrc /etc/bash.bashrc_save

#echo "function promax {" >> /etc/bash.bashrc
#echo "   singularity exec /export_local/centos_6_9_estavel.img /usr/local/Landmark/SeisSpace5000.10.0/SeisSpace/etc/sitemgr start" >> /etc/bash.bashrc
#echo "   ssh -X \$HOSTNAME \"singularity exec /export_local/centos_6_9_estavel.img bash -c \'source .bashrc && /usr/local/Landmark/SeisSpace5000.10.0/SeisSpace/etc/SSclient\'\" " >> /etc/bash.bashrc
#echo "}">> /etc/bash.bashrc
#
#echo "alias norsar_seisrox=\"singularity exec /export_local/centos_6_9_estavel.img /usr/local/norsar_seisrox/NORSAR_Software_Suite_2017.1/NORSAR.sh\"" >> /etc/bash.bashrc
#echo ""

echo "Instalacao do cuda 9.0"
wget https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda-repo-ubuntu1604-9-0-local_9.0.176-1_amd64-deb  2>&1 > /dev/null
dpkg --install cuda-repo-ubuntu1604-9-0-local_9.0.176-1_amd64-deb  2>&1 > /dev/null
apt-key add /var/cuda-repo-9-0-local/7fa2af80.pub  2>&1 > /dev/null
apt-get update  2>&1 > /dev/null
apt-get install -y cuda  2>&1 > /dev/null
echo "Verificar instalacao do Cuda"

echo "Instalacao do Netdata"
bash <(curl -Ss https://my-netdata.io/kickstart.sh)
echo "Validar instalacao e registro"

touch /etc/scriptDeInstalacaoConcluido

echo ""
echo "Padronizacao quase finalizada."
echo "Instalar: SU, Java, Impressoras, Nvidia (se possuir)"
