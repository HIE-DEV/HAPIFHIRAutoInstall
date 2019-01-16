# HAPIFHIRAutoInstall
Auto-installs a HAPI FHIR server on a Linux box with a user-friendly command line interface

To run:

1. Download the autoinstall-hapi-fhir-server.sh to where-ever you prefer on your Linux box (requires curl, zip and Java 8 or later is installed)
2. Run the autoinstall-hapi-fhir-server.sh file with root (EG sudo) privileges
3. Input appropriate responses into the script. As it's a simple script it will not attempt to sanitise or validate the inputs.
4. It should successfully run (as well as, assuming local network IP is available, present the most likely IP/URL your FHIR server is running on)

To download the file to a CLI-only Linux server box in your current directory, with curl installed, run:

    curl -L https://github.com/HIE-DEV/HAPIFHIRAutoInstall/archive/master.zip > ./master.zip && unzip -o master.zip
    
Then finally:

    sudo bash ./HAPIFHIRAutoInstall-master/autoinstall-hapi-fhir-server.sh


If you wish to manually terminate your server process, you'll need to list active Java processes with:

    ps -aux | grep -v "grep" | grep "java -jar"
    
Then from it's returned listing, look for one that contains a command similar to "java -jar hapi-fhir-cli.jar run-server", using port number to distinguish if you have multiple HAPI FHIR servers (specified with -p). For example, it might look like this:

    root      8144  2.5 12.2 4630060 983788 ?      Sl   11:56   0:28 java -jar /opt/hapi-fhir-cli.jar run-server -v dstu3 -p 8020 --allow-external-refs

From that, find the second column containing the whole number (in this case, 8144). This is known as the 'Process ID' (or PID, for short). With that Process ID, you can call a kill command to terminate that process. For example:

    kill 8144

This should stop your HAPI FHIR server.
