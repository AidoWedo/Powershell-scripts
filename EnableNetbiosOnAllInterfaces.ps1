# Author Richard Bevan
# Set All Adapter to have NetBios Enabled
# Each Virtual Machine in the 7.5 306 Class has different Interface address so rather than figure it out each time, blast those settings everywhere - abit lazy
$adapters=(gwmi win32_networkadapterconfiguration )
Foreach ($adapter in $adapters){
  Write-Host $adapter
  $adapter.settcpipnetbios(1)
  }