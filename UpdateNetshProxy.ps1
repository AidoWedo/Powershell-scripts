# Author Richard Bevan
# Version 0.1
# Purpose - To get around the fact that we are using both DHCP and Static IP addresses on a loopback adapter
# We are getting the ip address of Ethernet 2 (DHCP address) then cutting out the guff and then applying this to a port proxy
# However the syslog relay settings have no idea about this new ipv4 address so we have to update MS SQL to tell the agent about this
($ipv4 = Get-NetIPAddress -InterfaceAlias 'Ethernet 2' | select IPV4Address | ft -HideTableHeaders | Out-String).Trim()
# Let's strip all of these extra characters out of the ipv4 as trim doesn't see to do nothing !
$ipv4 = [string]::join("",($ipv4.split("`n")))
$ipv4 = [string]::join("",($ipv4.split("`r")))
# Lets use netsh to do some port proxying 
netsh interface portproxy add v4tov4 listenport=514 connectport=514 listenaddress=192.168.99.10 connectaddress=$ipv4
# Lets stop the System Monitor Agent Service and log generator
Stop-service scsm
Stop-service lrloggen
Invoke-SQLcmd -Query "Update [LogRhythmEMDB].[dbo].[SystemMonitor] set SyslogParsedHosts = ('192.168.99.10' + CHAR(13) + CHAR(10) + '$ipv4') where SystemMonitorID=2"
Start-service scsm
Start-service lrloggen