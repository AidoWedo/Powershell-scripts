# Author Richard Bevan
# Purpose to disable the windows Firewall during training sessions
# PowerShell
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False