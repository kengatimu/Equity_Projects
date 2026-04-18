SOA connections
*******************************************************************************************
10.1.12.140 SSH

ssh -L 5901:10.1.12.140:5901 -L 6001:10.1.12.140:6001 kgatimu@10.1.12.140

Then VNC with below;
localhost:1

Service Bus Console
10.1.87.60:7001/sbconsole
	weblogic@Oracle123
	
External OAG
$ ssh -X oracle@uatagwn01
password: oracle

OAG console
External OAG
https://uatagwn01.ebsafrica.com:8090
admin@changeme


Internal OAG
https://uatagin01.ebsafrica.com:8090
admin@Oracle123

ssh -X pkathae@uatagin01
Password


go to policy studio
$ cd /u02/oracle/products/fmw11123/oag/oagpolicystudio/
$ ./policystudio

Getting https certificates: 
$ ssh -X oracle@uatagwn01
$ openssl s_client -showcerts -connect data.smartapplicationsgroup.com:443

*******************************************************************************************
	
JDeveloper
Starting Oracle JDeveloper 
To start Oracle JDeveloper on Linux and UNIX, do the following:

Navigate to the following location on your system:
/home/kennedy/Oracle/Middleware/Oracle_Home/jdeveloper/jdev/bin/
	
Run the following command:
./jdev
*******************************************************************************************
Oracle Middleware

JDev

VNC: 10.1.12.140
*******************************************************************************************
Copying Jar File for Deployement

kennedy@kennedy-HP-ProBook-450-G5 ~/bishopHP/programming/projects/work/DeploymentsArtifacts $ scp SmartErp.jar kgatimu@10.1.12.140:.

*******************************************************************************************
Azure Dev
https://dev.azure.com/ICT-DevOps/SOA%20Projects/_sprints/taskboard/SOA%20Projects%20Team/SOA%20Projects/Sprint%202

wsuat.equitybank



