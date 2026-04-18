#!/bin/bash

# --------------------------------------------------------------------------------------------------------------------- #
#                                 																					    #
# NOTE: DO NOT change or update this script file Manually 																#
# This script checks from the local repository: 																		#
#   i. 		New File 																									#
#	ii. 	Modified File 																								#
#	iii. 	Deleted File 																								#
# It then copies the file to the azure build artifact staging area. 													#
#																														#
# --------------------------------------------------------------------------------------------------------------------- #

echo
echo "------------------------------- CHECK FOR NEW/MODIFIED FILES PROGRAM STARTING... -------------------------------"
echo

AzureSourceHomeDirectory=$(pwd)
echo "AZURE SOUCE HOME DIRECTORY PATH: "$AzureSourceHomeDirectory""
ls -lart

#path variables
NewFilesDirectory="$AzureSourceHomeDirectory"/newFiles
DeletedFilesDirectory="$AzureSourceHomeDirectory"/deletedFiles
ModifiedFilesDirectory="$AzureSourceHomeDirectory"/modifiedFiles
FinacleFileTypeDirectory="$AzureSourceHomeDirectory"/finacleFileType

#files variables
newFile=newFilesPath.txt
deletedFile=deletedFilesPath.txt
modifiedFile=modifiedFilesPath.txt
finacleFileType=finacleFileType.txt

#function to create the necessary directories
create_directory() {
	directoryName=$1
	
	#check if the directory exists, if not create it, otherwise recreate it
	if [ -d "$directoryName" ];
	then
		echo "Directory "$directoryName" Exists. Recreating "$directoryName" Directory"
		rm -rvf "$directoryName" || true
		mkdir -vp "$directoryName"
	else
		echo "Directory $directoryName DOES NOT exist. Creating the directory $directoryName..."
		mkdir -vp "$directoryName"
		echo
	fi
}

#function to create the necessary files
create_file() {
	fileName=$1
	
	if [ -d "$fileName" ];
	then
		echo "File $fileName Exists. Re-creating "$fileName" file..."
		rm -rvf "$fileName" || true
		touch "$fileName"
	else
		echo "File $fileName DOES NOT exist. Creating File $fileName..."
		touch "$fileName"
		echo
	fi
}

#function to check the type of finacle file(is it FI, CBC, USER, or UNISER)
check_file_type() {
	desc="$1"
	textFile="$2"
	
	echo "CHECKING FINACLE FILE TYPE IN: "$desc""
	
	#pattern Array: The patterns array is defined, containing the patterns to search for.
	patterns=("FI" "USER" "CBC" "UNISER")

	# Loop through patterns
	for pattern in "${patterns[@]}"; 
	do
		#ensuring that the pattern only matches if it's the first word on a line. eg, FI/INFENG and NOT INFENG/fi.scr
		if grep -q "^$pattern" "$textFile"; 
		then  
			# Check if the word exists, where the word is FI_exists for FI, in the finacleFileType.txt text file
			if ! grep -q "\<${pattern}_exists\>" finacleFileType.txt; 
			then
				# If the word does not exist, append it to the finacleFileType.txt file
				echo "${pattern}_exists" >> finacleFileType.txt
			fi
    	fi
	done
}

#function to copy the text file FinacleFileTypeDirectory
copying_file_type() {
	desc="$1"
	textFile="$2"
	
	echo "COPYING FINACLE FILE: "$desc" INTO "$FinacleFileTypeDirectory""
	cp "$textFile" "$FinacleFileTypeDirectory"
	echo
}

#function to check for the deleted
check_deleted_files() {
	desc=$1
	commit_list=$2
	
	echo "------------------------------- "$desc" PROCESS STARTING... -------------------------------"
	#If variable commit_list is empty, then no file was deleted,
	#othewise created a text file to store the deleted files path location
	if [ ! -z "$commit_list" ]; 
	then
		#store the deleted absolute file path in a text file
		echo "$commit_list" >> deletedFilesPath.txt
		echo

		#copy the text file to the DeletedFilesDirectory
		echo "Copying deletedFilesPath.txt to "$DeletedFilesDirectory""
		cp deletedFilesPath.txt "$DeletedFilesDirectory"
		echo
		
	fi
	echo "File Operation, "$desc" Completed"
	echo ""$desc" PROCESS COMPLTED"
	echo
}

#function to check for new files
check_new_files() {
	desc=$1
	commit_list=$2
	
	echo "------------------------------- "$desc" PROCESS STARTING... -------------------------------"
	#If variable commit_list is empty, then no file was added,
	#othewise created a directory to hold the newly created files
	if [ ! -z "$commit_list" ]; 
	then
		#Use readarray or mapfile to read many lines into an array. read usually reads until it reaches newline
		readarray -t filesArray <<< "$commit_list"
			
		#copy the actual files from the azure source directory into NewFilesDirectory
        for fileName in ${filesArray[*]};
        do
            if [ -f "$fileName" ]; 
            then
                echo "Copying New File: $fileName To "$NewFilesDirectory""
                cp "$AzureSourceHomeDirectory"/"$fileName" "$NewFilesDirectory"
            else 
                echo "$fileName does not exist."
            fi
		done
		#store the file absolute path in a text file
		echo "$commit_list" >> newFilesPath.txt
		echo

		#copy the text file in the NewFilesDirectory
		echo "Copying newFilesPath.txt to "$NewFilesDirectory""
		cp newFilesPath.txt "$NewFilesDirectory"
		echo
	fi	
	echo "File Operation, "$desc" Completed"
	echo ""$desc" PROCESS COMPLTED"
	echo
}

#function to check for modified files
check_modified_files() {
	desc=$1
	commit_list=$2
	
	echo "------------------------------- "$desc" PROCESS STARTING... -------------------------------"
	#If variable commit_list is empty, then no file was added,
	#othewise created a directory to hold the modified files
	if [ ! -z "$commit_list" ]; 
	then
		#Use readarray or mapfile to read many lines into an array. read usually reads until it reaches newline
		readarray -t filesArray <<< "$commit_list"
			
		#copy the actual files from the azure source directory into ModifiedFilesDirectory
        for fileName in ${filesArray[*]};
        do
            if [ -f "$fileName" ]; 
            then
                echo "Copying Modified: $fileName To "$ModifiedFilesDirectory""
                cp "$AzureSourceHomeDirectory"/"$fileName" "$ModifiedFilesDirectory"
            else
                echo "$fileName does not exist."
            fi
		done
			
		#store the absolute file path in a text file
		touch modifiedFilesPath.txt
		echo "$commit_list" >> modifiedFilesPath.txt
		echo

		#copy the text file in the ModifiedFilesDirectory
		echo "Copying modifiedFilesPath.txt to "$ModifiedFilesDirectory""
		cp modifiedFilesPath.txt "$ModifiedFilesDirectory"
		echo
	fi
	echo "File Operation, "$desc" Completed"
	echo ""$desc" PROCESS COMPLTED"
	echo
}

#function to check for renamed files
#renaming is just deleting the old file and creating a new file with a different name
#assume we rename a file from FRENCH/scripts/ubpdp045.scr to FRENCH/scripts/Renamed_ubpdp045.scr
check_remaned_files() {
	desc=$1
	commit_list=$2
	
	echo "------------------------------- "$desc" PROCESS STARTING... -------------------------------"
	#If variable commit_list is empty, then no file was renamed,
	if [ ! -z "$commit_list" ]; 
	then
		#Use readarray or mapfile to read many lines into an array. read usually reads until it reaches newline
		readarray -t filesArray <<< "$commit_list"
		
		#commit_list has the already renamed file name ie FRENCH/scripts/Renamed_ubpdp045.scr
		#we need to get the original file name ie FRENCH/scripts/ubpdp045.scr
        for fileName in ${filesArray[*]};
        do
			output=$(git log --follow --patch --max-count=1 -- "$fileName") #get the history of the renamed file, limiting output to the single most recent commit 
			rename_from_line=$(echo "$output" | grep '^rename from ') #the output = rename from FRENCH/scripts/ubpdp045.scr
			original_filename=$(echo "$rename_from_line" | cut -d ' ' -f 3) #extract the third word from the output
			echo "The File Was Renamed From: "$original_filename" To "$fileName""
			echo
			
			#call deleted file function to add the original file name in the delete list
			delete_commit_list="$original_filename"
			check_deleted_files "RENAMING FILE: CALLING DELETION FUNCTION" "$delete_commit_list"
			
			#call new file function to add the renamed file in the new file list
			check_new_files "RENAMING FILE: CALLING NEW FILE FUNCTION" "$fileName"
		done
	fi
	echo "File Operation, "$desc" Completed"
	echo ""$desc" PROCESS COMPLTED"
	echo
}

#Creating the necessary directories
create_directory "$NewFilesDirectory"
create_directory "$DeletedFilesDirectory"
create_directory "$ModifiedFilesDirectory"
create_directory "$FinacleFileTypeDirectory"

#Creating the necessary files
create_file "$newFile"
create_file "$deletedFile"
create_file "$modifiedFile"
create_file "$finacleFileType"

cd "$AzureSourceHomeDirectory"
#get last 2 commit ids
COMMIT_LOG_DESC=$(git log -2 --format=format:%h)
echo "Commit Log Description: "$COMMIT_LOG_DESC""
echo

#Use readarray or mapfile to read many lines into an array. read usually reads until it reaches newline
readarray -t array <<< $COMMIT_LOG_DESC 
echo "Array Contents:"
echo "${array[*]}"
echo

#COMMIT_ID is the second item of the array, since we are going to do a pull request which will create a new commit id (the first item in the array)
COMMIT_ID=${array[1]} 
echo "COMMIT_ID: "$COMMIT_ID""
echo

#get the author name for the commit id
AUTHOR=$(git show --pretty=format:"%an" "$COMMIT_ID" | head -1)
echo "The Current Git Author For Commit ID "$COMMIT_ID" Is: "$AUTHOR""
echo 

#check if the last commit has a new file using A filter
NEW_FILES_COMMIT_LIST=$(git show --diff-filter A --name-only --format=tformat: "$COMMIT_ID")
echo "List Of Git New Files Added:"
echo "$NEW_FILES_COMMIT_LIST"
echo 

#check if the last commit has a copy operation using C filter
COPY_FILES_COMMIT_LIST=$(git show --diff-filter C --name-only --format=tformat: "$COMMIT_ID")
echo "List Of Git Copied Files:"
echo "$COPY_FILES_COMMIT_LIST"
echo

#check if the last commit has a deleted file using D filter
DELETED_FILES_COMMIT_LIST=$(git show --diff-filter D --name-only --format=tformat: "$COMMIT_ID")
echo "List Of Git Deleted Files:"
echo "$DELETED_FILES_COMMIT_LIST"
echo

#check if the last commit has a modified file using M filter
MODIFIED_FILES_COMMIT_LIST=$(git show --diff-filter M --name-only --format=tformat: "$COMMIT_ID")
echo "List Of Git Modified Files:"
echo "$MODIFIED_FILES_COMMIT_LIST"
echo

#check if the last commit has a file that was renamed using R filter
RENAME_FILES_COMMIT_LIST=$(git show --diff-filter R --name-only --format=tformat: "$COMMIT_ID")
echo "List Of Renamed Files:"
echo "$RENAME_FILES_COMMIT_LIST"
echo

#check if the last commit has a type change using T filter
TYPE_FILES_COMMIT_LIST=$(git show --diff-filter T --name-only --format=tformat: "$COMMIT_ID")
echo "List Of Git Files With Updated File Type:"
echo "$TYPE_FILES_COMMIT_LIST"
echo

#call if check_new_files if NEW_FILES_COMMIT_LIST is not empty
if [ ! -z "$NEW_FILES_COMMIT_LIST" ]; 
then
	#call function to check if the last commit has new files
	check_new_files "CHECKING FOR NEW FILES" "$NEW_FILES_COMMIT_LIST"
fi

#call if check_modified_files if COPY_FILES_COMMIT_LIST is not empty
if [ ! -z "$COPY_FILES_COMMIT_LIST" ]; 
then
	#call function to check if the last commit has a copy operation
	check_modified_files "CHECKING FOR COPIED FILES" "$COPY_FILES_COMMIT_LIST"
fi

#call if check_deleted_files if DELETED_FILES_COMMIT_LIST is not empty
if [ ! -z "$DELETED_FILES_COMMIT_LIST" ]; 
then
	#call function to check if the last commit has deleted files
	check_deleted_files "CHECKING FOR DELETED FILES" "$DELETED_FILES_COMMIT_LIST"
fi

#call if check_modified_files if MODIFIED_FILES_COMMIT_LIST is not empty
if [ ! -z "$MODIFIED_FILES_COMMIT_LIST" ]; 
then
	#call function to check if the last commit has a modified file
	check_modified_files "CHECKING FOR MODIFIED FILES" "$MODIFIED_FILES_COMMIT_LIST"
fi

#call if check_modified_files if TYPE_FILES_COMMIT_LIST is not empty
if [ ! -z "$TYPE_FILES_COMMIT_LIST" ]; 
then
	#call function to check if the last commit has a file type change
	check_modified_files "CHECKING FOR FILES WITH TYPE CHANGE" "$TYPE_FILES_COMMIT_LIST"
fi

#call if check_remaned_files if RENAME_FILES_COMMIT_LIST is not empty
if [ ! -z "$RENAME_FILES_COMMIT_LIST" ]; 
then
	#call function to check if the last commit has a file that was renamed
	check_remaned_files "CHECKING FOR RENAMED FILES" "$RENAME_FILES_COMMIT_LIST"
fi

echo "------------------------------- CHECKING AND COPYING FINACLE FILE TYPE -------------------------------"
echo

echo "Checking Finacle File Type"
check_file_type "newFilesPath.txt " newFilesPath.txt
check_file_type "deletedFilesPath.txt" deletedFilesPath.txt
check_file_type "modifiedFilesPath.txt" modifiedFilesPath.txt

#copyig finacleFileType.txt To FinacleFileTypeDirectory"
copying_file_type "finacleFileType.txt" finacleFileType.txt
		
echo "------------------------------- LISTING CONTENTS OF FILES AND DIRECTORIES -------------------------------"
echo

echo
echo "Listing contents of new files directory "$NewFilesDirectory""
ls -la "$NewFilesDirectory"
echo

echo "Listing contents of modified files directory "$ModifiedFilesDirectory""
ls -la "$ModifiedFilesDirectory"
echo

echo "Listing contents of deleted files directory "$DeletedFilesDirectory""
ls -la "$DeletedFilesDirectory"
echo

#list the contents of the respective txt files
echo
echo "Listing Contents of finacleFileType.txt"
cat finacleFileType.txt
echo

echo
echo "Listing Contents of newFilesPath.txt"
cat newFilesPath.txt
echo

echo
echo "Listing Contents of deletedFilesPath.txt"
cat deletedFilesPath.txt
echo

echo
echo "Listing Contents of modifiedFilesPath.txt"
cat modifiedFilesPath.txt
echo

echo "------------------------------- CHECK FOR NEW/MODIFIED FILES PROGRAM COMPLETED. EXITING THE PROGRAM... -------------------------------"
exit 0