#!/bin/bash

#########################################
##        ENVIRONMENTAL CONFIG         ##
#########################################

# Configure user nobody to match unRAID's settings
usermod -u 99 nobody
usermod -g 100 nobody
usermod -d /home nobody
chown -R nobody:users /home

# Disable SSH
rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

#########################################
##    REPOSITORIES AND DEPENDENCIES    ##
#########################################

# Repositories
add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ trusty universe multiverse"
add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ trusty-updates universe multiverse"
add-apt-repository "deb http://apt.sonarr.tv/ master main"
apt-add-repository ppa:mc3man/trusty-media -y
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC

# Install Dependencies
apt-get update -qq
apt-get install -qy libgdiplus libmono-cil-dev nzbdrone
apt-get install python-pip -y
apt-get install ffmpeg
curl https://bootstrap.pypa.io/ez_setup.py -O
python3.4 ez_setup.py
pip install requests 
pip install requests[security] 
pip install requests-cache 
pip install babelfish 
pip install "guessit<2"
pip install subliminal
pip install deluge-client
pip install qtfaststart



#########################################
##             INSTALLATION            ##
#########################################

# Fix permissions
chown -R nobody:users /opt/NzbDrone
ln -sf /opt/ffmpeg/bin/ffmpeg /usr/bin/ffmpeg

#########################################
##                 CLEANUP             ##
#########################################

# Clean APT install files
apt-get clean -y
rm -rf /var/lib/apt/lists/* /var/cache/* /var/tmp/*

