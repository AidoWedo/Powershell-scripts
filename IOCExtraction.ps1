# Author Richard Bevan
# Pull IOC Data from Recorded Future Cyber Emails Emails
# Save the email as txt and read file and extract data
# File Location change Input and output and regex
# Replace <path_to_IOC_File>\ with whatever
$input_path = "C:\<path_to_IOC_File>\Cyber Daily.txt"
$ioc_output = "C:\<path_to_IOC_File>\ioc.txt"
$regex = '^\d+\[\.\]\d+\[\.\]\d+\[\.\]\d+'
select-string -Path $input_path -Pattern $regex -AllMatches | % { $_.Matches } | % { $_.Value } > $ioc_output
# Replace the [.] in the IP adress
(Get-Content C:\<path_to_IOC_File>\ioc.txt).replace('[', '') | Set-Content C:\<path_to_IOC_File>\ioc.txt
(Get-Content C:\<path_to_IOC_File>\ioc.txt).replace(']', '') | Set-Content C:\<path_to_IOC_File>\ioc.txt
