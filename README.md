# HAPIFHIRAutoInstall
Auto-installs a HAPI FHIR server on a Linux box with a user-friendly command line interface

To run:

1. Download the autoinstall-hapi-fhir-server.sh to where-ever you prefer on your Linux box (requires wget, zip, Java 8 or later is installed;)
2. Run the autoinstall-hapi-fhir-server.sh file with root (EG sudo) privileges
3. Input appropriate responses into the script. As it's a simple script it will not attempt to sanitise or validate the inputs.
4. It should successfully run (as well as, assuming local network IP is available, present the most likely IP/URL your FHIR server is running on)

To download the file to a CLI-only Linux server box in your current directory, with curl installed, run:

    curl -L https://github.com/HIE-DEV/HAPIFHIRAutoInstall/archive/master.zip > ./master.zip && unzip -o master.zip
    
Then finally:

    sudo bash ./HAPIFHIRAutoInstall-master/autoinstall-hapi-fhir-server.sh

