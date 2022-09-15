$IP = getIP
$UserName = UserName
$Hostname = hostname
$Version = Version
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



$Report = "This machine's IP is $IP. User is $UserName. Hostname is $hostname. PowerShell 
Version $Version. Today's Date is $DayOfWeek, $Date."

 Write-Host("$Report")