# Need to run this once to create the source
# New-Eventlog -LogName Application -Source "Remote Students ReadyTech Viewer Service Restarted"
Write-EventLog -LogName Application -Source "Remote Students ReadyTech Viewer Service Restarted" -EntryType Warning -EventID 1 -Message "Student Machine For $($values.activation_name00) the ReadyTech Viewer Service has been restarted"