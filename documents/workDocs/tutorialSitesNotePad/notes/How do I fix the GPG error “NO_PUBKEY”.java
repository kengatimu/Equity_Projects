Execute the following commands in terminal

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys <PUBKEY>

where <PUBKEY> is your missing public key for repository, e.g. 8BAF9A6F.

Then update

sudo apt-get update
ALTERNATE METHOD:

sudo gpg --keyserver pgpkeys.mit.edu --recv-key  <PUBKEY>
sudo gpg -a --export <PUBKEY> | sudo apt-key add -
sudo apt-get update
