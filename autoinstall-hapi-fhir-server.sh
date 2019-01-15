#Do a sudo/root level check
uid=$(id -u)

#We don't have root permissions, so we can't install or upgrade anything, so we quit
[ $uid -ne 0 ] && { echo "Requires root (sudo) to successfully run this script."; exit 1; }

echo "Please specify HAPI FHIR version, EG 2.0"
read version
echo "Please specify STU/DSTU version in all lowercase, EG dstu3"
read stuversion
echo "Please specify install location without end slash. EG /opt"
read location
echo "Please specify port not in use by any other service to open the HAPI FHIR server on, EG 8090"
read port

cd "$location"
wget "https://github.com/jamesagnew/hapi-fhir/releases/download/v$version/hapi-fhir-$version-cli.zip"
unzip "hapi-fhir-$version-cli.zip"
java -jar hapi-fhir-cli.jar run-server
nohup "java -jar hapi-fhir-cli.jar run-server -v $stuversion -p $port --allow-external-refs &"
localip=$("hostname -I")
echo "This may appear as an error, but this script's best guess for the local URL for your HAPI FHIR server is at: http://$localip:$port"