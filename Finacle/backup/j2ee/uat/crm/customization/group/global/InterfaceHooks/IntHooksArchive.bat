@echo off

REM $Author: Jamuna G$
REM Prerequiste - compile the required ( customised ) java programs under InterfaceHooks


REM IntHooksArchive - To replace the customized InterfaceHooks files into Interface.jar
REM Pass the full path of the Interface.jar as a parameter for this program during exection


REM This BAT file unjar the Interface.jar  specified in the parameter 
REM Replaces the new class files under the custom directory
REM creates a new jar named InterfaceCustom.jar 

REM set the Interface.jar path as parameter
@set Interfacejar_Path=%1

If NOT DEFINED Interfacejar_Path  GOTO exit

REM extract the Interface.jar file under InterfaceHooks folder
jar -xvf %Interfacejar_Path% 

REM Replaces the class files under the extracted custom folder
REM If any change in packaging the following path needs to be changed
@set Extract_path="./\com\infy\intl\custom"
if exist %Extract_path% replace *.class %Extract_path%


REM Create InterfaceCustom.jar file
jar -cvf InterfaceCustom.jar com

REM Delete the extracted folders
 rmdir /S /Q com
 rmdir /S /Q META-INF

GOTO done

:exit
  echo ERROR: Enter Interface.jar path as parameter

:done

