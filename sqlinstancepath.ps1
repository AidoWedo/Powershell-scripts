#Get SQL Server Instance Path:
$SQLService = "SQL Server (MSI2016)";
$SQLInstancePath = "";
$SQLServiceName = ((Get-Service | WHERE { $_.DisplayName -eq $SQLService }).Name).Trim();
If ($SQLServiceName.contains("`$")) { $SQLServiceName = $SQLServiceName.SubString($SQLServiceName.IndexOf("`$")+1,$SQLServiceName.Length-$SQLServiceName.IndexOf("`$")-1) }
foreach ($i in (get-itemproperty "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server").InstalledInstances)
{
  If ( ((Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\Instance Names\SQL").$i).contains($SQLServiceName) )
  { $SQLInstancePath = "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\"+`
  (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\Instance Names\SQL").$i}
}
$SQLInstancePath