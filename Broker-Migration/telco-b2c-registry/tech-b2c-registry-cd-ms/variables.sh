#! /bin/bash

# -------------------------- This file holds all the dynamic variables. They should be specified first --------------------------

# application start class
startClass=com.equitybank.gag.registry.TelcoB2cRegistryApplication

# java path in the server (escape forward slash '/' with '\')
# java 8 : /u01/gag/jdk/jdk1.8.0_181/bin/java
#javaPath="\/u01\/gag\/jdk\/jdk1.8.0_181\/bin\/java"

# java 11 : /u01/gag/jdk/jdk-11.0.11/bin/java"
javaPath="\/u01\/gag\/sw\/jdk-17.0.6\/bin\/java"


# building jar name
jarFileName=tech-b2c-registry-cd-ms-0.0.1-SNAPSHOT.jar

# application name
applicationName=tech-b2c-registry-cd-ms

# home directory of the application
applicationPath=/u01/gag/drcb2c/

# escape forward slash '/' with '\'
applicationPathEsc="\/u01\/gag\/drcb2c\/"