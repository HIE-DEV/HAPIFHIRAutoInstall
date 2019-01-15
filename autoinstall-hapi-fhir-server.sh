#!/bin/bash
#v1.1

#Do a sudo/root level check
uid=$(id -u)

#We don't have root permissions, so we can't install or upgrade anything, so we quit
[ $uid -ne 0 ] && { echo "Requires root (sudo) to successfully run this script."; exit 1; }

read -e -p "Please specify HAPI FHIR version, EG 3.6.0: " -i "3.6.0" version
read -e -p "Please specify STU/DSTU version in all lowercase, EG dstu3: " -i "dstu3" stuversion
read -e -p "Please specify install location without end slash. EG /opt: " -i "/opt" location
read -e -p "Please specify port not in use by any other service to open the HAPI FHIR server on, EG 8090: " -i "8090" port
read -e -p "If your system uses firewalld (AKA firewall-cmd), would you like me to automatically open the port and reload the firewall? y/n: " -i "n" openfirewall

#Delete a pre-existing start script if it exists
file="./hapi-fhir-$version-cli.zip"
[ -e file ] && rm file

wget "https://github.com/jamesagnew/hapi-fhir/releases/download/v$version/hapi-fhir-$version-cli.zip"
unzip -o "hapi-fhir-$version-cli.zip"

localip=$(hostname -I)

if [ "$openfirewall" == "y" ]; then
 	firewall-cmd "--permanent" "--add-port=$port/tcp"
	firewall-cmd "--reload"
	echo "Firewall updated with port $port"
fi

#Delete a pre-existing start script if it exists
file="./start-hapi-fhir-server.sh"
[ -e file ] && rm file

#Write an updated version with the new settings
echo "nohup \"java -jar hapi-fhir-cli.jar run-server -v $stuversion -p $port --allow-external-refs\" &" > ./start-hapi-fhir-server.sh

nohup "bash" "./start-hapi-fhir-server.sh" "&"
echo "This may appear as an error, but this script's best guess for the local URL for your HAPI FHIR server is at: http://$localip:$port"