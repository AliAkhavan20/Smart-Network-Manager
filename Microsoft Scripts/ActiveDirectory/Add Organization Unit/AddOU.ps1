#add Organization Unit to active directory....
#You can add active directory OU with this script...
#An active directory requied some features you can either use them or leave them be


#Make OU from OU's List

$userlist = import-csv -Path "Please enter destination source \\\ users list.csv" -Encoding UTF8

foreach ( $user in $userlist ) {
    $Des = # write down your description 
    New-ADOrganizationalUnit -name $item -Description $Des -Path "OU=920000,OU=Domain Objects,DC=PowerShell,DC=Local"
new-aduser
Invoke-Command -ComputerName 'dc' -ScriptBlock { ipconfig }

}