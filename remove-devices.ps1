$deviceName="HP E24m G4 USB Audio", "HP E243d Audio", "HP 27m G4 USB Audio", "HP E27m G4 USB Audio", "USB Audio"
foreach($device in $deviceName){
  foreach ($dev in (Get-PnpDevice | Where-Object{$_.Name -eq $device})) {
    &"pnputil" /disable-device $dev.InstanceId 
  }
}

Write-Output $dev, $deviceName
pnputil.exe /scan-devices
