#########################################################################################
#                                                                                       #
#       This com script is being used for the TBA FORM bafe3013.make (Open     		#
#       an Account) to achieve the below objective:                                     #
#               1) Users in the list $TBA_PROD/uid/OAACFreeUser.dat should only      #
#                  be allowed to open accounts in other Sols (Sols other than the       #
#                  Primary Sol Id of the User).                                         #
#                                                                                       #
#       Assumptions      : The User is a free user. Also, the Mod Tenor of OAAC is Free.#
#			   The User Id of the users who should be allowed to open 	#
#			   Accounts in other Sol should be listed in 			#
#			   $TBA_PROD/uid/OAACFreeUser.dat in the form OAAC|User Id	#
#			   in Capitals.							#
#       Author           : T.Guhan                                                      #
#       Date of Creation : 14-11-2002                                                   #
#	Called by	 : ChkMenuUser.scr						#
#                                                                                       #
#########################################################################################

outFile=$1
menuUser=$2
grep "^$menuUser" $TBA_PROD/uid/OAACFreeUser.dat > /dev/null
if [ $? -eq 0 ]
then
	echo "BANCS.STDIN.successOrFailure=\"S\"" > ${outFile}
	exit 0
else
	echo "BANCS.STDIN.successOrFailure=\"F\"" > ${outFile}
fi
exit 1
