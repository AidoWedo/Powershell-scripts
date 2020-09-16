# Powershell-Scripts
Various Powershell scripts for various admin type functions, they are generally all designed to get around the fact that LR needs a static IP and the training environment gives out IP's using DHCP.
Enable Net BioS - we'll enables Net Bios on all interfaces
Check Service - Checks LogRhythm SIEM Services
ReadyTech - Writes ReadyTech Cloud Hosting Lab events to the event viewer
Update DNS records - well you guessed it updates DNS records.
Disabled Windows Firewall - apart from it should be called Disable, it disables the Windows Firewall for all profiles
PSNLookupstuff - Does a lookup against a set number of domains to generate DNS traffic on a DC
ReplaceIPAddressllroggen - replaces the ip addresses in an ini file
UpdateNetshProxy - sets the netsh portproxy to listen on a particular ip address and forward it to a an address defined by $ipv4
Update Secondary Server IP Address - detects the ip address for 10.0 on a particular interface, uses this to update the LR Mediator configs
sqlinstancepath - updates the SQL listener to listen on the current ip address defined by $ipv4
