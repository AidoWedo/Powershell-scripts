# Author Richard Bevan
# Version 0.1
# Purpose - get ip address of the system, stop LogRhythm Log generator and update the ini file with ip address of the system and restart service
# In addition stop the system monitor agent, update the Syslog relay settings and add the current ip address into the relay settings
($ipv4 = Get-NetIPAddress -InterfaceAlias 'Ethernet 2' | select IPV4Address | ft -HideTableHeaders | Out-String).Trim()
# Let's strip all of these extra characters out of the ipv4 as trim doesn't see to do nothing !
$ipv4 = [string]::join("",($ipv4.split("`n")))
$ipv4 = [string]::join("",($ipv4.split("`r")))
# Useful to see extra characters in your string shows them as integer values (ascii)
#$ipv4 -split '' | %{ [int][char]$_ }
Stop-service lrloggen
$path = "C:\Program Files (x86)\LogRhythm\LogRhythm Log Generator\"
Set-Location $path
Copy-Item lrloggen.ini "lrloggen.ini.$(get-date -f yyyMMdd)" -Force
(Get-content "C:\Program Files (x86)\LogRhythm\LogRhythm Log Generator\lrloggen.ini" -RAW) -replace "192.168.99.10","$ipv4"
# Lets stop the System Monitor Agent Service
Stop-service scsm
Invoke-SQLcmd -Query "Update [LogRhythmEMDB].[dbo].[SystemMonitor] set SyslogParsedHosts = ('192.168.99.10' + CHAR(13) + CHAR(10) + '$ipv4') where SystemMonitorID=2"
Start-service scsm
Start-service lrloggen