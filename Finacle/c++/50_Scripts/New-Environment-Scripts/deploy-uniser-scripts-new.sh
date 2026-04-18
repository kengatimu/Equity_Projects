#!/bin/bash

# ----------------------------------------------------------------------------------- #
#                                 																					          #
# NOTE: THIS SCRIPT FILE SHOULD NOT BE UPDATED !!!																		#
#																														                          #
# This script deploys the changed UNISER scripts on the  path to the Finacle server 	#
#                                       																				      #
# ----------------------------------------------------------------------------------- #

echo "-------------- STARTING UNISER SERVER SCRIPTS DEPLOYMENT PROGRAM... --------------"
echo

# arguments
BANK=$1
echo "Bank: "$BANK""

#static file names
newFilesFileName=newFilesPath.txt
finacleFileType=finacleFileType.txt
deletedFilesFileName=deletedFilesPath.txt
modifiedFilesFileName=modifiedFilesPath.txt

#UNISER path and variable definitions
#testPath=/pipelines/UNISER
#hpUNISERRootDirectory="$testPath"/finacle/EQPROD/BackEnd/Finacle/FC/app
#hpUNISERScriptDirectory="$testPath"/finacle/EQPROD/BackEnd/Finacle/FC/app/cust/"$BANK"

hpUNISERRootDirectory=/finacle/equity_be/Finacle/FC/app
hpUNISERScriptDirectory=/finacle/equity_be/Finacle/FC/app/cust/"$BANK"
backupUNISERScriptDirectory="$hpUNISERScriptDirectory"/Backup/ModifiedFiles
backupNewUNISERFileScriptDirectory="$hpUNISERScriptDirectory"/Backup/NewFiles
deletedUNISERScriptDirectory="$hpUNISERScriptDirectory"/Deleted_Scripts
comUNISERFrenchDirectory="$hpUNISERScriptDirectory"/FRENCH/com
comUNISERInfengDirectory="$hpUNISERScriptDirectory"/INFENG/com
TempUNISERScriptDir="$hpUNISERRootDirectory"/Temp_Script_Directory

#UNISER Directory to store the received files from build pipeline
UNISERNewFiles="$TempUNISERScriptDir"/newFiles
UNISERDeletedFiles="$TempUNISERScriptDir"/deletedFiles
UNISERModifiedFiles="$TempUNISERScriptDir"/modifiedFiles
UNISERFinacleFileType="$TempUNISERScriptDir"/finacleFileType

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
		echo "Updating "$directoryName" com directory With 755 permissions"
		chmod -Rv 755 "$directoryPath"
	fi
}

#funtion to check if uniser file
isUniserFile() {
	if [[ "$1" =~ ^UNISER.* ]]; #Regex: matches strings that begin with "UNISER" and can have any characters (including none) after it.
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
	
	rm -rf "$TempUNISERScriptDir" || true
	rm -rvf azure-pipeline-UNISER.yaml || true
	rm -rvf check-modified-files.sh || true
	rm -rvf deploy-*.sh || true
	rm -rvf finacle-*.tar.gz || true
	rm -rvf suScript.sh || true
}

#function to check for deleted files.
check_for_deleted_files() {
	cd "$UNISERDeletedFiles"
	echo "-------------- CHECK FOR DELETED FILE PROCESS STARTING... --------------"

	#check if "deletedFilesPath.txt exists"
	echo "Checking If "$deletedFilesFileName" Exists In "$UNISERDeletedFiles""
	if [ -f "$deletedFilesFileName" ]; 
	then
		echo "Deleted Files Exists In "$UNISERDeletedFiles""
		echo

		#copy deleted scripts to deletedUNISERScriptDirectory
		while read -r file;
		do	
			#checking if file is uniser
			if $(isUniserFile "$file") ; #if true
			then
				echo "Deleted UNISER File Name: " "$file" 
				cd "$hpUNISERScriptDirectory"
				path="$hpUNISERScriptDirectory"
				deleteScriptDir="$deletedUNISERScriptDirectory"	
				
			else
				echo ""$file" IS NOT A FINACLE UNISER FILE, GOING TO THE NEXT ITERATION"
				echo
				continue
			fi
			
			#remove the first directory path: From say UNISER/INFENG/Scripts/file.scr to INFENG/Scripts/file.scr
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
	cd "$UNISERModifiedFiles"
	echo "-------------- CHECK FOR MODIFIED FILE PROCESS STARTING... --------------"

	#check if "modifiedFilesPath.txt exists"
	echo "Checking If "$modifiedFilesFileName" Exists In "$UNISERModifiedFiles""
	if [ -f "$modifiedFilesFileName" ]; 
	then
		echo "Modified Files Exists In "$UNISERModifiedFiles""
		echo

		#copy modified scripts to backupUNISERScriptDirectory
		while read -r file;
		do
			#checking if file is uniser
			if $(isUniserFile "$file") ; #if true
			then
				echo "Modified UNISER File Name: " "$file" 
				cd "$hpUNISERScriptDirectory"
				backupScriptDir="$backupUNISERScriptDirectory"
				modifiedFileScriptDir="$hpUNISERScriptDirectory"
				
			else
				echo ""$file" IS NOT A FINACLE UNISER FILE, GOING TO THE NEXT ITERATION"
				echo
				continue
			fi
			
			#remove the first directory path: From say UNISER/INFENG/Scripts/file.scr to INFENG/Scripts/file.scr
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
				mv "$UNISERModifiedFiles"/"$fileWithoutPath" "$modifiedFileScriptDir"/"$(dirname "$modifiedFile")"
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
	cd "$UNISERNewFiles"
	echo "-------------- CHECK FOR NEW FILE PROCESS STARTING... --------------"

	#check if "newFilesPath.txt exists"
	echo "Checking If "$newFilesFileName" Exists In "$UNISERNewFiles""
	if [ -f "$newFilesFileName" ]; 
	then
		echo "New Files Exists In "$UNISERNewFiles""
		echo

		while read -r file;
		do
			#checking if file is uniser
			if $(isUniserFile "$file") ; #if true
			then
				echo "New UNISER File Name: " "$file" 
				cd "$hpUNISERScriptDirectory"
				newFileScriptDir="$hpUNISERScriptDirectory"
				backupScriptDir="$backupNewUNISERFileScriptDirectory"
				
			else
				echo ""$file" IS NOT A FINACLE UNISER FILE, GOING TO THE NEXT ITERATION"
				echo
				continue
			fi
			
			#remove the first directory path: From say UNISER/INFENG/Scripts/file.scr to INFENG/Scripts/file.scr
			addedFile=$(echo "$file" | cut -d '/' -f 2-) #extract the third word from the output after slash delimeter
			
			#check if file exists in the script  path. if not, then it's a new file
			if [ -f "$addedFile" ]; ####  INFENG/scripts/acctopnvalmn009.scr
			then 
				echo "ANOTHER FILE WITH SAME NAME, "$addedFile" EXISTS AT: "$newFileScriptDir""
				echo
				
				#take a backup of the existing file
				echo "Taking A Backup Of The Existing File"
				echo "Copying "$addedFile" To "$backupScriptDir""
				cd "$backupScriptDir"

				#create the path of the file in the backup directory
				mkdir -p "$(dirname "$addedFile")"
				cp "$newFileScriptDir"/"$addedFile" "$backupScriptDir"/"$(dirname "$addedFile")"

				#rename backup file with the current timestamp
				timeStamp=$(date +"%Y-%m-%dT%H%M%S")
				echo "Renaming "$addedFile" To "$addedFile"_"$timeStamp""
				mv "$backupScriptDir"/"$addedFile" "$backupScriptDir"/"$addedFile"_"$timeStamp"
				
				echo "Copying File To NewFileBackup Directory Completed..."
				echo
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
			cp -v "$UNISERNewFiles"/"$fileWithoutPath" "$newFileScriptDir"/"$(dirname "$addedFile")"
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
create_directory "$UNISERNewFiles"
create_directory "$TempUNISERScriptDir"
create_directory "$UNISERDeletedFiles"
create_directory "$UNISERModifiedFiles"
create_directory "$UNISERFinacleFileType"
create_directory "$backupUNISERScriptDirectory"
create_directory "$deletedUNISERScriptDirectory"
create_directory "$backupNewUNISERFileScriptDirectory"

#unzip the received archive in temp directory
echo "UnArchiving finacle-UNISER-scripts.tar.gz Into "$TempUNISERScriptDir""
cd "$hpUNISERRootDirectory"

#listing the archive first
#echo "Contents of The Archive"
#tar -ztvf finacle-UNISER-scripts.tar.gz

cp finacle-UNISER-scripts.tar.gz "$TempUNISERScriptDir"
cd "$TempUNISERScriptDir"
tar -xzf finacle-UNISER-scripts.tar.gz
	
echo "List Contents Of Temp Directory "$TempUNISERScriptDir""
# ls -lart "$TempUNISERScriptDir"/"$optDirectory"
ls -lart "$TempUNISERScriptDir"


#check if any UNISER files exists, if not, exit the program
cd "$UNISERFinacleFileType"
echo "Contents Of  Finacle File Type::: $(pwd)"
ls -lart

# Check if Finacle UNISER directory was updated by checking if the file contains "UNISER_exists" text
if grep -q "UNISER_exists" "$UNISERFinacleFileType"/finacleFileType.txt; 
then
    echo "FiNACLE UNISER FILES FOUND IN:  "$UNISERFinacleFileType"/finacleFileType.txt"
	
	cd "$UNISERNewFiles"
	echo "Contents Of  New Files::: $(pwd)"
	ls -lart

	cd "$UNISERDeletedFiles"
	echo "Contents Of  Deleted Files::: $(pwd)"
	ls -lart

	cd "$UNISERModifiedFiles"
	echo "Contents Of  Modified Files::: $(pwd)"
	ls -lart

	#call the respective functions to check status of a file
	check_for_deleted_files
	check_for_modified_files
	check_for_new_files

	#update permissions
	update_permissions "INFENG" "$comUNISERFrenchDirectory"
	update_permissions "INFENG" "$comUNISERInfengDirectory"
else
    echo "NO UNISER FILES FOUND. EXITING THE PROGRAM..."
fi

echo "-------------- PERFORMING CLEANUP --------------"
echo

#do some clean up
cleanup "$hpUNISERRootDirectory"
cleanup "$hpUNISERScriptDirectory"

#exit the program
echo
echo "-------------- UNISER SERVER SCRIPTS DEPLOYMENT PROGRAM COMPLETED --------------"
exit 0