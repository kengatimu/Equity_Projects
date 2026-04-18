############################  newrepos.com   #############################
#  This shell script creates a new repository and initialises it with
#       the given values. For this it creates a temporary mrt file
#       and generates statement set <reposVarname> = <values> in the 
#       ONSTARTOFREPORT Section.
# CALL AS
#       newrepos.com reposname inpdatefile
#                    where reposname is the name of the new repository
#						   to be created
#                          inpdatafile is the file containing the variables
#                          and its initial value in the format
#                            varname=value   (without space in middle)
#   Sample Data File could look like
# x1="Infosys Technologies Ltd"
# x2="Bancs2K"
# n1=2121.12
#                Thus after running the script repository will have 3 more
#                variables x1, x2 and n1
##########################################################################
# Modification History : 
# Sl#  Date      Author        Modification
# ---  --------  -----------   --------------------------------------
# 1.   04/09/95  C.S. PRASAD   Original Version
#########################################################################

echo "prak1" >1.log

MRT_NAME=_try$$.mrt
REPOS_NAME=$1
DATA_FILE=$2

if  [ $# != 2 ]
then
	echo Invalid Number of parameters \[$#\]
	echo Usage  :	$0 \<reposName\> \<dataFileName\>
	exit
fi

echo "hello" >2.log
if [ ! -f $DATA_FILE ]
then
	echo "unable to open the input file " \[$DATA_FILE\]
	exit
fi

#############  Actual temporary mrt file is created here  ##############
#    First three mandotary sections 

echo RECORDLAYOUT > $MRT_NAME
echo "Hello" > 3.log
echo LOCALVARIABLES >> $MRT_NAME
echo GROUPANDSORT >> $MRT_NAME
echo REPOSITORY argv4 >> $MRT_NAME
sed 's/=[ 	]*".*/ stringType/g' $DATA_FILE | grep stringType >> $MRT_NAME
sed 's/=[0-9]*$/ numberType/g' $DATA_FILE | grep numberType >> $MRT_NAME

echo ONSTARTOFREPORT >> $MRT_NAME
sed 's/^/set /g' $DATA_FILE >> $MRT_NAME

/bin/rm -f __$$A __$$B > /dev/null 2>&1
touch __$$A __$$B $REPOS_NAME

#########   Here in BANCS2K mrbx4001 is the exe name for mr   ##########
exebatch mrbx4001 $MRT_NAME __$$A __$$B $REPOS_NAME


/bin/rm -f __$$A __$$B $MRT_NAME > /dev/null 2>&1

