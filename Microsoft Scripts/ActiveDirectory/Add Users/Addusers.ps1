#add users to active directory....
#You can add active directory users with this script...
#An active directory requied some features you can either use them or leave them be


#Make users out of users List

$userlist = import-csv -Path "I:\pws\My pws\Smart-Network-Manager\Microsoft Scripts\ActiveDirectory\Add Users\users list.csv" -Encoding UTF8

foreach ( $user in $userlist ) {

$Des = # write down your description 
New-ADOrganizationalUnit -ComputerName $user  -Description $Des -Path "OU=920000,OU=Domain Objects,DC=PowerShell,DC=Local"
Invoke-Command -ComputerName 'dc' -ScriptBlock { ipconfig }


}


