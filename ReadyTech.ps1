# Initialise Logger
Initialize-logger -LoggerName "ReadyTeachViewer" -loglevel debug
# Read ReadyTech rt_deployment File for Values
$path = "c:\rt_deployment.txt"
$values = [pscustomobject](Get-Content $path -Raw | ConvertFrom-StringData)

# ReadyTech Service Monitoring and Restart of Viewer Service
$ServiceName = 'ReadyTech Viewer Server Service'
$arrService = Get-Service -Name $ServiceName

while ($arrService.Status -ne 'Running')
{

    # Start-Service $ServiceName
    Restart-Service $ServiceName -force 
    Get-Service $ServiceName | Select-Object -expand dependentservices | Start-Service
    write-LogTitle "ReadyTech Viewer Status" | write-LogObject ($arrService.status)
    Write-LogTitle "ReadyTech Viewer Starting" | write-LogObject ($ServiceName)
    Start-Sleep -seconds 60
    $arrService.Refresh()
    if ($arrService.Status -eq 'Running')
    {
        Write-Host $ServiceName "Service is now Running"
    }

}

