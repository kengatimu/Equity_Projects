#!/bin/bash

# ------------------------------------------------------------------------------------------- #
#                                 																					                  #
# NOTE: THIS SCRIPT FILE SHOULD NOT BE UPDATED !!!																		        #
#																														                                  #
# This script deploys the changed CBC scripts on the script path to the Finacle server 				#
#                                       																				              #
# ------------------------------------------------------------------------------------------- #

echo "-------------- STARTING CBC SERVER SCRIPTS DEPLOYMENT PROGRAM... --------------"
echo

#static file names
newFilesFileName=newFilesPath.txt
finacleFileType=finacleFileType.txt
deletedFilesFileName=deletedFilesPath.txt
modifiedFilesFileName=modifiedFilesPath.txt

#CBC path and variable definitions
#testPath=/pipelines/CBC
#hpCBCRootDirectory="$testPath"/finacle/EQPROD/BackEnd
#hpCBCScriptDirectory="$testPath"/finacle/EQPROD/BackEnd/CBC

hpCBCRootDirectory=/finacle/EQPROD/BackEnd
hpCBCScriptDirectory=/finacle/EQPROD/BackEnd/CBC
backupCBCScriptDirectory="$hpCBCScriptDirectory"/Backup/ModifiedFiles
backupNewCBCFileScriptDirectory="$hpCBCScriptDirectory"/Backup/NewFiles
deletedCBCScriptDirectory="$hpCBCScriptDirectory"/Deleted_Scripts
comCBCFrenchDirectory="$hpCBCScriptDirectory"/FRENCH/com
comCBCInfengDirectory="$hpCBCScriptDirectory"/INFENG/com
TempCBCScriptDir="$hpCBCRootDirectory"/Temp_Script_Directory

#CBC Directory to store the received files from build pipeline
CBCNewFiles="$TempCBCScriptDir"/newFiles
CBCDeletedFiles="$TempCBCScriptDir"/deletedFiles
CBCModifiedFiles="$TempCBCScriptDir"/modifiedFiles
CBCFinacleFileType="$TempCBCScriptDir"/finacleFileType

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

#funtion to check if fi file
isCbcFile() {
	if [[ "$1" =~ ^CBC.* ]]; #Regex: matches strings that begin with "CBC" and can have any characters (including none) after it.
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
	
	rm -rf "$TempCBCScriptDir" || true
	rm -rvf azure-pipeline-CBC.yaml || true
	rm -rvf check-modified-files.sh || true
	rm -rvf deploy-*.sh || true
	rm -rvf finacle-*.tar.gz || true
	rm -rvf suScript.sh || true
}

#function to check for deleted files.
check_for_deleted_files() {
	cd "$CBCDeletedFiles"
	echo "-------------- CHECK FOR DELETED FILE PROCESS STARTING... --------------"

	#check if "deletedFilesPath.txt exists"
	echo "Checking If "$deletedFilesFileName" Exists In "$CBCDeletedFiles""
	if [ -f "$deletedFilesFileName" ]; 
	then
		echo "Deleted Files Exists In "$CBCDeletedFiles""
		echo

		#copy deleted scripts to deletedCBCScriptDirectory
		while read -r file;
		do	
			#checking if file is cbc
			if $(isCbcFile "$file") ; #if true
			then
				echo "Deleted CBC File Name: " "$file" 
				cd "$hpCBCScriptDirectory"
				path="$hpCBCScriptDirectory"
				deleteScriptDir="$deletedCBCScriptDirectory"	
				
			else
				echo ""$file" IS NOT A FINACLE CBC FILE, GOING TO THE NEXT ITERATION"
				echo
				continue
			fi
			
			#remove the first directory path: From say CBC/INFENG/Scripts/file.scr to INFENG/Scripts/file.scr
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
	cd "$CBCModifiedFiles"
	echo "-------------- CHECK FOR MODIFIED FILE PROCESS STARTING... --------------"

	#check if "modifiedFilesPath.txt exists"
	echo "Checking If "$modifiedFilesFileName" Exists In "$CBCModifiedFiles""
	if [ -f "$modifiedFilesFileName" ]; 
	then
		echo "Modified Files Exists In "$CBCModifiedFiles""
		echo

		#copy modified scripts to backupCBCScriptDirectory
		while read -r file;
		do
			#checking if file is cbc
			if $(isCbcFile "$file") ; #if true
			then
				echo "Modified CBC File Name: " "$file" 
				cd "$hpCBCScriptDirectory"
				backupScriptDir="$backupCBCScriptDirectory"
				modifiedFileScriptDir="$hpCBCScriptDirectory"
				
			else
				echo ""$file" IS NOT A FINACLE CBC FILE, GOING TO THE NEXT ITERATION"
				echo
				continue
			fi
			
			#remove the first directory path: From say CBC/INFENG/Scripts/file.scr to INFENG/Scripts/file.scr
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
				mkdir -vp "$(dirname "$modifiedFile")"
				cp -v "$modifiedFileScriptDir"/"$modifiedFile" "$backupScriptDir"/"$(dirname "$modifiedFile")"

				#rename backup file with the current timestamp
				timeStamp=$(date +"%Y-%m-%dT%H%M%S")
				echo "Renaming "$modifiedFile" To "$modifiedFile"_"$timeStamp""
				mv -v "$backupScriptDir"/"$modifiedFile" "$backupScriptDir"/"$modifiedFile"_"$timeStamp"

				#now move the incomming modified script to  script path
				echo "Moving "$modifiedFile" To "$modifiedFileScriptDir""

				#remove the file path from the file eg INFENG/scripts/acctopnvalmn009.scr to acctopnvalmn009.scr
				fileWithoutPath="$(basename "$modifiedFile")"
				echo "File name Without Path: "$fileWithoutPath""

				#copy the file to  script directory
				mv "$CBCModifiedFiles"/"$fileWithoutPath" "$modifiedFileScriptDir"/"$(dirname "$modifiedFile")"
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
	cd "$CBCNewFiles"
	echo "-------------- CHECK FOR NEW FILE PROCESS STARTING... --------------"

	#check if "newFilesPath.txt exists"
	echo "Checking If "$newFilesFileName" Exists In "$CBCNewFiles""
	if [ -f "$newFilesFileName" ]; 
	then
		echo "New Files Exists In "$CBCNewFiles""
		echo

		while read -r file;
		do
			#checking if file is cbc
			if $(isCbcFile "$file") ; #if true
			then
				echo "New CBC File Name: " "$file" 
				cd "$hpCBCScriptDirectory"
				newFileScriptDir="$hpCBCScriptDirectory"
				backupScriptDir="$backupNewCBCFileScriptDirectory"
				
			else
				echo ""$file" IS NOT A FINACLE CBC FILE, GOING TO THE NEXT ITERATION"
				echo
				continue
			fi
			
			#remove the first directory path: From say CBC/INFENG/Scripts/file.scr to INFENG/Scripts/file.scr
			addedFile=$(echo "$file" | cut -d '/' -f 2-) #extract the third word from the output after slash delimeter
			
			#check if file exists in the script  path. if not, then it's a new file
			if [ -f "$addedFile" ]; ####  INFENG/scripts/acctopnvalmn009.scr
			then 
				echo "ANOTHER FILE WITH FILE NAME: "$addedFile" EXISTS AT: "$newFileScriptDir""
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
			cp -v "$CBCNewFiles"/"$fileWithoutPath" "$newFileScriptDir"/"$(dirname "$addedFile")"
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
create_directory "$CBCNewFiles"
create_directory "$TempCBCScriptDir"
create_directory "$CBCDeletedFiles"
create_directory "$CBCModifiedFiles"
create_directory "$CBCFinacleFileType"
create_directory "$backupCBCScriptDirectory"
create_directory "$deletedCBCScriptDirectory"
create_directory "$backupNewCBCFileScriptDirectory"

#unzip the received archive in temp directory
echo "UnArchiving finacle-CBC-scripts.tar.gz Into "$TempCBCScriptDir""
cd "$hpCBCRootDirectory"

#listing the archive first
#echo "Contents of The Archive"
#tar -ztvf finacle-CBC-scripts.tar.gz

cp finacle-CBC-scripts.tar.gz "$TempCBCScriptDir"
cd "$TempCBCScriptDir"
tar -xzf finacle-CBC-scripts.tar.gz
	
echo "List Contents Of Temp Directory "$TempCBCScriptDir""
# ls -lart "$TempCBCScriptDir"/"$optDirectory"
ls -lart "$TempCBCScriptDir"

#check if any CBC files exists
cd "$CBCFinacleFileType"
echo "Contents Of  Finacle File Type::: $(pwd)"
ls -lart

# Check if Finacle CBC directory was updated by checking if the file contains "CBC_exists" text
if grep -q "CBC_exists" "$CBCFinacleFileType"/finacleFileType.txt; 
then
    echo "FiNACLE CBC FILES FOUND IN:  "$CBCFinacleFileType"/finacleFileType.txt"
	
	cd "$CBCNewFiles"
	echo "Contents Of  New Files::: $(pwd)"
	ls -lart

	cd "$CBCDeletedFiles"
	echo "Contents Of  Deleted Files::: $(pwd)"
	ls -lart

	cd "$CBCModifiedFiles"
	echo "Contents Of  Modified Files::: $(pwd)"
	ls -lart

	#call the respective functions to check status of a file
	check_for_deleted_files
	check_for_modified_files
	check_for_new_files

	#update permissions
	update_permissions "INFENG" "$comCBCFrenchDirectory"
	update_permissions "INFENG" "$comCBCInfengDirectory"
else
    echo "NO CBC FILES FOUND. EXITING THE PROGRAM..."
fi

echo "-------------- PERFORMING CLEANUP --------------"
echo

#do some clean up
cleanup "$hpCBCRootDirectory"
cleanup "$hpCBCScriptDirectory"

#exit the program
echo
echo "-------------- CBC SERVER SCRIPTS DEPLOYMENT PROGRAM COMPLETED --------------"
exit 0