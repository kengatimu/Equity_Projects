#!/bin/bash

# ----------------------------------------------------------------------------------------- #
#                                 																					                #
# NOTE: THIS SCRIPT FILE SHOULD NOT BE UPDATED !!!																		      #
#																														                                #
# This script deploys the changed FI scripts on the script  path to the Finacle server 		  #
#                                       																				            #
# ----------------------------------------------------------------------------------------- #

echo "-------------- STARTING FI SERVER SCRIPTS DEPLOYMENT PROGRAM... --------------"
echo

# arguments
BANK=$1
echo "Bank: "$BANK""

#static file names
newFilesFileName=newFilesPath.txt
finacleFileType=finacleFileType.txt
deletedFilesFileName=deletedFilesPath.txt
modifiedFilesFileName=modifiedFilesPath.txt

#FI path and variable definitions
#testPath=/pipelines/FI
#hpFIRootDirectory="$testPath"/finacle/EQPRODFI/BackEnd/Finacle/FC/app
#hpFIScriptDirectory="$testPath"/finacle/EQPRODFI/BackEnd/Finacle/FC/app/cust/"$BANK"

hpFIRootDirectory=/finacle/EQPRODFI/BackEnd/Finacle/FC/app
hpFIScriptDirectory=/finacle/EQPRODFI/BackEnd/Finacle/FC/app/cust/"$BANK"
backupFIScriptDirectory="$hpFIScriptDirectory"/Backup/ModifiedFiles
backupNewFIFileScriptDirectory="$hpFIScriptDirectory"/Backup/NewFiles
deletedFIScriptDirectory="$hpFIScriptDirectory"/Deleted_Scripts
comFIFrenchDirectory="$hpFIScriptDirectory"/FRENCH/com
comFIInfengDirectory="$hpFIScriptDirectory"/INFENG/com
TempFIScriptDir="$hpFIRootDirectory"/Temp_Script_Directory

#FI Directory to store the received files from build pipeline
FINewFiles="$TempFIScriptDir"/newFiles
FIDeletedFiles="$TempFIScriptDir"/deletedFiles
FIModifiedFiles="$TempFIScriptDir"/modifiedFiles
FIFinacleFileType="$TempFIScriptDir"/finacleFileType

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
isFiFile() {
	if [[ "$1" =~ ^FI.* ]]; #Regex: matches strings that begin with "FI" and can have any characters (including none) after it.
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
	
	rm -rf "$TempFIScriptDir" || true
	rm -rvf azure-pipeline-FI.yaml || true
	rm -rvf check-modified-files.sh || true
	rm -rvf deploy-*.sh || true
	rm -rvf finacle-*.tar.gz || true
	rm -rvf suScript.sh || true
}

#function to check for deleted files.
check_for_deleted_files() {
	cd "$FIDeletedFiles"
	echo "-------------- CHECK FOR DELETED FILE PROCESS STARTING... --------------"

	#check if "deletedFilesPath.txt exists"
	echo "Checking If "$deletedFilesFileName" Exists In "$FIDeletedFiles""
	if [ -f "$deletedFilesFileName" ]; 
	then
		echo "Deleted Files Exists In "$FIDeletedFiles""
		echo

		#copy deleted scripts to deletedFIScriptDirectory
		while read -r file;
		do	
			#checking if file is fi
			if $(isFiFile "$file") ; #if true
			then
				echo "Deleted FI File Name: " "$file" 
				cd "$hpFIScriptDirectory"
				path="$hpFIScriptDirectory"
				deleteScriptDir="$deletedFIScriptDirectory"	
				
			else
				echo ""$file" IS NOT A FINACLE FI FILE, GOING TO THE NEXT ITERATION"
				echo
				continue
			fi
			
			#remove the first directory path: From say FI/INFENG/Scripts/file.scr to INFENG/Scripts/file.scr
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
	cd "$FIModifiedFiles"
	echo "-------------- CHECK FOR MODIFIED FILE PROCESS STARTING... --------------"

	#check if "modifiedFilesPath.txt exists"
	echo "Checking If "$modifiedFilesFileName" Exists In "$FIModifiedFiles""
	if [ -f "$modifiedFilesFileName" ]; 
	then
		echo "Modified Files Exists In "$FIModifiedFiles""
		echo

		#copy modified scripts to backupFIScriptDirectory
		while read -r file;
		do
			#checking if file is fi
			if $(isFiFile "$file") ; #if true
			then
				echo "Modified FI File Name: " "$file" 
				cd "$hpFIScriptDirectory"
				backupScriptDir="$backupFIScriptDirectory"
				modifiedFileScriptDir="$hpFIScriptDirectory"
				
			else
				echo ""$file" IS NOT A FINACLE FI FILE, GOING TO THE NEXT ITERATION"
				echo
				continue
			fi
			
			#remove the first directory path: From say FI/INFENG/Scripts/file.scr to INFENG/Scripts/file.scr
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
				mv "$FIModifiedFiles"/"$fileWithoutPath" "$modifiedFileScriptDir"/"$(dirname "$modifiedFile")"
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
	cd "$FINewFiles"
	echo "-------------- CHECK FOR NEW FILE PROCESS STARTING... --------------"

	#check if "newFilesPath.txt exists"
	echo "Checking If "$newFilesFileName" Exists In "$FINewFiles""
	if [ -f "$newFilesFileName" ]; 
	then
		echo "New Files Exists In "$FINewFiles""
		echo

		while read -r file;
		do
			#checking if file is fi
			if $(isFiFile "$file") ; #if true
			then
				echo "New FI File Name: " "$file" 
				cd "$hpFIScriptDirectory"
				newFileScriptDir="$hpFIScriptDirectory"
				backupScriptDir="$backupNewFIFileScriptDirectory"
				
			else
				echo ""$file" IS NOT A FINACLE FI FILE, GOING TO THE NEXT ITERATION"
				echo
				continue
			fi
			
			#remove the first directory path: From say FI/INFENG/Scripts/file.scr to INFENG/Scripts/file.scr
			addedFile=$(echo "$file" | cut -d '/' -f 2-) #extract the third word from the output after slash delimeter
			
			#check if file exists in the script  path. if not, then it's a new file
			if [ -f "$addedFile" ]; ####  INFENG/scripts/acctopnvalmn009.scr
			then 
				echo "ANOTHER FILE WITH THE SAME NAME, "$addedFile" EXISTS AT: "$newFileScriptDir""
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
			cp -v "$FINewFiles"/"$fileWithoutPath" "$newFileScriptDir"/"$(dirname "$addedFile")"
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
create_directory "$FINewFiles"
create_directory "$TempFIScriptDir"
create_directory "$FIDeletedFiles"
create_directory "$FIModifiedFiles"
create_directory "$FIFinacleFileType"
create_directory "$backupFIScriptDirectory"
create_directory "$deletedFIScriptDirectory"
create_directory "$backupNewFIFileScriptDirectory"

#unzip the received archive in temp directory
echo "UnArchiving finacle-FI-scripts.tar.gz Into "$TempFIScriptDir""
cd "$hpFIRootDirectory"

#listing the archive first
#echo "Contents of The Archive"
#tar -ztvf finacle-FI-scripts.tar.gz

cp finacle-FI-scripts.tar.gz "$TempFIScriptDir"
cd "$TempFIScriptDir"
tar -xzf finacle-FI-scripts.tar.gz
	
echo "List Contents Of Temp Directory "$TempFIScriptDir""
# ls -lart "$TempFIScriptDir"/"$optDirectory"
ls -lart "$TempFIScriptDir"


#check if any FI files exists, if not, exit the program
cd "$FIFinacleFileType"
echo "Contents Of  Finacle File Type::: $(pwd)"
ls -lart

# Check if Finacle FI directory was updated by checking if the file contains "FI_exists" text
if grep -q "FI_exists" "$FIFinacleFileType"/finacleFileType.txt; 
then
    echo "FiNACLE FI FILES FOUND IN:  "$FIFinacleFileType"/finacleFileType.txt"
	
	cd "$FINewFiles"
	echo "Contents Of  New Files::: $(pwd)"
	ls -lart

	cd "$FIDeletedFiles"
	echo "Contents Of  Deleted Files::: $(pwd)"
	ls -lart

	cd "$FIModifiedFiles"
	echo "Contents Of  Modified Files::: $(pwd)"
	ls -lart

	#call the respective functions to check status of a file
	check_for_deleted_files
	check_for_modified_files
	check_for_new_files

	#update permissions
	update_permissions "INFENG" "$comFIFrenchDirectory"
	update_permissions "INFENG" "$comFIInfengDirectory"
else
    echo "NO FI FILES FOUND. EXITING THE PROGRAM..."
fi

echo "-------------- PERFORMING CLEANUP --------------"
echo

#do some clean up
cleanup "$hpFIRootDirectory"
cleanup "$hpFIScriptDirectory"

#exit the program
echo
echo "-------------- FI SERVER SCRIPTS DEPLOYMENT PROGRAM COMPLETED --------------"
exit 0