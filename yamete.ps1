$DestinationPath="$env:APPDATA\CustomSounds"
$DestinationPath=New-Item -ItemType Directory -Force -Path $DestinationPath
$SoundsSubdir="sounds"
$InsertSoundFileName="ah.wav"
$RemoveSoundFileName="yamete.wav"
$InsertSoundRegKey="HKCU:\AppEvents\Schemes\Apps\.Default\DeviceConnect\.Current"
$RemoveSoundRegKey="HKCU:\AppEvents\Schemes\Apps\.Default\DeviceDisconnect\.Current"
$InsertSoundPath="$DestinationPath\$InsertSoundFileName"
$RemoveSoundPath="$DestinationPath\$RemoveSoundFileName"

Write-Output "Copying files to: $DestinationPath"

Copy-Item "$PSScriptRoot\$SoundsSubdir\$InsertSoundFileName" -Destination $DestinationPath -Recurse
Copy-Item "$PSScriptRoot\$SoundsSubdir\$RemoveSoundFileName" -Destination $DestinationPath -Recurse

Write-Output "Setting registry values"

Set-ItemProperty -Path $InsertSoundRegKey -Name "(Default)" -Value "$InsertSoundPath"
Set-ItemProperty -Path $RemoveSoundRegKey -Name "(Default)" -Value "$RemoveSoundPath"

Write-Host -NoNewLine 'Done. Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');