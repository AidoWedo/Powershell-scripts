($ipv4 = Get-NetIPAddress -InterfaceAlias 'Ethernet 2' | select IPV4Address | ft -HideTableHeaders | Out-String).Trim()
Invoke-SQLcmd -Query "Update [LogRhythmEMDB].[dbo].[Mediator] set SecondaryServerIP = ('$ipv4') where MediatorID=1"
Invoke-SQLcmd -Query "Update [LogRhythmEMDB].[dbo].[Mediator] set SecondaryServerIP = ltrim(rtrim(replace(SecondaryServerIP, char(160), char(32))))"
Invoke-SQLcmd -Query "Update [LogRhythmEMDB].[dbo].[Mediator] set SecondaryServerIP = ltrim(rtrim(replace(SecondaryServerIP, char(13), char(32))))"
Invoke-SQLcmd -Query "Update [LogRhythmEMDB].[dbo].[Mediator] set SecondaryServerIP = ltrim(rtrim(replace(SecondaryServerIP, char(10), char(32))))"
Restart-Service -Name "scmedsvr"
