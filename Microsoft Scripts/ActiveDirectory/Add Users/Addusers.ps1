#add users to active directory....
#You can add active directory users with this script...
#An active directory requied some features you can either use them or leave them be


#Make users out of users List

$userlist = import-csv -Path "I:\pws\My pws\Smart-Network-Manager\Microsoft Scripts\ActiveDirectory\Add Users\users list.csv" -Encoding UTF8


foreach ( $user in $userlist ) {


#Make Defult password for users        password is 2times identety code
$Pass = "AAA" + $User.'user logon name' 
$SecPass = ConvertTo-SecureString -String $Pass -AsPlainText -Force

    $Des = # write down your description 


    New-ADUser -Name $user.Firstname
               -OfficePhone $user.'Tel number'
               -DisplayName $user.'Display name'
               -SamAccountName $user.'user logon name'
               -UserPrincipalName $User.'user logon name'
               -AccountPassword $SecPass
               -PasswordNeverExpires
               -Description $Des
               -Path "OU=920000,OU=Domain Objects,DC=PowerShell,DC=Local"
    

    Invoke-Command -ComputerName 'dc' -ScriptBlock { ipconfig }

}