@echo off

REM $Author: Jamuna G$
REM To compile the java files

@set file_Path=%1

IF NOT DEFINED file_Path GOTO compile
javac %file_Path%
GOTO exit

:compile
javac  *.java 

:exit
