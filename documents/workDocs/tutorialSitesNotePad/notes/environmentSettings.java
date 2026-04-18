*******************************************************************************************
TomCat

Environment=JAVA_HOME="/usr/lib/jvm/jdk1.8.0_241"
Environment=CATALINA_PID="/opt/tomcat/temp/tomcat.pid"
Environment=CATALINA_HOME="/opt/tomcat"
Environment=CATALINA_OPTS="-Xms512M -Xmx1G -Djava.net.preferIPv4Stack=true"
Environment=JAVA_OPTS="-Djava.awt.headless=true"

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh
SuccessExitStatus=143

User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always
*******************************************************************************************

Oracle

Environment=ORACLE_HOME="/home/kennedy/Oracle/Middleware/Oracle_Home"
Environment=JDEV_HOME="/home/kennedy/Oracle/Middleware/Oracle_Home/jdeveloper"

JDeveloper
Starting Oracle JDeveloper 
To start Oracle JDeveloper on Linux and UNIX, do the following:

Navigate to the following location on your system:
/home/kennedy/Oracle/Middleware/Oracle_Home/jdeveloper/jdev/bin/
	
Run the following command:
./jdev
*******************************************************************************************

Oracle DB

Performing root user operation.

The following environment variables are set as:
    ORACLE_OWNER= kennedy
    ORACLE_HOME=  /home/oracle/product/12.2.0/dbhome_1



*******************************************************************************************

Java

Environment="JAVA_HOME=/usr/lib/jvm/jdk1.8.0_241"

Configuring JAVA_HOME:
https://community.linuxmint.com/tutorial/view/1372

Making JDK default
$sudo update-alternatives --config java

sudo update-alternatives --config java will return following output

$ sudo update-alternatives --config java
There are 2 choices for the alternative java (providing /usr/bin/java).

  Selection    Path                                      Priority   Status
------------------------------------------------------------
* 0            /usr/lib/jvm/java-6.31-oracle/bin/java     1062      auto mode
  1            /usr/lib/jvm/java-6-openjdk/jre/bin/java   1061      manual mode
  2            /usr/lib/jvm/java-6.31-oracle/bin/java     1062      manual mode

Press enter to keep the current choice[*], or type selection number:

*******************************************************************************************
Copying Jar File for Deployement

kennedy@kennedy-HP-ProBook-450-G5 ~/bishopHP/programming/projects/work/DeploymentsArtifacts $ scp SmartErp.jar kgatimu@10.1.12.140:.


