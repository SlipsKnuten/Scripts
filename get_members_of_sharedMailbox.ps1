#Dessa behöver hämtas och installeras innan man kör scriptet

Install-Module ImportExcel -AllowClobber -Force
Import-Module ExchangeOnlineManagement
Install-Module ExchangeOnlineManagement

Get-Module ImportExcel -ListAvailable | Import-Module -Force -Verbose
Connect-ExchangeOnline

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Namn på gruppen'
$form.Size = New-Object System.Drawing.Size(300,200)
$form.StartPosition = 'CenterScreen'

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(75,120)
$okButton.Size = New-Object System.Drawing.Size(75,23)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(150,120)
$cancelButton.Size = New-Object System.Drawing.Size(75,23)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Skriv in namnet på gruppbrevlådan'
$form.Controls.Add($label)

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10,40)
$textBox.Size = New-Object System.Drawing.Size(260,20)
$form.Controls.Add($textBox)

$form.Topmost = $true

$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog()

$path =  "C:\Users\$env:username\OneDrive - Folksam\Skrivbordet\Office365GroupMembers.xlsx"
if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $textInput = $textBox.Text
    Get-Mailbox -Identity $textInput -Filter {recipienttypedetails -eq "SharedMailbox"} | Get-Mailboxpermission | Export-Excel -path $path

}
write-host $path