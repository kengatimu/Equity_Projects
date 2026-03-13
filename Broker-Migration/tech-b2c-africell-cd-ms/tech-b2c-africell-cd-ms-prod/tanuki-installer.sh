#! /bin/bash

################ DO NOT CHANGE ANYTHING IN THIS SCRIPT! ################ 

# function to check if mandatory file exist
# exit the application if the file does not exist or is empty
file_exist(){
	fileName=$1
	if [ -f "${fileName}" ]; 
	then
    	if [ -z "$(cat ${fileName})" ];
		then
        	echo "File ${fileName} exists but empty"
			echo "Halting and exiting the process!!!"
			exit 0
    	fi
	else
    	echo "File ${fileName} does not exists"
		echo "Halting and exiting the process!!!"
		exit 0
	fi
}

#------------- normal running of the scrip starts here -------------
# call variable script to get variables
source variables.sh

# application home directory
applicationHomeDirectory="$applicationName"

# store the current directory path
currentDirectoryPath=$(pwd)

# create application home directory
if [ -d "$applicationPath" ]; # check if valid path
then
    cd "$applicationPath"
	if [ -d "$applicationHomeDirectory" ];
	then
		echo "Tanuki Installation For "$applicationHomeDirectory" Already Exists. Exiting The Program"
		exit 0
	else
		echo "Creating Home Directory: " "$applicationHomeDirectory" "On Path: " "$applicationPath"
		mkdir -vp "$applicationHomeDirectory" # create the directory
	fi	
else
	echo "ERROR: $applicationPath: path or directory is invalid"
	exit 0
fi	

# go to path where tanuki/application will be installed - home directory
homePath="$applicationPath""$applicationHomeDirectory"
cd $homePath

# constant variables
dirBin=bin
dirLib=lib
dirConf=conf
dirLogs=logs
dirDrop=drop

# create bin, lib, conf, and logs directory if they dont exist
echo "creating $dirBin, $dirLib, $dirConf, and $dirLogs directories"
mkdir -vp "$dirBin" "$dirLib" "$dirConf" "$dirLogs" "$dirDrop" 

#------------- bin -------------
# creating bin files and directories
# create lib folder inside bin
cd bin
echo "creating bin's lib and config directoris"
mkdir -vp lib config

echo
cd "$currentDirectoryPath"

# create the script file for staring the application 
applicationStartFile="$applicationName".sh
touch "$applicationStartFile"

# make the scripts executable
chmod +x "$applicationStartFile" variables.sh

# call the updater file
echo "Creating "$applicationStartFile".sh script"
#source binFileUpdater.sh

applicationStartFile="$applicationName".sh
cp -v binStaticText.txt "$applicationStartFile"

sed -i'.bak' '1s/^/WRAPPER_CONF="..\/conf\/'"$applicationName"'.conf" \n/' "$applicationStartFile"
sed -i'.bak' '1s/^/WRAPPER_CMD=".\/wrapper" \n/' "$applicationStartFile"
sed -i'.bak' '1s/^/# Wrapper \n/' "$applicationStartFile"
sed -i'.bak' '1s/^/ \n/' "$applicationStartFile"
sed -i'.bak' '1s/^/APP_LONG_NAME='"$applicationName"'\n/' "$applicationStartFile"
sed -i'.bak' '1s/^/APP_NAME='"$applicationName"'\n/' "$applicationStartFile"
sed -i'.bak' '1s/^/# Application \n/' "$applicationStartFile"
sed -i'.bak' '1s/^/ \n/' "$applicationStartFile"
sed -i'.bak' '1s/^/# Optimized for use with version 3.4.0 of the Wrapper. \n/' "$applicationStartFile"
sed -i'.bak' '1s/^/# These settings can be modified to fit the needs of your application \n/' "$applicationStartFile"
sed -i'.bak' '1s/^/ \n/' "$applicationStartFile"
sed -i'.bak' '1s/^/#----------------------------------------------------------------------------- \n/' "$applicationStartFile"
sed -i'.bak' '1s/^/# \n/' "$applicationStartFile"
sed -i'.bak' '1s/^/# All rights reserved. \n/' "$applicationStartFile"
sed -i'.bak' '1s/^/# http:\/\/www.tanukisoftware.com \n/' "$applicationStartFile"
sed -i'.bak' '1s/^/# Copyright (c) 1999, 2010 Tanuki Software, Ltd. \n/' "$applicationStartFile"
sed -i'.bak' '1s/^/#----------------------------------------------------------------------------- \n/' "$applicationStartFile"
sed -i'.bak' '1s/^/ \n/' "$applicationStartFile"
sed -i'.bak' '1s/^/#! \/bin\/bash \n/' "$applicationStartFile"

# call the function to check if applicationStartFile exists first before copying files to bin folder
file_exist "$applicationStartFile"

# copy the created files in the application bin directory
# also main.sh script should be copied since it has the variables
echo "copying files to bin folder"
cp -vR variables.sh wrapper "${applicationStartFile}" $homePath/bin

# make files executable
cd $homePath
chmod -R +x bin conf lib 

# go back to current directory
cd "$currentDirectoryPath"

echo
#------------- conf -------------
# create conf script file
confFile="$applicationName".conf
touch "$confFile"

# make the scripts executable
chmod +x "$confFile"

# call the updater file
echo "Creating "$applicationName".conf script"
#source confFileUpdater.sh 

confFile="$applicationName".conf
cp -v confStaticText.txt "$confFile"

sed -i'.bak' '1s/^/wrapper.app.parameter.1='"$startClass"'\n/' "$confFile"
sed -i'.bak' '1s/^/# Application parameters.  Add parameters as needed starting from 1 \n/' "$confFile"
sed -i'.bak' '1s/^/ \n/' "$confFile"
sed -i'.bak' '1s/^/wrapper.java.additional.auto_bits=TRUE \n/' "$confFile"
sed -i'.bak' '1s/^/# Java Bits.  On applicable platforms, tells the JVM to run in 32 or 64-bit mode. \n/' "$confFile"
sed -i'.bak' '1s/^/ \n/' "$confFile"
sed -i'.bak' '1s/^/wrapper.java.library.path.1=%MYAPP_HOME%\/lib \n/' "$confFile"
sed -i'.bak' '1s/^/ \n/' "$confFile"
sed -i'.bak' '1s/^/# Java Library Path (location of Wrapper.DLL or libwrapper.so) \n/' "$confFile"
sed -i'.bak' '1s/^/ \n/' "$confFile"
sed -i'.bak' '1s/^/wrapper.java.classpath.3=%MYAPP_HOME%\/bin\/lib\/*.jar \n/' "$confFile"
sed -i'.bak' '1s/^/wrapper.java.classpath.2=%MYAPP_HOME%\/bin\/'"$jarFileName"'\n/' "$confFile"
sed -i'.bak' '1s/^/wrapper.java.classpath.1=%MYAPP_HOME%\/lib\/wrapper.jar \n/' "$confFile"
sed -i'.bak' '1s/^/#  needed starting from 1 \n/' "$confFile"
sed -i'.bak' '1s/^/# Java Classpath (include wrapper.jar)  Add class path elements as \n/' "$confFile"
sed -i'.bak' '1s/^/ \n/' "$confFile"
sed -i'.bak' '1s/^/wrapper.working.dir=%MYAPP_HOME% \n/' "$confFile"
sed -i'.bak' '1s/^/set.MYAPP_HOME='"$applicationPathEsc"''"$applicationName"'\n/' "$confFile"
sed -i'.bak' '1s/^/set.MYAPP_NAME='"$applicationName"'\n/' "$confFile"
sed -i'.bak' '1s/^/# Working Directory \n/' "$confFile"
sed -i'.bak' '1s/^/ \n/' "$confFile"
sed -i'.bak' '1s/^/wrapper.java.mainclass=org.tanukisoftware.wrapper.WrapperSimpleApp \n/' "$confFile"
sed -i'.bak' '1s/^/ \n/' "$confFile"
sed -i'.bak' '1s/^/#wrapper.java.command.loglevel=INFO \n/' "$confFile"
sed -i'.bak' '1s/^/# Tell the Wrapper to log the full generated Java command line. \n/' "$confFile"
sed -i'.bak' '1s/^/ \n/' "$confFile"
sed -i'.bak' '1s/^/wrapper.java.command='"$javaPath"'\n/' "$confFile"
sed -i'.bak' '1s/^/# Java Application \n/' "$confFile"
sed -i'.bak' '1s/^/ \n/' "$confFile"
sed -i'.bak' '1s/^/#******************************************************************** \n/' "$confFile"
sed -i'.bak' '1s/^/# Wrapper Java Properties \n/' "$confFile"
sed -i'.bak' '1s/^/# Wrapper License Properties (Ignored by Community Edition) \n/' "$confFile"
sed -i'.bak' '1s/^/#******************************************************************** \n/' "$confFile"
sed -i'.bak' '1s/^/ \n/' "$confFile"

# call the function to check if conf file exists first before copying files to bin folder
file_exist "$confFile"

# go back to current directory
cd "$currentDirectoryPath"

# copy the created files in the application bin directory
echo "copying conf file to conf folder"
cp -vR variables.sh "${confFile}" $homePath/conf

echo
#------------- lib -------------
#### copying static files to lib ####
# go back to current directory
cd "$currentDirectoryPath"

echo "copying files to lib folder"
cp -vR libwrapper.so wrapper.jar $homePath/lib

#------------- end -------------

echo "All Jobs Done Successfully. Exiting Main..."
exit 0