$From = "strebeljj@gmail.com"
$To = "reedws@ucmail.uc.edu"
$Cc = "strebejj@mail.uc.edu"
$Attachment = " "
$Subject = "IT3038C Windows SysInfo"
$Body = "This machine's IP is $IP. User is $UserName. Hostname is $hostname. PowerShell Version $Version. Today's Date is $DayOfWeek, $Date."
$SMTPServer = "smtp.gmail.com"
$SMTPPort = "587"
$IP = getIP
$UserName = UserName
$Hostname = hostname
$Version = $PSVersionTable.PSVersion
$DayOfWeek = DayOfWeek
$Date = Get-Date -Format "MM/dd/yyyy"


function DayOfWeek{
(Date).DayOfWeek
}

function getIP{
    (get-netipaddress).ipv4address | Select-String "192*"
}

function UserName{
(Get-LocalUser) | Select-String "Adm*"
}


Send-MailMessage -To "$To" -From "$From" -Cc "$Cc" -Subject $Subject `
-Body $Body -SmtpServer $SMTPServer -port $SMTPPort -UseSSL -Credential (Get-Credential)