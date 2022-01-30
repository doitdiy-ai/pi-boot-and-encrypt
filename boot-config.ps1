#---------------------------------------------------------[Initialisations]--------------------------------------------------------
# Init PowerShell Gui
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$script:SDCard = $true

$TZtoOlson = @"
W. Central Africa Standard Time = Africa/Bangui
Egypt Standard Time = Africa/Cairo
Morocco Standard Time = Africa/Casablanca
South Africa Standard Time = Africa/Harare
Greenwich Standard Time = Africa/Monrovia
E. Africa Standard Time = Africa/Nairobi
Namibia Standard Time = Africa/Windhoek
Alaskan Standard Time = America/Anchorage
Argentina Standard Time = America/Argentina/San_Juan
Paraguay Standard Time = America/Asuncion
Bahia Standard Time = America/Bahia
SA Pacific Standard Time = America/Bogota
Venezuela Standard Time = America/Caracas
SA Eastern Standard Time = America/Cayenne
Central Standard Time = America/Chicago
Mountain Standard Time (Mexico) = America/Chihuahua
Central Brazilian Standard Time = America/Cuiaba
Mountain Standard Time = America/Denver
Greenland Standard Time = America/Godthab
Central America Standard Time = America/Guatemala
Atlantic Standard Time = America/Halifax
US Eastern Standard Time = America/Indianapolis
SA Western Standard Time = America/La_Paz
Pacific Standard Time = America/Los_Angeles
Mexico Standard Time = America/Mexico_City
Montevideo Standard Time = America/Montevideo
Eastern Standard Time = America/New_York
UTC-02 = America/Noronha
US Mountain Standard Time = America/Phoenix
Canada Central Standard Time = America/Regina
Pacific Standard Time (Mexico) = America/Santa_Isabel
Pacific SA Standard Time = America/Santiago
E. South America Standard Time = America/Sao_Paulo
Newfoundland Standard Time = America/St_Johns
New Zealand Standard Time = Antarctica/McMurdo
Central Asia Standard Time = Asia/Almaty
Jordan Standard Time = Asia/Amman
Arabic Standard Time = Asia/Baghdad
Azerbaijan Standard Time = Asia/Baku
SE Asia Standard Time = Asia/Bangkok
Middle East Standard Time = Asia/Beirut
India Standard Time = Asia/Calcutta
Sri Lanka Standard Time = Asia/Colombo
Syria Standard Time = Asia/Damascus
Bangladesh Standard Time = Asia/Dhaka
Arabian Standard Time = Asia/Dubai
North Asia East Standard Time = Asia/Irkutsk
Israel Standard Time = Asia/Jerusalem
Afghanistan Standard Time = Asia/Kabul
Kamchatka Standard Time = Asia/Kamchatka
Pakistan Standard Time = Asia/Karachi
Nepal Standard Time = Asia/Katmandu
North Asia Standard Time = Asia/Krasnoyarsk
Singapore Standard Time = Asia/Kuala_Lumpur
Arab Standard Time = Asia/Kuwait
Magadan Standard Time = Asia/Magadan
N. Central Asia Standard Time = Asia/Novosibirsk
West Asia Standard Time = Asia/Oral
Myanmar Standard Time = Asia/Rangoon
Korea Standard Time = Asia/Seoul
China Standard Time = Asia/Shanghai
Taipei Standard Time = Asia/Taipei
Georgian Standard Time = Asia/Tbilisi
Iran Standard Time = Asia/Tehran
Tokyo Standard Time = Asia/Tokyo
Ulaanbaatar Standard Time = Asia/Ulaanbaatar
Vladivostok Standard Time = Asia/Vladivostok
Yakutsk Standard Time = Asia/Yakutsk
Ekaterinburg Standard Time = Asia/Yekaterinburg
Armenian Standard Time = Asia/Yerevan
Azores Standard Time = Atlantic/Azores
Cape Verde Standard Time = Atlantic/Cape_Verde
Cen. Australia Standard Time = Australia/Adelaide
E. Australia Standard Time = Australia/Brisbane
AUS Central Standard Time = Australia/Darwin
Tasmania Standard Time = Australia/Hobart
W. Australia Standard Time = Australia/Perth
AUS Eastern Standard Time = Australia/Sydney
UTC = Etc/GMT
UTC-11 = Etc/GMT+11
Dateline Standard Time = Etc/GMT+12
UTC+12 = Etc/GMT-12
W. Europe Standard Time = Europe/Amsterdam
GTB Standard Time = Europe/Athens
Central Europe Standard Time = Europe/Belgrade
Romance Standard Time = Europe/Brussels
GMT Standard Time = Europe/Dublin
FLE Standard Time = Europe/Helsinki
E. Europe Standard Time = Europe/Minsk
Russian Standard Time = Europe/Moscow
Central European Standard Time = Europe/Sarajevo
Mauritius Standard Time = Indian/Mauritius
Samoa Standard Time = Pacific/Apia
Fiji Standard Time = Pacific/Fiji
Central Pacific Standard Time = Pacific/Guadalcanal
West Pacific Standard Time = Pacific/Guam
Hawaiian Standard Time = Pacific/Honolulu
Tonga Standard Time = Pacific/Tongatapu
"@
$TZtoOlsonHash = ConvertFrom-StringData $TZtoOlson

$Locales = "ar-AE","ar-BH","ar-DZ","ar-EG","ar-IQ","ar-JO","ar-KW","ar-LB","ar-LY","ar-MA","ar-OM","ar-QA","ar-SA","ar-SD","ar-SY","ar-TN","ar-YE","be-BY","bg-BG","bn-BD","bn-IN","ca-ES","cs-CZ","da-DK","de-AT","de-CH","de-DE","de-LU","el-CY","el-GR","en-AU","en-CA","en-GB","en-IE","en-IN","en-MT","en-NZ","en-PH","en-SG","en-US","en-ZA","es-AR","es-BO","es-CL","es-CO","es-CR","es-DO","es-EC","es-ES","es-GT","es-HN","es-MX","es-NI","es-PA","es-PE","es-PR","es-PY","es-SV","es-US","es-UY","es-VE","et-EE","fi-FI","fr-BE","fr-CA","fr-CH","fr-FR","fr-LU","ga-IE","hi-IN","hr-HR","hu-HU","in-ID","is-IS","it-CH","it-IT","iw-IL","ja-JP","ja-JP-JP","ko-KR","lt-LT","lv-LV","mk-MK","ms-MY","mt-MT","nl-BE","nl-NL","no-NO","no-NO-NY","pl-PL","pt-BR","pt-PT","ro-RO","ru-RU","sk-SK","sl-SI","sq-AL","sr-BA","sr-CS","sr-ME","sr-RS","sv-SE","th-TH","th-TH-TH","tr-TR","uk-UA","vi-VN","zh-CN","zh-HK","zh-SG","zh-TW"

$Countries = "AE","AL","AR","AT","AU","BA","BD","BE","BG","BH","BO","BR","BY","CA","CH","CL","CN","CO","CR","CS","CY","CZ","DE","DK","DO","DZ","EC","EE","EG","ES","FI","FR","GB","GR","GT","HK","HN","HR","HU","ID","IE","IL","IN","IQ","IS","IT","JO","JP","KR","KW","LB","LT","LU","LV","LY","MA","ME","MK","MT","MX","MY","NI","NL","NO","NY","NZ","OM","PA","PE","PH","PL","PR","PT","PY","QA","RO","RS","RU","SA","SD","SE","SG","SI","SK","SV","SY","TH","TN","TR","TW","UA","US","UY","VE","VN","YE","ZA"

#---------------------------------------------------------[Form]--------------------------------------------------------

[System.Windows.Forms.Application]::EnableVisualStyles()

$LocalBootConfigForm                    = New-Object system.Windows.Forms.Form
$LocalBootConfigForm.ClientSize         = '940,450'
$LocalBootConfigForm.text               = "Raspberry Pi First Boot Configuration"
$LocalBootConfigForm.BackColor          = "#ffffff"
$LocalBootConfigForm.TopMost            = $false

$Title                           = New-Object system.Windows.Forms.Label
$Title.text                      = "Configure SD Card for Raspberry Pi boot"
$Title.AutoSize                  = $true
$Title.width                     = 25
$Title.height                    = 10
$Title.location                  = New-Object System.Drawing.Point(20,20)
$Title.Font                      = 'Microsoft Sans Serif,13'

$Description                     = New-Object system.Windows.Forms.Label
$Description.text                = "To configure the SD card, make sure it has been freshly imaged with the Raspberry Pi Imager and that it has been re-inserted into the SD card reader and connected to this computer"
$Description.AutoSize            = $false
$Description.width               = 450
$Description.height              = 50
$Description.location            = New-Object System.Drawing.Point(20,50)
$Description.Font                = 'Microsoft Sans Serif,10'

$BootConfigStatus                   = New-Object system.Windows.Forms.Label
$BootConfigStatus.text              = "Status:"
$BootConfigStatus.AutoSize          = $true
$BootConfigStatus.width             = 25
$BootConfigStatus.height            = 10
$BootConfigStatus.location          = New-Object System.Drawing.Point(20,115)
$BootConfigStatus.Font              = 'Microsoft Sans Serif,10,style=Bold'

$BootConfigFound                    = New-Object system.Windows.Forms.Label
$BootConfigFound.text               = "Searching for BootConfig..."
$BootConfigFound.AutoSize           = $true
$BootConfigFound.width              = 25
$BootConfigFound.height             = 10
$BootConfigFound.location           = New-Object System.Drawing.Point(100,115)
$BootConfigFound.Font               = 'Microsoft Sans Serif,10'

$BootConfigDriveLabel                = New-Object system.Windows.Forms.Label
$BootConfigDriveLabel.text           = "SD Card Drive:"
$BootConfigDriveLabel.AutoSize       = $true
$BootConfigDriveLabel.width          = 25
$BootConfigDriveLabel.height         = 20
$BootConfigDriveLabel.location       = New-Object System.Drawing.Point(20,140)
$BootConfigDriveLabel.Font           = 'Microsoft Sans Serif,10,style=Bold'
$BootConfigDriveLabel.Visible        = $false

$BootConfigDrive                     = New-Object system.Windows.Forms.ComboBox
$BootConfigDrive.text                = ""
$BootConfigDrive.width               = 170
$BootConfigDrive.height              = 20
$BootConfigDrive.location            = New-Object System.Drawing.Point(150,137)
$BootConfigDrive.Font                = 'Microsoft Sans Serif,10'
$BootConfigDrive.Visible             = $false

$BootConfigDetails                  = New-Object system.Windows.Forms.Label
$BootConfigDetails.text             = "BootConfig details"
$BootConfigDetails.AutoSize         = $true
$BootConfigDetails.width            = 25
$BootConfigDetails.height           = 10
$BootConfigDetails.location         = New-Object System.Drawing.Point(20,170)
$BootConfigDetails.Font             = 'Microsoft Sans Serif,12'
$BootConfigDetails.Visible          = $false

$BootConfigModifyPWLabel                = New-Object system.Windows.Forms.Label
$BootConfigModifyPWLabel.text           = "Modify Pi Password:"
$BootConfigModifyPWLabel.AutoSize       = $true
$BootConfigModifyPWLabel.width          = 25
$BootConfigModifyPWLabel.height         = 20
$BootConfigModifyPWLabel.location       = New-Object System.Drawing.Point(20,200)
$BootConfigModifyPWLabel.Font           = 'Microsoft Sans Serif,10,style=Bold'
$BootConfigModifyPWLabel.Visible        = $false

$BootConfigModifyPW                     = New-Object system.Windows.Forms.CheckBox
$BootConfigModifyPW.location            = New-Object System.Drawing.Point(180,197)
$BootConfigModifyPW.Visible             = $false

$BootConfigPiPasswordLabel                = New-Object system.Windows.Forms.Label
$BootConfigPiPasswordLabel.text           = "Pi Password:"
$BootConfigPiPasswordLabel.AutoSize       = $true
$BootConfigPiPasswordLabel.width          = 25
$BootConfigPiPasswordLabel.height         = 20
$BootConfigPiPasswordLabel.location       = New-Object System.Drawing.Point(20,230)
$BootConfigPiPasswordLabel.Font           = 'Microsoft Sans Serif,10,style=Bold'
$BootConfigPiPasswordLabel.Visible        = $false
$BootConfigPiPasswordLabel.Enabled        = $false

$BootConfigPiPassword                     = New-Object system.Windows.Forms.TextBox
$BootConfigPiPassword.multiline           = $false
$BootConfigPiPassword.width               = 314
$BootConfigPiPassword.height              = 20
$BootConfigPiPassword.location            = New-Object System.Drawing.Point(165,227)
$BootConfigPiPassword.Font                = 'Microsoft Sans Serif,10'
$BootConfigPiPassword.Visible             = $false
$BootConfigPiPassword.Enabled         = $false

$BootConfigDecryptPasswordLabel                = New-Object system.Windows.Forms.Label
$BootConfigDecryptPasswordLabel.text           = "Decrypt Password:"
$BootConfigDecryptPasswordLabel.AutoSize       = $true
$BootConfigDecryptPasswordLabel.width          = 25
$BootConfigDecryptPasswordLabel.height         = 20
$BootConfigDecryptPasswordLabel.location       = New-Object System.Drawing.Point(20,260)
$BootConfigDecryptPasswordLabel.Font           = 'Microsoft Sans Serif,10,style=Bold'
$BootConfigDecryptPasswordLabel.Visible        = $false

$BootConfigDecryptPassword                     = New-Object system.Windows.Forms.TextBox
$BootConfigDecryptPassword.multiline           = $false
$BootConfigDecryptPassword.width               = 314
$BootConfigDecryptPassword.height              = 20
$BootConfigDecryptPassword.location            = New-Object System.Drawing.Point(165,257)
$BootConfigDecryptPassword.Font                = 'Microsoft Sans Serif,10'
$BootConfigDecryptPassword.Visible             = $false

$BootConfigSSIDLabel                = New-Object system.Windows.Forms.Label
$BootConfigSSIDLabel.text           = "WiFi Name:"
$BootConfigSSIDLabel.AutoSize       = $true
$BootConfigSSIDLabel.width          = 25
$BootConfigSSIDLabel.height         = 20
$BootConfigSSIDLabel.location       = New-Object System.Drawing.Point(20,290)
$BootConfigSSIDLabel.Font           = 'Microsoft Sans Serif,10,style=Bold'
$BootConfigSSIDLabel.Visible        = $false

$BootConfigSSID                     = New-Object system.Windows.Forms.TextBox
$BootConfigSSID.multiline           = $false
$BootConfigSSID.width               = 314
$BootConfigSSID.height              = 20
$BootConfigSSID.location            = New-Object System.Drawing.Point(165,287)
$BootConfigSSID.Font                = 'Microsoft Sans Serif,10'
$BootConfigSSID.Visible             = $false

$BootConfigSSIDPWLabel                = New-Object system.Windows.Forms.Label
$BootConfigSSIDPWLabel.text           = "WiFi Password:"
$BootConfigSSIDPWLabel.AutoSize       = $true
$BootConfigSSIDPWLabel.width          = 25
$BootConfigSSIDPWLabel.height         = 20
$BootConfigSSIDPWLabel.location       = New-Object System.Drawing.Point(20,320)
$BootConfigSSIDPWLabel.Font           = 'Microsoft Sans Serif,10,style=Bold'
$BootConfigSSIDPWLabel.Visible        = $false

$BootConfigSSIDPW                     = New-Object system.Windows.Forms.TextBox
$BootConfigSSIDPW.multiline           = $false
$BootConfigSSIDPW.width               = 314
$BootConfigSSIDPW.height              = 20
$BootConfigSSIDPW.location            = New-Object System.Drawing.Point(165,317)
$BootConfigSSIDPW.Font                = 'Microsoft Sans Serif,10'
$BootConfigSSIDPW.Visible             = $false

$BootConfigHostnameLabel                = New-Object system.Windows.Forms.Label
$BootConfigHostnameLabel.text           = "Hostname:"
$BootConfigHostnameLabel.AutoSize       = $true
$BootConfigHostnameLabel.width          = 25
$BootConfigHostnameLabel.height         = 20
$BootConfigHostnameLabel.location       = New-Object System.Drawing.Point(20,350)
$BootConfigHostnameLabel.Font           = 'Microsoft Sans Serif,10,style=Bold'
$BootConfigHostnameLabel.Visible        = $false

$BootConfigHostname                     = New-Object system.Windows.Forms.TextBox
$BootConfigHostname.multiline           = $false
$BootConfigHostname.width               = 314
$BootConfigHostname.height              = 20
$BootConfigHostname.location            = New-Object System.Drawing.Point(165,347)
$BootConfigHostname.Font                = 'Microsoft Sans Serif,10'
$BootConfigHostname.Visible             = $false

$BootConfigHostnameCryptLabel                = New-Object system.Windows.Forms.Label
$BootConfigHostnameCryptLabel.text           = "Decrypt Hostname:"
$BootConfigHostnameCryptLabel.AutoSize       = $true
$BootConfigHostnameCryptLabel.width          = 25
$BootConfigHostnameCryptLabel.height         = 20
$BootConfigHostnameCryptLabel.location       = New-Object System.Drawing.Point(20,380)
$BootConfigHostnameCryptLabel.Font           = 'Microsoft Sans Serif,10,style=Bold'
$BootConfigHostnameCryptLabel.Visible        = $false

$BootConfigHostnameCrypt                     = New-Object system.Windows.Forms.TextBox
$BootConfigHostnameCrypt.multiline           = $false
$BootConfigHostnameCrypt.width               = 314
$BootConfigHostnameCrypt.height              = 20
$BootConfigHostnameCrypt.location            = New-Object System.Drawing.Point(165,377)
$BootConfigHostnameCrypt.Font                = 'Microsoft Sans Serif,10'
$BootConfigHostnameCrypt.Visible             = $false

$BootConfigTZLabel                = New-Object system.Windows.Forms.Label
$BootConfigTZLabel.text           = "Timezone:"
$BootConfigTZLabel.AutoSize       = $true
$BootConfigTZLabel.width          = 25
$BootConfigTZLabel.height         = 20
$BootConfigTZLabel.location       = New-Object System.Drawing.Point(490,230)
$BootConfigTZLabel.Font           = 'Microsoft Sans Serif,10,style=Bold'
$BootConfigTZLabel.Visible        = $false

$BootConfigTZ                     = New-Object system.Windows.Forms.ComboBox
$BootConfigTZ.width               = 214
$BootConfigTZ.height              = 20
$BootConfigTZ.location            = New-Object System.Drawing.Point(650,227)
$BootConfigTZ.Font                = 'Microsoft Sans Serif,10'
$BootConfigTZ.Visible             = $false
ForEach ($Item in $($TZtoOlsonHash.GetEnumerator() | sort -Property Value)) {
 [void] $BootConfigTZ.Items.Add($Item.Value)
}
$BootConfigTZ.SelectedItem = $BootConfigTZ.Items[$BootConfigTZ.FindString($TZtoOlsonHash[(Get-Timezone).StandardName])]

$BootConfigLocaleLabel                = New-Object system.Windows.Forms.Label
$BootConfigLocaleLabel.text           = "Language and Country:"
$BootConfigLocaleLabel.AutoSize       = $true
$BootConfigLocaleLabel.width          = 25
$BootConfigLocaleLabel.height         = 20
$BootConfigLocaleLabel.location       = New-Object System.Drawing.Point(490,260)
$BootConfigLocaleLabel.Font           = 'Microsoft Sans Serif,10,style=Bold'
$BootConfigLocaleLabel.Visible        = $false

$BootConfigLocale                     = New-Object system.Windows.Forms.ComboBox
$BootConfigLocale.width               = 214
$BootConfigLocale.height              = 20
$BootConfigLocale.location            = New-Object System.Drawing.Point(650,257)
$BootConfigLocale.Font                = 'Microsoft Sans Serif,10'
$BootConfigLocale.Visible             = $false
ForEach ($Item in $Locales) {
 [void] $BootConfigLocale.Items.Add($Item)
}
$BootConfigLocale.SelectedItem = $BootConfigLocale.Items[$BootConfigLocale.FindString((Get-WinSystemLocale).Name)]

$BootConfigDockerLabel                = New-Object system.Windows.Forms.Label
$BootConfigDockerLabel.text           = "Install Docker for the Pi user:"
$BootConfigDockerLabel.AutoSize       = $true
$BootConfigDockerLabel.width          = 25
$BootConfigDockerLabel.height         = 20
$BootConfigDockerLabel.location       = New-Object System.Drawing.Point(490,290)
$BootConfigDockerLabel.Font           = 'Microsoft Sans Serif,10,style=Bold'
$BootConfigDockerLabel.Visible        = $false

$BootConfigDocker                     = New-Object system.Windows.Forms.CheckBox
$BootConfigDocker.location            = New-Object System.Drawing.Point(700,287)
$BootConfigDocker.Visible             = $false

$AddBootConfigBtn                   = New-Object system.Windows.Forms.Button
$AddBootConfigBtn.BackColor         = "#ff7b00"
$AddBootConfigBtn.text              = "Configure"
$AddBootConfigBtn.width             = 90
$AddBootConfigBtn.height            = 30
$AddBootConfigBtn.location          = New-Object System.Drawing.Point(510,410)
$AddBootConfigBtn.Font              = 'Microsoft Sans Serif,10'
$AddBootConfigBtn.ForeColor         = "#ffffff"
$AddBootConfigBtn.Visible           = $false
$AddBootConfigBtn.Enabled           = $false

$cancelBtn                       = New-Object system.Windows.Forms.Button
$cancelBtn.BackColor             = "#ffffff"
$cancelBtn.text                  = "Cancel"
$cancelBtn.width                 = 90
$cancelBtn.height                = 30
$cancelBtn.location              = New-Object System.Drawing.Point(400,410)
$cancelBtn.Font                  = 'Microsoft Sans Serif,10'
$cancelBtn.ForeColor             = "#000"
$cancelBtn.DialogResult          = [System.Windows.Forms.DialogResult]::Cancel
$LocalBootConfigForm.CancelButton   = $cancelBtn
$LocalBootConfigForm.Controls.Add($cancelBtn)

$LocalBootConfigForm.controls.AddRange(@($Title,$Description,$BootConfigStatus,$BootConfigFound,$BootConfigDriveLabel,$BootConfigDrive,$BootConfigDetails, $BootConfigModifyPWLabel, $BootConfigModifyPW, $BootConfigPiPasswordLabel, $BootConfigPiPassword, $BootConfigDecryptPasswordLabel, $BootConfigDecryptPassword, $BootConfigSSIDLabel, $BootConfigSSID, $BootConfigSSIDPWLabel, $BootConfigSSIDPW, $BootConfigHostnameLabel, $BootConfigHostname, $BootConfigHostnameCryptLabel, $BootConfigHostnameCrypt, $BootConfigTZLabel, $BootConfigTZ, $BootConfigLocaleLabel, $BootConfigLocale, $BootConfigDockerLabel, $BootConfigDocker, $AddBootConfigBtn,$cancelBtn ))

#-----------------------------------------------------------[Functions]------------------------------------------------------------

# .Net methods for hiding/showing the console in the background
Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();

[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'

function Show-Console
{
    $consolePtr = [Console.Window]::GetConsoleWindow()
    [Console.Window]::ShowWindow($consolePtr, 4)
}

function Hide-Console
{
    $consolePtr = [Console.Window]::GetConsoleWindow()
    [Console.Window]::ShowWindow($consolePtr, 0)
}

function AddBootConfig {
  $BootConfigFound.ForeColor = "#000000"
  $BootConfigFound.Text = 'Boot configuration completed...'
  $PiPWChecked = $BootConfigModifyPW
  if ($PiPWChecked.Checked){$PiPW = $BootConfigPiPassword.Text}
  $DecryptPW = $BootConfigDecryptPassword.Text
  $SSID = $BootConfigSSID.Text
  $WifiPW = $BootConfigSSIDPW.Text
  $Hostname = $BootConfigHostname.Text
  $HostnameCrypt = $BootConfigHostnameCrypt.Text
  $SDCard = $BootConfigDrive.SelectedItem
  $Docker = $BootConfigDocker

function Get-Md5Crypt {
  <#
  .DESCRIPTION
      Generate a md5crypt string ($1$salt$hash)
  .PARAMETER String
      The string to hash
  .PARAMETER Salt
      The salt to use (can be a crypt string)
  .PARAMETER SaltSize
      In case no salt is provided generate one with length SaltSize (default: 10)
  .NOTES
      Thanks to Aaron Toponce explanation: https://pthree.org/2015/08/07/md5crypt-explained/
  #>
  param (
      [Parameter(Position=0,ValueFromPipeline)]
      [string]
      $String,

      [string]
      $Salt,

      [ValidateRange(3,100)]
      [int]
      $SaltSize = 10
  )

  if($String.Length -eq 0) {
      $pass = [System.Net.NetworkCredential]::new("", (Read-Host -AsSecureString -Prompt "Enter Password")).Password
      $repeat = [System.Net.NetworkCredential]::new("", (Read-Host -AsSecureString -Prompt "Repeat Password")).Password
      if(-not $pass.Equals($repeat)) {
          throw "Passwords didn't match!"
      }
      $String = $pass
  }

  if($Salt.Length -eq 0) {
      $Salt = (-join ((48..57) +(65..90) + (97..122) | Get-Random -Count $SaltSize | ForEach-Object {[char]$_}))
  }elseif($Salt.StartsWith('$1$')) {
      $Salt = ($Salt -split '\$')[2]
  }

  $md5 = new-object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider
  $utf8 = new-object -TypeName System.Text.UTF8Encoding

  $pw = [byte[]]$utf8.GetBytes($String)
  $magic = [byte[]]$utf8.GetBytes('$1$')
  $bsalt = $utf8.GetBytes($Salt)

  $itoa64 = "./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"

  $tmp = [System.Collections.ArrayList]@()
  $tmp.AddRange($pw)
  $tmp.AddRange($bsalt)
  $tmp.AddRange($pw)
  $db = $md5.ComputeHash([byte[]]$tmp)

  $da_bytes = [System.Collections.ArrayList]@()
  $da_bytes.AddRange($pw)
  $da_bytes.AddRange($magic)
  $da_bytes.AddRange($bsalt)
  $i = $pw.Length
  while($i -gt 0) {
      if($i -gt 16) {
          $da_bytes.AddRange($db)
      }else{
          $da_bytes.AddRange($db[0..$($i-1)])
      }
      $i -= 16
  }

  $i = $pw.Length
  while($i -gt 0) {
      if($i -band 1) {
          $da_bytes.Add([byte]0) | Out-Null
      }else{
          $da_bytes.Add($pw[0]) | Out-Null
      }
      $i = $i -shr 1
  }

  $dc = [byte[]]$md5.ComputeHash([byte[]]$da_bytes)

  for($i = 0; $i -lt 1000; $i++) {
      $tmp = [System.Collections.ArrayList]@()
      if($i -band 1) {
          $tmp.AddRange($pw)
      }else{
          $tmp.AddRange($dc)
      }
      if($i%3) { $tmp.AddRange($bsalt) }
      if($i%7) { $tmp.AddRange($pw) }
      if($i -band 1) {
          $tmp.AddRange($dc)
      }else{
          $tmp.AddRange($pw)
      }
      $dc = [byte[]]$md5.ComputeHash([byte[]]$tmp)
  }

  $final = ''
  @(@(0,6,12),@(1,7,13),@(2,8,14),@(3,9,15),@(4,10,5)) | ForEach-Object {
      $x, $y, $z = $_
      $v = ([int]$dc[$x] -shl 16) -bor ([int]$dc[$y] -shl 8) -bor [int]$dc[$z]
      1..4 | ForEach-Object {
          $final += $itoa64[ $v -band 0x3f ]
          $v = $v -shr 6
      }
  }
  $v = [int]$dc[11]
  1..2 | ForEach-Object {
      $final += $itoa64[$v -band 0x3f]
      $v = $v -shr 6
  }

  '{0}{1}${2}' -f $utf8.GetString($magic),$salt,$final
}
if ($PiPWChecked.Checked){$PiPWCrypt = Get-Md5Crypt -String $PiPW -SaltSize 8}
$DecryptPWCrypt = Get-Md5Crypt -String $DecryptPW -SaltSize 8

#--------------[nologin]-------------------
  $nologin= ($SDCard + "nologin")
  $nologintext=@'

  Login is currently disabled.
  System is generating initramfs files needed to enable filesystem encryption later on.
  System will reboot in about 5 minutes.
'@
  Set-Content -Path $nologin -Value $nologintext -NoNewLine

  #--------------[two-time-script.service]-------------------
    $twotime= ($SDCard + "two_time_script.service")
    $twotimetext=@'
    [Unit]
    Description=Unattended second configuration of the Pi
    Wants=network-online.target
    After=network-online.target
    After=time-sync.target
    Wants=time-sync.target

    [Install]
    WantedBy=multi-user.target

    [Service]
    Type=oneshot
    ExecStartPre=/bin/sh -c 'until ping -c1 google.com; do sleep 1; done;'
    ExecStart=/usr/local/bin/post_encrypt.sh || true
'@
    Set-Content -Path $twotime -Value $twotimetext -NoNewLine

#--------------[docker_setup.sh file]----------------------
$dockerfile = @'
echo 'Starting docker setup' | systemd-cat -t docker -p warning
curl -fsSL https://get.docker.com -o get-docker.sh | systemd-cat -t docker -p warning
sh get-docker.sh | systemd-cat -t docker -p warning
wait
apt-get install -y -qq docker-ce-rootless-extras | systemd-cat -t docker
usermod -aG docker pi | systemd-cat -t docker -p warning
sh -eux <<EOF
# Install newuidmap & newgidmap binaries

apt-get install -y uidmap | systemd-cat -t docker -p warning
EOF

curl -L https://github.com/containers/fuse-overlayfs/releases/download/v1.7.1/fuse-overlayfs-armv7l -o fuse-overlayfs | systemd-cat -t docker -p warning
chmod +x fuse-overlayfs | systemd-cat -t docker -p warning
mv fuse-overlayfs /usr/bin | systemd-cat -t docker -p warning

curl -o slirp4netns --fail -L https://github.com/rootless-containers/slirp4netns/releases/download/v1.1.12/slirp4netns-$(uname -m) | systemd-cat -t docker -p warning
chmod +x slirp4netns | systemd-cat -t docker -p warning
mv slirp4netns /usr/bin | systemd-cat -t docker -p warning

mkdir -p /usr/local/lib/docker/cli-plugins/
curl -SL https://github.com/docker/compose/releases/download/v2.0.1/docker-compose-linux-armv7 -o /usr/local/lib/docker/cli-plugins/docker-compose
chmod a+x /usr/local/lib/docker/cli-plugins/docker-compose

wait
echo "dockerd-rootless-setuptool.sh install --force > ./docker_rootless_install_log 2> ./docker_rootless_install_log && sed -i 's/dockerd/# dockerd/' /home/pi/.bashrc" >> /home/pi/.bashrc
#sudo -u pi -i export XDG_RUNTIME_DIR=/run/user/$UID && dockerd-rootless-setuptool.sh install --force
#su - pi -c 'export XDG_RUNTIME_DIR=/run/user/$UID && dockerd-rootless-setuptool.sh install --force' | systemd-cat -t docker -p warning
wait

'@


#--------------[post_encrypt.sh]-------------------
  $postencrypt = ($SDCard + "post_encrypt.sh")
  $postencrypttext = @'
#!/bin/bash


'@ + $(if ($BootConfigDocker.Checked){$dockerfile} Else {""}) +
@'

wait
update-rpi-initramfs -u

passwd -u pi
rm /etc/nologin
  systemctl disable two_time_script.service
'@
  Set-Content -Path $postencrypt -Value $postencrypttext -NoNewLine

#--------------[one-time-script.service]-------------------
  $onetime= ($SDCard + "one_time_script.service")
  $onetimetext=@'
  [Unit]
  Description=Unattended configuration of the Pi
  Wants=network-online.target
  After=network-online.target

  [Install]
  WantedBy=multi-user.target

  [Service]
  Type=oneshot
  ExecStartPre=/bin/sh -c 'until ping -c1 google.com; do sleep 1; done;'
  ExecStart=/usr/local/bin/pre_encrypt.sh || true
'@
  Set-Content -Path $onetime -Value $onetimetext -NoNewLine

#--------------[encrypt.sh]-------------------
  $encrypt = ($SDCard + "encrypt.sh")
  $encrypttext = @'
  PATH=/sbin:/usr/sbin:/bin:/usr/bin
  echo 'Check filesystem'
  e2fsck -f /dev/mmcblk0p2
  echo 'Reduce filesystem'
  sdsize1=$(resize2fs -fM /dev/mmcblk0p2 | awk 'NR==2 {print $7}')
  sdsize2=$(expr $(expr $sdsize1 / 256) + 1)
  echo 'Create backup copy of filesystem. This takes minutes...'
  dd if=/dev/mmcblk0p2 bs=1M count=$sdsize2 | pigz -1 | dd of=/dev/sda
  echo 'Encrypt filesystem'
  i="0"
  while [ $i -eq 0 ]
  do
  cryptsetup -v --type luks2 --cipher aes-xts-plain64 --pbkdf argon2id --key-size 256 --hash sha256 --iter-time 4000 --verify-passphrase --use-random luksFormat /dev/mmcblk0p2 && i=$[$i+1]
  #cryptsetup -v --type luks2 --cipher aes-xts-plain64 --pbkdf argon2id --key-size 512 --hash sha256 --iter-time 4000 --verify-passphrase --use-random luksFormat /dev/mmcblk0p2 && i=$[$i+1]
  done
  echo 'Open access to encrypted filesystem'
  cryptsetup --allow-discards --persistent open /dev/mmcblk0p2 sdcard
  echo 'Copy backup filesystem into encrypted filesystem'
  dd if=/dev/sda | pigz -d | dd of=/dev/mapper/sdcard bs=1M
  echo 'Increase filesystem again'
  resize2fs -f /dev/mapper/sdcard
  echo 'Encryption setup completed, rebooting'
  killall -9 sh
'@
  Set-Content -Path $encrypt -Value $encrypttext -NoNewLine

#--------------[pre_encrypt.sh]-------------------
  $preencrypt = ($SDCard + "pre_encrypt.sh")
  $preencrypttext = @'
#!/bin/bash

  cp /boot/nologin /etc/nologin
  raspi-config nonint do_boot_behaviour B3
  echo "
  Starting configuration for initramfs creation.
  " > /dev/tty1

  sed -i 's/#INITRD=Yes/INITRD=Yes/' /etc/default/raspberrypi-kernel
  echo "ping google" >> /boot/preencrypt.txt
  ping -c 4 google.com 1>> /boot/preencrypt.txt 2>> /boot/preencrypt.txt
  apt --assume-yes install initramfs-tools dropbear secure-delete 1>> /boot/preencrypt.txt 2>> /boot/preencrypt.txt

  cp /boot/nologin /etc/nologin

  sed -i 's/local flags="Fs"/local flags="F"/' /usr/share/initramfs-tools/scripts/init-premount/dropbear

'@ + "  mypassword=`'"+$DecryptPWCrypt+"`'" + @'

  sed -i 's%echo "root:\*%mypassword='"'$mypassword'"'\necho "root:$mypassword%' /usr/share/initramfs-tools/hooks/dropbear

  echo 'DROPBEAR_OPTIONS="-R -p 23"' >> /etc/dropbear-initramfs/config
  cat /boot/*.pub >> /etc/dropbear-initramfs/authorized_keys
  mkdir /home/pi/.ssh
  runuser -u pi cat /boot/*.pub >> /home/pi/.ssh/authorized_keys
  rm /boot/*.pub

  myHook='#!/bin/sh

  set -e

  PREREQ=""

  prereqs () {
          echo "${PREREQ}"
  }

  case "${1}" in
          prereqs)
                  prereqs
                  exit 0
                  ;;
  esac

  . /usr/share/initramfs-tools/hook-functions

  copy_exec /usr/bin/sdmem /usr/bin
  copy_exec /usr/bin/pigz /usr/bin
  copy_exec /sbin/fdisk /sbin
  copy_exec /sbin/dumpe2fs /sbin
  copy_exec /sbin/resize2fs /sbin
  copy_exec /bin/lsblk /sbin
  copy_exec /sbin/e2fsck /sbin
  copy_exec /sbin/cryptsetup-reencrypt /sbin
  sed -i "s/^export IP=.*/export IP=::::
'@ + $HostnameCrypt + @'
/" ${DESTDIR}/init
  exit 0
  '
  echo "$myHook" > /etc/initramfs-tools/hooks/myHook
  chmod +x /etc/initramfs-tools/hooks/myHook

  sdmem='#!/bin/sh
  PREREQ=""
  prereqs()
  {
     echo "$PREREQ"
  }

  case $1 in
  prereqs)
     prereqs
     exit 0
     ;;
  esac

  /bin/sdmem -llv
  '
  echo "$sdmem" > /etc/initramfs-tools/scripts/init-top/sdmem
  chmod +x /etc/initramfs-tools/scripts/init-top/sdmem

  sed -i 's/rootwait/net.ifnames=0 rootwait/' /boot/cmdline.txt

  sudo mv /etc/kernel/postinst.d/initramfs-tools /home/pi

  rpi_initramfs_tools='#!/bin/bash
  # Environment variables are set by the calling script

  version="$1"
  bootopt=""

  command -v update-initramfs >/dev/null 2>&1 || exit 0

  # passing the kernel version is required
  if [ -z "${version}" ]; then
        echo >&2 "W: initramfs-tools: ${DPKG_MAINTSCRIPT_PACKAGE:-kernel package} did not pass a version number"
        exit 2
  fi

  # exit if kernel does not need an initramfs
  if [ "$INITRD" = '"'"'No'"'"' ]; then
        # delete initramfs entries in /boot/config.txt
        /bin/sed -i '"'"'/^initramfs /d'"'"' /boot/config.txt
        exit 0
  fi

  currentversion="$(uname -r)"
  regex="[0-9]+\.[0-9]+\.[0-9]+(.*)" #Kernelversion like 5.10.17-v7l+

  if [[ $currentversion =~ $regex ]]
  then
  currenttype="${BASH_REMATCH[1]}"
  fi

  if [[ $version =~ $regex ]]
  then
  newtype="${BASH_REMATCH[1]}"
  fi

  #Uncomment the following 4 lines if you want to speed up updates and dont want to generate initramfs for different RPi types
  # # we do nothing if the new kernel is not for the same kernel type then the current
  if [ "$newtype" != "$currenttype" ]; then
        exit 0
  fi

  # absolute file name of kernel image may be passed as a second argument;
  # create the initrd in the same directory
  if [ -n "$2" ]; then
        bootdir=$(dirname "$2")
        bootopt="-b ${bootdir}"
  fi

  # avoid running multiple times
  if [ -n "$DEB_MAINT_PARAMS" ]; then
        eval set -- "$DEB_MAINT_PARAMS"
        if [ -z "$1" ] || [ "$1" != "configure" ]; then
                exit 0
        fi
  fi

  # were good - create initramfs.  update runs do_bootloader
  INITRAMFS_TOOLS_KERNEL_HOOK=1 update-initramfs -c -t -k "${version}" ${bootopt} >&2

  # we do nothing if the new kernel is not for the same kernel type then the current
  if [ "$newtype" = "$currenttype" ]; then
        # delete initramfs entries in /boot/config.txt
        /bin/sed -i '"'"'/^initramfs /d'"'"' /boot/config.txt

        # insert initramfs entry in /boot/config.txt
        INITRD_ENTRY="initramfs initrd.img-${version}"
        echo >&2 $(basename "$0"): insert \'"'"'"$INITRD_ENTRY"\'"'"' into /boot/config.txt
        /bin/sed -i "1i $INITRD_ENTRY" /boot/config.txt
  fi

  '


  echo "$rpi_initramfs_tools"> /etc/kernel/postinst.d/rpi-initramfs-tools
  chmod 755 /etc/kernel/postinst.d/rpi-initramfs-tools

  update_rpi_initramfs='#!/bin/bash
  # This script calls default update-initramfs
  # and then insert a '"'"'initramfs'"'"' entry into /boot/config.txt if necessary

  # should return e.g. "update-initramfs: Generating /boot/initrd.img-4.14.79-v7+"
  # or                 "update-initramfs: Deleting /boot/initrd.img-4.14.71-v7+"
  MSG=$(/usr/sbin/update-initramfs "$@")
  RETCODE=$?
  echo $MSG

  if [[ $RETCODE -ne 0 ]]; then
          echo >&2 ATTENTION! Check \'"'"'initramfs\'"'"' entry in /boot/config.txt
          exit "$RETCODE"
  fi

  CMP="update-initramfs: Deleting *"
  if [[ $MSG == $CMP ]]; then
          # delete initramfs entries in /boot/config.txt
          /bin/sed -i '"'"'/^initramfs /d'"'"' /boot/config.txt
          echo $(basename "$0"): deleted all \'"'"'initramfs\'"'"' entries from /boot/config.txt
          exit 0
  fi

  CMP="update-initramfs: Generating *"
  if [[ $MSG == $CMP ]]; then
          # delete initramfs entries in /boot/config.txt
          /bin/sed -i '"'"'/^initramfs /d'"'"' /boot/config.txt

          # exit if kernel does not need an initramfs
          source /etc/default/raspberrypi-kernel
          if [ "${INITRD,,}" != '"'"'yes'"'"' ]; then
                  echo $(basename "$0"): no entry in /boot/config.txt \(see INITRD in /etc/default/raspberrypi-kernel\)
                  exit 0
          fi

          # insert initramfs entry in /boot/config.txt
          VERSION=$(basename "$MSG")
          INITRD_ENTRY="initramfs $VERSION"
          echo $(basename "$0"): insert \'"'"'"$INITRD_ENTRY"\'"'"' into /boot/config.txt
          /bin/sed -i "1i $INITRD_ENTRY" /boot/config.txt

          exit 0
  fi

  echo >&2 ATTENTION! Check '"'"'initramfs'"'"' entry in /boot/config.txt
  exit 1
  '
  echo "$update_rpi_initramfs" > /usr/local/sbin/update-rpi-initramfs
  chmod 755 /usr/local/sbin/update-rpi-initramfs

  ln -s /sbin/e2fsck /sbin/fsck.luks

  my='COMPRESS=lzma
  BUSYBOX=y
  DROPBEAR=y
  '
  echo "$my" > /etc/initramfs-tools/conf.d/my

  echo "CRYPTSETUP=y" >> /etc/cryptsetup-initramfs/conf-hook
  cp /boot/nologin /etc/nologin

  #copy it to dropbear
  #cp key.pub /etc/dropbear-initramfs/authorized_keys
  sed -i '$s/$/ cryptdevice=\/dev\/mmcblk0p2:sdcard/' /boot/cmdline.txt

  ROOT_CMD="$(sed -n 's|^.*root=\(\S\+\)\s.*|\1|p' /boot/cmdline.txt)"

  sed -i -e "s|$ROOT_CMD|/dev/mapper/sdcard|g" /boot/cmdline.txt

  FSTAB_CMD="$(blkid | sed -n '/dev\/mmcblk0p2/s/.*\ PARTUUID=\"\([^\"]*\)\".*/\1/p')"

  sed -i -e "s|PARTUUID=$FSTAB_CMD|/dev/mapper/sdcard|g" /etc/fstab

  echo 'sdcard /dev/mmcblk0p2 none luks' | tee --append /etc/crypttab > /dev/null

  copy_encrypt='#!/bin/sh
  set -e
  PREREQ=""
  prereqs()
  {
      echo "${PREREQ}"
  }
  case "${1}" in
      prereqs)
          prereqs
          exit 0
          ;;
  esac

  . /usr/share/initramfs-tools/hook-functions

  # CHANGE HERE for your correct modules.
  if [ -f /boot/encrypt.sh ]
  then
  mv /boot/encrypt.sh ${DESTDIR}/usr/bin/encrypt
  fi
  '

  echo "$copy_encrypt" > /etc/initramfs-tools/hooks/copy_encrypt
  chmod +x /etc/initramfs-tools/hooks/copy_encrypt


  enable_wireless='#!/bin/sh
  set -e
  PREREQ=""
  prereqs()
  {
      echo "${PREREQ}"
  }
  case "${1}" in
      prereqs)
          prereqs
          exit 0
          ;;
  esac

  . /usr/share/initramfs-tools/hook-functions

  # CHANGE HERE for your correct modules.
  manual_add_modules iw brcmfmac brcmutil cfg80211 rfkill
  copy_exec /sbin/wpa_supplicant
  copy_exec /sbin/wpa_cli
  #copy_file config /etc/initramfs-tools/wpa_supplicant.conf /etc/wpa_supplicant.conf
  tail -n+4 /etc/wpa_supplicant/wpa_supplicant.conf >${DESTDIR}/etc/wpa_supplicant.conf
  cp /lib/firmware/brcm/brcmfmac43455-sdio.* ${DESTDIR}/lib/firmware/brcm
  cp /lib/firmware/brcm/brcmfmac43456-sdio.* ${DESTDIR}/lib/firmware/brcm
  mkdir -p ${DESTDIR}/var/run/wpa_supplicant
  '

  echo "$enable_wireless" > /etc/initramfs-tools/hooks/enable-wireless
  chmod +x /etc/initramfs-tools/hooks/enable-wireless

  a_enable_wireless='#!/bin/sh
  PREREQ="udev"

  prereqs()
  {
          echo "$PREREQ"
  }

  case $1 in
  prereqs)
          prereqs
          exit 0
          ;;
  esac

  if grep -q splash /proc/cmdline; then
      /bin/chvt 1
  fi
  sleep 3

  if grep -q splash /proc/cmdline; then
         /sbin/usplash -c &
         sleep 1
  fi
  echo "starting wpa_supplicant"
  sleep 10
  /sbin/wpa_supplicant -Dwext -iwlan0 -c /etc/wpa_supplicant.conf &
  sleep 5
  ipconfig wlan0 &
  '

  echo "$a_enable_wireless" > /etc/initramfs-tools/scripts/init-premount/a_enable_wireless
  chmod +x /etc/initramfs-tools/scripts/init-premount/a_enable_wireless

  kill_wireless='#!/bin/sh
  PREREQ=""
  prereqs()
  {
      echo "$PREREQ"
  }

  case $1 in
  prereqs)
      prereqs
      exit 0
      ;;
  esac
  echo "Killing wpa_supplicant so the system takes over later."
  kill $(pidof wpa_supplicant)
  '

  echo "$kill_wireless" > /etc/initramfs-tools/scripts/local-bottom/kill_wireless
  chmod +x /etc/initramfs-tools/scripts/local-bottom/kill_wireless
  cp /boot/nologin /etc/nologin

  echo "
  Starting initramfs creation. This will take a few minutes...
  " > /dev/tty1

  update-rpi-initramfs -c -k $(uname -r) 1>> /boot/preencrypt.txt 2>> /boot/preencrypt.txt

  echo "Done with initramfs" > /dev/tty1

  systemctl disable one_time_script.service
  echo "
  Enabling service for the second reboot.
  " > /dev/tty1

  systemctl enable two_time_script.service
  echo "Rebooting" > /dev/tty1
  reboot

'@
Set-Content -Path $preencrypt -Value $preencrypttext -NoNewLine

#--------------[cmdline.txt]----------------------
  $Cmdline = ($SDCard + "cmdline.txt")
  $unattended = ($SDCard + "unattended")
  $wpasupplicant = ($SDCard +"wpa_supplicant.conf")
  $dockerfilename = ($SDCard + "docker_setup.sh")
  $Inittext =  " init=/bin/bash -c `"mount -t proc proc /proc; mount -t sysfs sys /sys; mount /boot; sed -i 's/\r$//' /boot/unattended; source /boot/unattended`""
  If (Test-Path ($Cmdline)) {
    $CmdlineContent = (((Get-Content $Cmdline) -csplit "( init)")[0] + $Inittext)
    Move-Item -Path $Cmdline -Destination ($SDCard + "cmdline.bak") -Force
    Set-Content -Path $Cmdline -Value $CmdlineContent -NoNewLine
    Remove-Item -Path ($SDCard + "cmdline.bak") -Force
    Copy-Item -Path ($HOME + "\.ssh\*.pub") -Destination ($SDCard)


#--------------[unattended file]-----------------
  $unattendedtext = "# 1. MAKING THE SYSTEM WORK. DO NOT REMOVE
mount -t tmpfs tmp /run
mkdir -p /run/systemd
mount / -o remount,rw
sed -i `'s| init=.*||`' /boot/cmdline.txt

# 2. THE USEFUL PART OF THE SCRIPT
# Enable SSH
raspi-config nonint do_ssh 0
cat /boot/*.pub >> /home/pi/.ssh/authorized_keys
# Enable VNC
raspi-config nonint do_vnc 0
# Change the hostname to something recognizable
raspi-config nonint do_hostname $($BootConfigHostname.Text)
# Set the screen resolution to 1920 x 1080, especially important for VNC to work if running headless
raspi-config nonint do_resolution 2 82
if  [ `"`$(source /etc/os-release; echo `"`"`"`$PRETTY_NAME`"`"`")`" == `"Raspbian GNU/Linux 11 (bullseye)`" ];
then
  sudo raspi-config nonint do_vnc_resolution 1920x1080
  rfkill unblock wifi
  for filename in /var/lib/systemd/rfkill/*:wlan ; do
    echo 0 > `$filename
  done
fi
# enable the camera (optional)
raspi-config nonint do_camera 0
# Set timezone
raspi-config nonint do_change_timezone $($BootConfigTZ.Text)
# Set locale
raspi-config nonint do_change_locale $($BootConfigLocale.Text).UTF.8
# Set keyboard
raspi-config nonint do_configure_keyboard $(($BootConfigLocale.Text).Substring(($BootConfigLocale.Text).Length - 2))
# Set password, uncomment (remove pound sign) if you want to set the pi password here
$(if ($PiPWChecked.Checked){"usermod --password `'"+$PiPWCrypt+"`' pi"})
raspi-config nonint do_boot_behaviour B1
passwd --expire pi
passwd -l pi
# Remove autostart of welcome to raspberry pi
rm /etc/xdg/autostart/piwiz.desktop
# Set up time sync for docker install
ln -s /lib/systemd/system/systemd-time-wait-sync.service /etc/systemd/system/multi-user.target.wants/

# Expand file system
canexpand=``raspi-config nonint get_can_expand``; if [ `"`$canexpand`" -eq `"0`" ]; then raspi-config nonint do_expand_rootfs; fi
# remove CRs from pre_encrypt.sh
sed -i 's/\r$//' /boot/pre_encrypt.sh
# remove CRs from encrypt.sh
sed -i 's/\r$//' /boot/encrypt.sh
sed -i 's/\r$//' /boot/one_time_script.service
sed -i 's/\r$//' /boot/post_encrypt.sh
sed -i 's/\r$//' /boot/two_time_script.service
sed -i 's/\r$//' /boot/nologin
mv /boot/one_time_script.service /lib/systemd/system/
ln -s /lib/systemd/system/one_time_script.service /etc/systemd/system/multi-user.target.wants/
mv /boot/pre_encrypt.sh /usr/local/bin/pre_encrypt.sh
chmod +x /usr/local/bin/pre_encrypt.sh
mv /boot/two_time_script.service /lib/systemd/system/
mv /boot/post_encrypt.sh /usr/local/bin/post_encrypt.sh
chmod +x /usr/local/bin/post_encrypt.sh
echo `"Completed custom configuration`"
sleep 5


# 3. CLEANING UP AND REBOOTING
sync
umount /boot
mount / -o remount,ro
sync
echo 1 > /proc/sys/kernel/sysrq
echo b > /proc/sysrq-trigger
sleep 5"
  Set-Content -Path $unattended -Value $unattendedtext -NoNewLine
  #sed -i 's/\r$//' /boot/pipassword
  #$(if (-not $PiPWChecked.Checked){"#"})usermod --password `$(openssl passwd -1 `$(cat /boot/pipassword)) pi
  #rm /boot/pipassword


#--------------[wpa_supplicant.conf file]-----------------
  $wpasupplicanttext = "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
country=$(($BootConfigLocale.Text).Substring(($BootConfigLocale.Text).Length - 2))
ap_scan=1

update_config=1
network={
        ssid=`"$($BootConfigSSID.Text)`"
        psk=`"$($BootConfigSSIDPW.Text)`"
}"
    Set-Content -Path $wpasupplicant -Value $wpasupplicanttext -NoNewLine
  }else{
    $BootConfigFound.Text = 'No cmdline.txt file found. This does not appear to be Raspberry Pi OS bootable SD Card.'
  }

  $BootConfigDrive.Visible = $false
  $AddBootConfigBtn.Visible = $false
  $BootConfigDetails.Visible = $false
  $BootConfigDriveLabel.Visible = $false
  $BootConfigPiPasswordLabel.Visible = $false
  $BootConfigPiPassword.Visible = $false
  $BootConfigDecryptPasswordLabel.Visible = $false
  $BootConfigDecryptPassword.Visible = $false
  $BootConfigSSIDLabel.Visible = $false
  $BootConfigSSID.Visible = $false
  $BootConfigSSIDPWLabel.Visible = $false
  $BootConfigSSIDPW.Visible = $false
  $BootConfigModifyPWLabel.Visible = $false
  $BootConfigModifyPW.Visible = $false
  $BootConfigHostnameLabel.Visible = $false
  $BootConfigHostname.Visible = $false
  $BootConfigHostnameCryptLabel.Visible = $false
  $BootConfigHostnameCrypt.Visible = $false
  $BootConfigTZLabel.Visible = $false
  $BootConfigTZ.Visible = $false
  $BootConfigLocaleLabel.Visible = $false
  $BootConfigLocale.Visible = $false
  $BootConfigDockerLabel.Visible = $false
  $BootConfigDocker.Visible = $false
  $cancelBtn.text = "Close"
}

#---------------------------------------------------------[Script]--------------------------------------------------------

Hide-Console

# Get Connected Drives named Boot
$BootDrives = (
  Get-CimInstance -ClassName Win32_Volume | Select Name, Label |
  Where-Object {
    $_.Label -eq "boot"
  }
)

If ($BootDrives.length -ne 0) {
  if ($BootDrives.length -gt 1) { $BootConfigFound.text = "SD Cards found" } else {$BootConfigFound.text = "SD Card found"}
  $BootConfigFound.ForeColor = "#7ed321"
  $BootConfigPiPasswordLabel.Visible = $true
  $BootConfigPiPassword.Visible = $true
  ForEach ($BootDrive in $BootDrives) {
    $BootConfigDrive.Items.Add($BootDrive.Name)
  }
  $BootConfigDrive.Visible = $true
  $AddBootConfigBtn.Visible = $true
  $BootConfigDetails.Visible = $true
  $BootConfigDriveLabel.Visible = $true
  $BootConfigDecryptPasswordLabel.Visible = $true
  $BootConfigDecryptPassword.Visible = $true
  $BootConfigSSIDLabel.Visible = $true
  $BootConfigSSID.Visible = $true
  $BootConfigSSIDPWLabel.Visible = $true
  $BootConfigSSIDPW.Visible = $true
  $BootConfigModifyPWLabel.Visible = $true
  $BootConfigModifyPW.Visible = $true
  $BootConfigHostnameLabel.Visible = $true
  $BootConfigHostname.Visible = $true
  $BootConfigHostnameCryptLabel.Visible = $true
  $BootConfigHostnameCrypt.Visible = $true
  $BootConfigTZLabel.Visible = $true
  $BootConfigTZ.Visible = $true
  $BootConfigLocaleLabel.Visible = $true
  $BootConfigLocale.Visible = $true
  $BootConfigDockerLabel.Visible = $true
  $BootConfigDocker.Visible = $true
}else{
  $BootConfigFound.text = "No SD Cards found"
  $BootConfigFound.ForeColor = "#D0021B"
  $cancelBtn.text = "Close"
}

$AddBootConfigBtn.Add_Click({ AddBootConfig })

$BootConfigDrive.Add_SelectedIndexChanged({
    $AddBootConfigBtn.Enabled = (!(($BootConfigPiPassword.Text.Length -gt 0) -xor $BootConfigModifyPW.Checked) -and ($BootConfigSSID.Text.Length -gt 0) -and ($BootConfigSSIDPW.Text.Length -gt 0) -and ($BootConfigHostname.Text.Length -gt 0) -and ($BootConfigHostnameCrypt.Text.Length -gt 0) -and ($BootConfigDrive.SelectedItem.Length -gt 0) -and ($BootConfigDecryptPassword.Text.Length -gt 0) -and ($BootConfigTZ.Text.Length -gt 0) -and ($BootConfigLocale.Text.Length -gt 0))
})

$BootConfigModifyPW.Add_CheckStateChanged({
    If ($BootConfigModifyPW.Checked) {
      $BootConfigPiPasswordLabel.Enabled = $true
      $BootConfigPiPassword.Enabled = $true
    } Else {
      $BootConfigPiPasswordLabel.Enabled = $false
      $BootConfigPiPassword.Enabled = $false
      $BootConfigPiPassword.Text = ""
    }
    $AddBootConfigBtn.Enabled = (!(($BootConfigPiPassword.Text.Length -gt 0) -xor $BootConfigModifyPW.Checked) -and ($BootConfigSSID.Text.Length -gt 0) -and ($BootConfigSSIDPW.Text.Length -gt 0) -and ($BootConfigHostname.Text.Length -gt 0) -and ($BootConfigHostnameCrypt.Text.Length -gt 0) -and ($BootConfigDrive.SelectedItem.Length -gt 0) -and ($BootConfigDecryptPassword.Text.Length -gt 0) -and ($BootConfigTZ.Text.Length -gt 0) -and ($BootConfigLocale.Text.Length -gt 0))
})

$BootConfigPiPassword.Add_TextChanged({
  $AddBootConfigBtn.Enabled = (!(($BootConfigPiPassword.Text.Length -gt 0) -xor $BootConfigModifyPW.Checked) -and ($BootConfigSSID.Text.Length -gt 0) -and ($BootConfigSSIDPW.Text.Length -gt 0) -and ($BootConfigHostname.Text.Length -gt 0) -and ($BootConfigHostnameCrypt.Text.Length -gt 0) -and ($BootConfigDrive.SelectedItem.Length -gt 0) -and ($BootConfigDecryptPassword.Text.Length -gt 0) -and ($BootConfigTZ.Text.Length -gt 0) -and ($BootConfigLocale.Text.Length -gt 0))
})

$BootConfigSSID.Add_TextChanged({
  $AddBootConfigBtn.Enabled = (!(($BootConfigPiPassword.Text.Length -gt 0) -xor $BootConfigModifyPW.Checked) -and ($BootConfigSSID.Text.Length -gt 0) -and ($BootConfigSSIDPW.Text.Length -gt 0) -and ($BootConfigHostname.Text.Length -gt 0) -and ($BootConfigHostnameCrypt.Text.Length -gt 0) -and ($BootConfigDrive.SelectedItem.Length -gt 0) -and ($BootConfigDecryptPassword.Text.Length -gt 0) -and ($BootConfigTZ.Text.Length -gt 0) -and ($BootConfigLocale.Text.Length -gt 0))
})

$BootConfigSSIDPW.Add_TextChanged({
  $AddBootConfigBtn.Enabled = (!(($BootConfigPiPassword.Text.Length -gt 0) -xor $BootConfigModifyPW.Checked) -and ($BootConfigSSID.Text.Length -gt 0) -and ($BootConfigSSIDPW.Text.Length -gt 0) -and ($BootConfigHostname.Text.Length -gt 0) -and ($BootConfigHostnameCrypt.Text.Length -gt 0) -and ($BootConfigDrive.SelectedItem.Length -gt 0) -and ($BootConfigDecryptPassword.Text.Length -gt 0) -and ($BootConfigTZ.Text.Length -gt 0) -and ($BootConfigLocale.Text.Length -gt 0))
})

$BootConfigHostname.Add_TextChanged({
  $AddBootConfigBtn.Enabled = (!(($BootConfigPiPassword.Text.Length -gt 0) -xor $BootConfigModifyPW.Checked) -and ($BootConfigSSID.Text.Length -gt 0) -and ($BootConfigSSIDPW.Text.Length -gt 0) -and ($BootConfigHostname.Text.Length -gt 0) -and ($BootConfigHostnameCrypt.Text.Length -gt 0) -and ($BootConfigDrive.SelectedItem.Length -gt 0) -and ($BootConfigDecryptPassword.Text.Length -gt 0) -and ($BootConfigTZ.Text.Length -gt 0) -and ($BootConfigLocale.Text.Length -gt 0))
})

$BootConfigHostnameCrypt.Add_TextChanged({
  $AddBootConfigBtn.Enabled = (!(($BootConfigPiPassword.Text.Length -gt 0) -xor $BootConfigModifyPW.Checked) -and ($BootConfigSSID.Text.Length -gt 0) -and ($BootConfigSSIDPW.Text.Length -gt 0) -and ($BootConfigHostname.Text.Length -gt 0) -and ($BootConfigHostnameCrypt.Text.Length -gt 0) -and ($BootConfigDrive.SelectedItem.Length -gt 0) -and ($BootConfigDecryptPassword.Text.Length -gt 0) -and ($BootConfigTZ.Text.Length -gt 0) -and ($BootConfigLocale.Text.Length -gt 0))
})

$BootConfigDecryptPassword.Add_TextChanged({
  $AddBootConfigBtn.Enabled = (!(($BootConfigPiPassword.Text.Length -gt 0) -xor $BootConfigModifyPW.Checked) -and ($BootConfigSSID.Text.Length -gt 0) -and ($BootConfigSSIDPW.Text.Length -gt 0) -and ($BootConfigHostname.Text.Length -gt 0) -and ($BootConfigHostnameCrypt.Text.Length -gt 0) -and ($BootConfigDrive.SelectedItem.Length -gt 0) -and ($BootConfigDecryptPassword.Text.Length -gt 0) -and ($BootConfigTZ.Text.Length -gt 0) -and ($BootConfigLocale.Text.Length -gt 0))
})

[void]$LocalBootConfigForm.ShowDialog()
