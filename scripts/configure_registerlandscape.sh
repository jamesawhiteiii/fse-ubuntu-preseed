#######################################################################
# Project           : Landscape
#
# Program name      : configure_landscape.sh
# Author            : James White III
# Contributors
# Date created      : 07 23 2018
#
# Purpose           : Remotely register Ubuntu client with Landscape Server
#
# 1. Enter hostname of remote system
# 2. Initiate remote SSH Into HostSytem
# 3. Authenticate as "techs"
# 4. Get client files
# 5. 
#######################################################################

#### Get Host Name ####
echo 'enter hostname in "enXXXXXXXl" format'
read HOST
HOST='techs@'$HOST'.cidse.dhcp.asu.edu'
#
#### Connect to the System ####
echo 'Enter Techs password When Prompted'
ssh -t $HOST
#
####enter commands to run in remote system in here####
####ONLY USE DOUBLE QUOTES IN HERE####
#
##########################################################################################
#######################            COPY INSTALL DIRECTORY        #########################
##########################################################################################
#
apt-get update && apt-get -y upgrade
#
##########################################################################################
##########################     Install Landscape Client         ##########################
##########################################################################################
#
apt install landscape-client -y
echo $(date) ${filename} SUCCESS: Landscape-Client Installed >> /var/log/fse.log
#
#
##########################################################################################
##########################################################################################
##########################################################################################
######################	             PRE-CONFIGURE                       #################
######################	     	     LANDSCAPE CLIENT       	             #################
##########################################################################################
##########################################################################################
##########################################################################################
##########################################################################################
##########################################################################################
#
##########################################################################################
#######################            Get Client Files              #########################
##########################################################################################
#
cp -a /mnt/source/linux/ubuntu/preseed/ubuntusata/preseed/install /tmp/
#
##########################################################################################
################       Make backup of default client.conf    #############################
##########################################################################################

mv /etc/landscape/client.conf /etc/landscape/client.conf.bak

##########################################################################################
################ Write Client.txt data to the client.conf file ###########################
##########################################################################################

cp /tmp/install/fse/landscape/client.conf /etc/landscape/

##########################################################################################
##################################  CONFIGURE .host FILE     #############################
##########################################################################################

cat /tmp/install/fse/landscape/addhost.txt >> /etc/hosts

##########################################################################################

##########################################################################################
##########################   Configure /etc/landscape/ directory  ########################
##########################################################################################

##### Copying Landscape License File #####
cp /tmp/install/fse/landscape/license.txt /etc/landscape/

##### Copy Landscape SSL Cert to /etc/landscape #####
cp /tmp/install/fse/landscape/landscape_server.pem
##########################################################################################
##########################################################################################
##########################  Request Client registration from Landscape  ##################
##########################################################################################
##########################################################################################

echo “Beginning Landscape Configuration”
landscape-config --computer-title $(hostname -f) --script-users nobody,landscape,root --silent









