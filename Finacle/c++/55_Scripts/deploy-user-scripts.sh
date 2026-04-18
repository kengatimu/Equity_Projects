#!/bin/bash

# --------------------------------------------------------------------------------------------------------------------- #
#                                 																					    #
# NOTE: THIS SCRIPT FILE SHOULD NOT BE UPDATED !!!																		#
#																														#
# This script deploys the changed USER scripts on the  path to the Finacle server 										#
#                                       																				#
# --------------------------------------------------------------------------------------------------------------------- #

echo "-------------- STARTING USER SERVER SCRIPTS DEPLOYMENT PROGRAM... --------------"
echo

#static file names
newFilesFileName=newFilesPath.txt
finacleFileType=finacleFileType.txt
deletedFilesFileName=deletedFilesPath.txt
modifiedFilesFileName=modifiedFilesPath.txt

#azure path definitions
optDirectory=opt/agent/_work/55/a

#USER path and variable definitions
hpUSERRootDirectory=/equity_be/EQPRODUSER/BackEnd/Finacle/FC/app
hpUSERScriptDirectory=/equity_be/EQPRODUSER/BackEnd/Finacle/FC/app/prod_cust
backupUSERScriptDirectory="$hpUSERScriptDirectory"/Backup/ModifiedFiles
backupNewUSERFileScriptDirectory="$hpUSERScriptDirectory"/Backup/NewFiles
deletedUSERScriptDirectory="$hpUSERScriptDirectory"/Deleted_Scripts
comUSERFrenchDirectory="$hpUSERScriptDirectory"/FRENCH/com
comUSERInfengDirectory="$hpUSERScriptDirectory"/INFENG/com
TempUSERScriptDir="$hpUSERRootDirectory"/Temp_Script_Directory

#USER Directory to store the received files from build pipeline
USERNewFiles="$TempUSERScriptDir"/"$optDirectory"/newFiles
USERDeletedFiles="$TempUSERScriptDir"/"$optDirectory"/deletedFiles
USERModifiedFiles="$TempUSERScriptDir"/"$optDirectory"/modifiedFiles
USERFinacleFileType="$TempUSERScriptDir"/"$optDirectory"/finacleFileType

#function to create the necessary directories
create_directory() {
	directoryName=$1
	
	#check if the directory exists, if not create it
	if [ ! -d "$directoryName" ];
	then
		echo "Directory $directoryName DOES NOT EXIST. Creating the directory $directoryName..."
		mkdir -p "$directoryName"
	fi
}

#function to give permissions to FRENCH and INFENG
update_permissions() {
	directoryName=$1
	directoryPath=$2
	
	#if the directory exists, update permissions
	if [ -d "$directoryPath" ]; 
	then
		echo "Updating "$directoryName" com directory With 743 permissions"
		chmod -Rv 743 "$directoryPath"
	fi
}

#funtion to check if fi file
isUserFile() {
	if [[ "$1" =~ ^USER.* ]]; #Regex: matches strings that begin with "USER" and can have any characters (including none) after it.
	then
		#return true
  		return 0
	else
		#return false
  		return 1
	fi
}

#function to do some clean up
cleanup() {
	directory="$1"
	
	echo "Doing Clean Up At "$directory""
	cd "$directory"
	
	rm -rf "$TempUSERScriptDir" || true
	rm -rvf azure-pipeline-USER.yaml || true
	rm -rvf deploy-user-scripts.sh || true
	rm -rvf check-modified-files.sh || true
	rm -rvf finacle-USER-scripts.tar.gz || true
}

#function to check for deleted files.
check_for_deleted_files() {
	cd "$USERDeletedFiles"
	echo "-------------- CHECK FOR DELETED FILE PROCESS STARTING... --------------"

	#check if "deletedFilesPath.txt exists"
	echo "Checking If "$deletedFilesFileName" Exists In "$USERDeletedFiles""
	if [ -f "$deletedFilesFileName" ]; 
	then
		echo "Deleted Files Exists In "$USERDeletedFiles""
		echo

		#copy deleted scripts to deletedUSERScriptDirectory
		while read -r file;
		do	
			#checking if file is fi
			if $(isUserFile "$file") ; #if true
			then
				echo "Deleted USER File Name: " "$file" 
				cd "$hpUSERScriptDirectory"
				path="$hpUSERScriptDirectory"
				deleteScriptDir="$deletedUSERScriptDirectory"	
				
			else
				echo ""$file" IS NOT A FINACLE USER FILE, GOING TO THE NEXT ITERATION"
				echo
				continue
			fi
			
			#remove the first directory path: From say USER/INFENG/Scripts/file.scr to INFENG/Scripts/file.scr
			deletedFile=$(echo "$file" | cut -d '/' -f 2-) #extract the third word from the output after slash delimeter
			
			#move the file from the script path to deleted directory
			if [ -f "$deletedFile" ]; 
			then
				#move file to the deletedScriptDirectory
				echo "Moving "$deletedFile" To "$deleteScriptDir""
				mv "$deletedFile" "$deleteScriptDir"
			else
				echo ""$deletedFile" DOES NOT EXIST AT: "$path""
			fi
		done < "$deletedFilesFileName" #deletedFilesFileName contains text file with Absolute path of the file names
	else
		echo "This Commit Contains No Deleted Files"
	fi
	echo "CHECK FOR DELETED FILE PROCESS COMPLEETED!!!"
	echo
}

#function to check for modified files.
check_for_modified_files() {
	cd "$USERModifiedFiles"
	echo "-------------- CHECK FOR MODIFIED FILE PROCESS STARTING... --------------"

	#check if "modifiedFilesPath.txt exists"
	echo "Checking If "$modifiedFilesFileName" Exists In "$USERModifiedFiles""
	if [ -f "$modifiedFilesFileName" ]; 
	then
		echo "Modified Files Exists In "$USERModifiedFiles""
		echo

		#copy modified scripts to backupUSERScriptDirectory
		while read -r file;
		do
			#checking if file is fi
			if $(isUserFile "$file") ; #if true
			then
				echo "Modified USER File Name: " "$file" 
				cd "$hpUSERScriptDirectory"
				backupScriptDir="$backupUSERScriptDirectory"
				modifiedFileScriptDir="$hpUSERScriptDirectory"
				
			else
				echo ""$file" IS NOT A FINACLE USER FILE, GOING TO THE NEXT ITERATION"
				echo
				continue
			fi
			
			#remove the first directory path: From say USER/INFENG/Scripts/file.scr to INFENG/Scripts/file.scr
			modifiedFile=$(echo "$file" | cut -d '/' -f 2-) #extract the third word from the output after slash delimeter
			
			#move modified script to  script path
			if [ -f "$modifiedFile" ]; ####  INFENG/scripts/acctopnvalmn009.scr
			then 
				echo "Starting Operation For: "$modifiedFile"..."
				#first take a backup, but since the file looks like INFENG/scripts/acctopnvalmn009.scr,
				#create INFENG/scripts directory in the backupt directory
				echo "Copying "$modifiedFile" To "$backupScriptDir""
				cd "$backupScriptDir"

				#create the path of the file in the backup directory
				mkdir -p "$(dirname "$modifiedFile")"
				cp "$modifiedFileScriptDir"/"$modifiedFile" "$backupScriptDir"/"$(dirname "$modifiedFile")"

				#rename backup file with the current timestamp
				timeStamp=$(date +"%Y-%m-%dT%H%M%S")
				echo "Renaming "$modifiedFile" To "$modifiedFile"_"$timeStamp""
				mv "$backupScriptDir"/"$modifiedFile" "$backupScriptDir"/"$modifiedFile"_"$timeStamp"

				#now move the incomming modified script to  script path
				echo "Moving "$modifiedFile" To "$modifiedFileScriptDir""

				#remove the file path from the file eg INFENG/scripts/acctopnvalmn009.scr to acctopnvalmn009.scr
				fileWithoutPath="$(basename "$modifiedFile")"
				echo "File name Without Path: "$fileWithoutPath""

				#copy the file to  script directory
				mv "$USERModifiedFiles"/"$fileWithoutPath" "$modifiedFileScriptDir"/"$(dirname "$modifiedFile")"
				echo "Operation For: "$modifiedFile" Completed!"
			else
				echo ""$modifiedFile" DOES NOT EXIST AT: "$modifiedFileScriptDir""
			fi
		done < "$modifiedFilesFileName" #modifiedFilesFileName contains text file with Absolute path of the file names
	else
		echo "This Commit Contains No Modified Files"
	fi
	echo "CHECK FOR MODIFIED FILE PROCESS COMPLETED!!!"
	echo
}

#function to check for new files.
check_for_new_files() {
	cd "$USERNewFiles"
	echo "-------------- CHECK FOR NEW FILE PROCESS STARTING... --------------"

	#check if "newFilesPath.txt exists"
	echo "Checking If "$newFilesFileName" Exists In "$USERNewFiles""
	if [ -f "$newFilesFileName" ]; 
	then
		echo "New Files Exists In "$USERNewFiles""
		echo

		while read -r file;
		do
			#checking if file is fi
			if $(isUserFile "$file") ; #if true
			then
				echo "New USER File Name: " "$file" 
				cd "$hpUSERScriptDirectory"
				newFileScriptDir="$hpUSERScriptDirectory"
				backupScriptDir="$backupNewUSERFileScriptDirectory"
				
			else
				echo ""$file" IS NOT A FINACLE USER FILE, GOING TO THE NEXT ITERATION"
				echo
				continue
			fi
			
			#remove the first directory path: From say USER/INFENG/Scripts/file.scr to INFENG/Scripts/file.scr
			addedFile=$(echo "$file" | cut -d '/' -f 2-) #extract the third word from the output after slash delimeter
			
			#check if file exists in the script  path. if not, then it's a new file
			if [ -f "$addedFile" ]; ####  INFENG/scripts/acctopnvalmn009.scr
			then 
				echo "ANOTHER FILE WITH FILE NAME: "$addedFile" EXISTS AT: "$newFileScriptDir" GOING TO THE NEXT ITERATION"
				echo
				continue
				
#				#take a backup of the existing file
#				echo "Taking A Backup Of The Existing File"
#				echo "Copying "$addedFile" To "$backupScriptDir""
#				cd "$backupScriptDir"
#
#				#create the path of the file in the backup directory
#				mkdir -p "$(dirname "$addedFile")"
#				cp "$newFileScriptDir"/"$addedFile" "$backupScriptDir"/"$(dirname "$addedFile")"
#
#				#rename backup file with the current timestamp
#				timeStamp=$(date +"%Y-%m-%dT%H%M%S")
#				echo "Renaming "$addedFile" To "$addedFile"_"$timeStamp""
#				mv "$backupScriptDir"/"$addedFile" "$backupScriptDir"/"$addedFile"_"$timeStamp"
#				
#				echo "Copying File To NewFileBackup Directory Completed..."
#				echo
			else
				echo ""$addedFile" IS A NEW FILE. IT DOES NOT EXIST AT: "$newFileScriptDir""
				echo
			fi
			echo "Moving New File, "$addedFile" To "$newFileScriptDir""
				
			#remove the file path from the file eg INFENG/scripts/acctopnvalmn009.scr to acctopnvalmn009.scr
			fileWithoutPath="$(basename "$addedFile")"
			echo "File name Without Path: "$fileWithoutPath""

			#copy the file to  script directory, but first create the directory if it doesnt exist
			mkdir -p "$newFileScriptDir"/"$(dirname "$addedFile")"
			cp -v "$USERNewFiles"/"$fileWithoutPath" "$newFileScriptDir"/"$(dirname "$addedFile")"
			echo "Operation For: "$addedFile" Completed!"
			echo
				
		done < "$newFilesFileName" #newFilesFileName contains text file with Absolute path of the file names
	else
		echo "This Commit Contains No New Files"
	fi
	echo "CHECK FOR NEW FILE PROCESS COMPLETED!!!"
	echo
}

#call function to create directory
create_directory "$USERNewFiles"
create_directory "$TempUSERScriptDir"
create_directory "$USERDeletedFiles"
create_directory "$USERModifiedFiles"
create_directory "$USERFinacleFileType"
create_directory "$backupUSERScriptDirectory"
create_directory "$deletedUSERScriptDirectory"
create_directory "$backupNewUSERFileScriptDirectory"

#unzip the received archive in temp directory
echo "UnArchiving finacle-USER-scripts.tar.gz Into "$TempUSERScriptDir""
cd "$hpUSERRootDirectory"

#listing the archive first
#echo "Contents of The Archive"
#tar -ztvf finacle-USER-scripts.tar.gz

cp finacle-USER-scripts.tar.gz "$TempUSERScriptDir"
cd "$TempUSERScriptDir"
tar -xzf finacle-USER-scripts.tar.gz
	
echo "List Contents Of Temp Directory "$TempUSERScriptDir""
ls -lart "$TempUSERScriptDir"/"$optDirectory"

#check if any USER files exists, if not, exit the program
cd "$USERFinacleFileType"
echo "Contents Of  Finacle File Type::: $(pwd)"
ls -lart

# Check if Finacle USER directory was updated by checking if the file contains "USER_exists" text
if grep -q "USER_exists" "$USERFinacleFileType"/finacleFileType.txt;
then
    echo "FiNACLE FI FILES FOUND IN:  "$USERFinacleFileType"/finacleFileType.txt"
	
	cd "$USERNewFiles"
	echo "Contents Of  New Files::: $(pwd)"
	ls -lart

	cd "$USERDeletedFiles"
	echo "Contents Of  Deleted Files::: $(pwd)"
	ls -lart

	cd "$USERModifiedFiles"
	echo "Contents Of  Modified Files::: $(pwd)"
	ls -lart

	#call the respective functions to check status of a file
	check_for_deleted_files
	check_for_modified_files
	check_for_new_files

	#update permissions
	update_permissions "INFENG" "$comUSERFrenchDirectory"
	update_permissions "INFENG" "$comUSERInfengDirectory"
else
    echo "NO FI FILES FOUND. EXITING THE PROGRAM..."
fi

echo "-------------- PERFORMING CLEANUP --------------"
echo

#do some clean up
cleanup "$hpUSERRootDirectory"
cleanup "$hpUSERScriptDirectory"

#exit the program
echo
echo "-------------- USER SERVER SCRIPTS DEPLOYMENT PROGRAM COMPLETED --------------"
exit 0