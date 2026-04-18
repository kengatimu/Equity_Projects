

# $Author: Jamuna G$
# Prerequiste - compile the required ( customised ) java programs under InterfaceHooks


# IntHooksArchive - To replace the customized InterfaceHooks files into Interface.jar
# Pass the full path of the Interface.jar as a parameter for this program during exection


# This BAT file unjar the Interface.jar  specified in the parameter 
# Replaces the new class files under the custom directory
# creates a new jar named InterfaceCustom.jar 

# set the Interface.jar path as parameter
Interfacejar_Path=$1

if [ -z "$Interfacejar_Path" ]; then  echo ERROR: Enter Interface.jar path as parameter
fi

# extract the Interface.jar file under InterfaceHooks folder
jar -xvf $Interfacejar_Path

# Replaces the class files under the extracted custom folder
# If any change in packaging the following path needs to be changed
Extract_path=.//com/infy/custom
echo $Extract_path
if [ -n "$Extract_path" ] 
then
mv *.class $Extract_path
fi


# Create InterfaceCustom.jar file
jar -cvf InterfaceCustom.jar com

# Delete the extracted folders
 rmdir -r -f com
 rmdir -r -f META-INF



