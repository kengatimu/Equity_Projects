Linux IP Updater for Dynamic Networks

 
Overview
 
This Knowledge Base article will show you how to set up an IP updater on Linux, in order to keep the dynamic IP address of your network up to date.

Linux IP updater - Installing
 
You can also install it by executing sudo apt-get install ddclient in a terminal. 
Please keep in mind that this command works only on Debian-based distributions. For RPM-based distributions, please try sudo yum install ddclient.

Linux IP updater - Configuration

To use ddclient with OpenDNS, after you install it on your machine, you have to set it up properly by modifying its configuration file which is located at /etc/ddclient.conf. Please use the following configuration outline, while supplementing the account login, password, and network label lines:  

##
## OpenDNS.com account-configuration
##
protocol=dyndns2
use=web, web=myip.dnsomatic.com
ssl=yes
server=updates.opendns.com
login=opendns_username
password=‘opendns_password’
opendns_network_label


The login is your email address with OpenDNS.
If you have special characters in your password wrap the password in single-quotes ( ' ). If there are any single-quotes in your password, put backslash ( \ ) before the single-quote to escape the character.
'opendns_network_label' is the label given to the network you're updating in your account. You can find the network label in the Settings Tab of the OpenDNS Dashboard.  If you're an Umbrella customer, this is the name of the Network you've enabled Dynamic updates for in the Configuration. If you have spaces in your network label, replace them with an underscore ( _ )

Linux IP updater - Starting

In order to turn on the updater, please execute the command sudo service ddclient start in a terminal. You can check its status with sudo service ddclient status and you can stop it with the command sudo service ddclient stop. Please keep in mind that ddclient doesn't automatically start when your system boots.

 To Run ddclient in Deamon Mode;
 sudo vim /etc/default/ddclient
 
 Linux IP updater - Useful commands
 
kennedy@kennedy-HP-ProBook-450-G5 ~ $ sudo service ddclient force-reload 
kennedy@kennedy-HP-ProBook-450-G5 ~ $ sudo service ddclient restart
kennedy@kennedy-HP-ProBook-450-G5 ~ $ sudo service ddclient status 
● ddclient.service - LSB: Update dynamic domain name service entries
   Loaded: loaded (/etc/init.d/ddclient; bad; vendor preset: enabled)
   Active: active (running) since Fri 2020-05-01 11:20:08 EAT; 2s ago
     Docs: man:systemd-sysv-generator(8)
  Process: 9827 ExecStop=/etc/init.d/ddclient stop (code=exited, status=0/SUCCESS)
  Process: 9833 ExecStart=/etc/init.d/ddclient start (code=exited, status=0/SUCCESS)
   CGroup: /system.slice/ddclient.service
           └─4772 ddclient - sleeping for 30 second

May 01 11:20:08 kennedy-HP-ProBook-450-G5 systemd[1]: Starting LSB: Update dynamic domain name service entries...
May 01 11:20:08 kennedy-HP-ProBook-450-G5 ddclient[9833]:  * To run ddclient as a daemon, please set run_daemon to 'true' in /
May 01 11:20:08 kennedy-HP-ProBook-450-G5 ddclient[9833]:    ...done.
May 01 11:20:08 kennedy-HP-ProBook-450-G5 systemd[1]: Started LSB: Update dynamic domain name service entries.
lines 1-13/13 (END)
 


Troubleshooting
 
Your IP address belongs to a different network

When this issue occurs, sudo service ddclient status returns the following error message:

ddclient[6951]: FAILED:   updating 'opendns_network_label': !yours: The hostname specified exists, but not under the username currently being used
This happens most often when using someone else's network (e.g. public wireless hotspot, a friend's wireless network etc.). Each OpenDNS user is uniquely identified by an IP address. If you use someone else's connection which is already configured to use the OpenDNS service, we then detect that more than one OpenDNS account claims to use the same IP address.

If you're temporarily using someone else's network connection, you can ignore this error. If you believe this IP address really belongs to you, you can contact support.

 

ddclient is stuck

When this issue occurs, sudo service ddclient status returns the following warning message:

ddclient[6978]: WARNING:  file /var/cache/ddclient/ddclient.cache, line 3: Invalid Value for keyword 'ip' = ''
This happens most often when you're trying to update your dynamic IP address many times in too short of a period by restarting the ddclient service. In this case, in order to instantly fix this issue, please delete the file /var/cache/ddclient/ddclient.cache. You can delete it by executing the command  sudo rm /var/cache/ddclient/ddclient.cache in a terminal.


Was this article helpful?
 
98 out of 115 found this helpful
Have more questions? Submit a request
Recently viewed articles
What is the OpenDNS Dynamic IP updater client?
Related articles
What is the OpenDNS Dynamic IP updater client?
Dynamic IP: General Information for OpenDNS usage
Using Dynamic DNS with OpenDNS
Ubuntu
Linux Mint/Cinnamon
OpenDNS
