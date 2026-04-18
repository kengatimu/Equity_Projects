#export classpath to path where xerces.jar is present

echo "Please enter the Server Root"
read SERVER_ROOT
echo "Please enter the path where ScreensOfMenus.wspc is present"
read XML_PATH
echo "Please enter the path where rolesList.lst file is present"
read ROLES_FILE_PATH
echo "Plase enter the Language to be used in Workflow Display[default INFENG]"
read LANG_CODE

#cp $XML_PATH/ScreensOfMenus.wspc .
#\mv ScreensOfMenus.wspc ScreensOfMenus.xml
java WorkflowXmlGen $SERVER_ROOT $LANG_CODE
#\rm ScreensOfMenus.xml
