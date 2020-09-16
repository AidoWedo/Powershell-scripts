$word = [Runtime.Interopservices.Marshal]::GetActiveObject('Word.Application')

$TextBoxArray = foreach ($document in $word.Documents) {
    try {
        $TargetProperties = @{ }
        foreach ($textbox in $document.FormFields) {
            $TargetProperties.Add($textbox.OLEFormat.Object.Name, $textbox.OLEFormat.Object.Value)
        }
        [PSCustomObject]$TargetProperties
    }
    catch {
        Continue
    }
}