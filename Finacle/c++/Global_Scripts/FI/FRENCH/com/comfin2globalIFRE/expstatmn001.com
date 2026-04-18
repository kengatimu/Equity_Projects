#------------------------------------------------------------------------------------------
#    Name				: expstatmn001.com
#    Description     	: Com file to call expstat.sql
#    Date            	: 20-02-2013
#    Author          	: Rajavel
#    Input           	: NA
#    Output				: NA
#    Called Script	 	: NA
#    Calling Script	 	: NA
#    Menu Option		: NA
#    Modification Log   :
#    Srl. No		 Date		Author		 Description.   
#    -------		--------	------		----------------
#     1.0		   20-02-2013	Rajavel	    Original Version
#-------------------------------------------------------------------------------------
#. `execom commfunc.com`

bauu9151 expstatmn001.sql 
echo "hai" > b.txt
exit 0
