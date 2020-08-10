# Update DNS Record to be correct ip address
# Update various DNS records to point to IP address
# Whats the problem on a lab machine without a static ip address, each time the machine comes up the records don't match the DNS records.
# NetLogon will fix some of them but not all of them
# Assumptions Machine is called lrvm-ad change it
# Assumption 2 Domain is called bbte.local
# Author Richard Bevan
$oldobj = get-dnsserverresourcerecord -name lrvm-ad -ZoneName bbte.local -RRType A
$newobj = get-dnsserverresourcerecord -name lrvm-ad -ZoneName bbte.local -RRType A
$updateip = (Test-connection -ComputerName $env:ComputerName -Count 1).IPV4Address.IPAddressToString
$newobj.recorddata.ipv4address=[System.Net.IPAddress]::parse($updateip)
# Update Host Record however this should be done by netlogon service
set-dnsserverresourcerecord -NewInputObject $newobj -OldInputObject $oldobj -ZoneName bbte.local -passthru
# Update Server DNS address
Set-DnsClientServerAddress -InterfaceIndex 9 -ServerAddress ($updateip)
# Lets wait a bit
Start-Sleep -s 15
# Update DNS records for SRV Record DomnainDNSZones, ForestDNSZones and gc._msdcs
# Update gc._msdcs  first
$oldobj = get-dnsserverresourcerecord -name "gc._msdcs" -ZoneName bbte.local -RRType A
$newobj = get-dnsserverresourcerecord -name "gc._msdcs" -ZoneName bbte.local -RRType A
$updateip = (Test-connection -ComputerName $env:ComputerName -Count 1).IPV4Address.IPAddressToString
$newobj.recorddata.ipv4address=[System.Net.IPAddress]::parse($updateip)
set-dnsserverresourcerecord -NewInputObject $newobj -OldInputObject $oldobj -ZoneName bbte.local -passthru
# Lets wait a bit
Start-Sleep -s 15
# Update ForestDnsZone first
$oldobj = get-dnsserverresourcerecord -name "ForestDnsZones" -ZoneName bbte.local -RRType A
$newobj = get-dnsserverresourcerecord -name "ForestDnsZones" -ZoneName bbte.local -RRType A
$updateip = (Test-connection -ComputerName $env:ComputerName -Count 1).IPV4Address.IPAddressToString
$newobj.recorddata.ipv4address=[System.Net.IPAddress]::parse($updateip)
set-dnsserverresourcerecord -NewInputObject $newobj -OldInputObject $oldobj -ZoneName bbte.local -passthru
# Lets wait a bit
# Update DomainDnsZone first
Start-Sleep -s 15
$oldobj = get-dnsserverresourcerecord -name "DomainDnsZones" -ZoneName bbte.local -RRType A
$newobj = get-dnsserverresourcerecord -name "DomainDnsZones" -ZoneName bbte.local -RRType A
$updateip = (Test-connection -ComputerName $env:ComputerName -Count 1).IPV4Address.IPAddressToString
$newobj.recorddata.ipv4address=[System.Net.IPAddress]::parse($updateip)
set-dnsserverresourcerecord -NewInputObject $newobj -OldInputObject $oldobj -ZoneName bbte.local -passthru