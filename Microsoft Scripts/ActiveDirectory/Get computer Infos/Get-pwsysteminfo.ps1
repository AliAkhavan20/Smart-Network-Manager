#Function
    #this function will extract the specific informations from
    #specific CIM-INSTANCEs 


#make A Function
function Get-pwsysteminfo {
 #the parameters for taking the cim instances
    param (
        $Pcname
    )
 #take the informations needed from CimInstance
    $osinfo      = Get-CimInstance -ComputerName $Pcname Win32_OperatingSystem 
    $computersys = Get-CimInstance -ComputerName $Pcname Win32_ComputerSystem
    $totalmemory = Get-CimInstance Win32_PhysicalMemory -ComputerName $Pcname | Measure-Object -Property capacity -Sum | Foreach {"{0}" -f ([math]::round(($_.Sum / 1MB),2))}
    $hardinfo    = Get-CimInstance Win32_DiskDrive -ComputerName $Pcname | Measure-Object -Property size -Sum | Foreach {"{0:N2}" -f ([math]::round(($_.Sum / 1GB),2))}
 #Make an object and add members 
$obj = new-object psobject
Add-Member -InputObject $obj -MemberType NoteProperty -Name "pcname" -Value $computersys.Name
Add-Member -InputObject $obj -MemberType NoteProperty -Name "oscaption" -Value $osinfo.Caption
Add-Member -InputObject $obj -MemberType NoteProperty -Name "osversion" -Value $osinfo.Version
Add-Member -InputObject $obj -MemberType NoteProperty -Name "osArchitecture" -Value $osinfo.OSArchitecture
Add-Member -InputObject $obj -MemberType NoteProperty -Name "totalmemory" -Value $totalmemory
Add-Member -InputObject $obj -MemberType NoteProperty -Name "hardinfo" -Value $hardinfo
Add-Member -InputObject $obj -MemberType NoteProperty -Name "pcusername" -Value $computersys.UserName
return $obj
}


$Find  = Get-ADComputer -Filter * | Where-Object -Property name -Like "server*" | Sort-Object -Property Name
$Find += Get-ADComputer -Filter * | Where-Object -Property name -Like "DC" 
$infoarray=@()


foreach ($item in $Find) {

$infoarray += Get-pwsysteminfo  $item.Name


}

$infoarray | export-csv -Path "Enter the path" -Encoding UTF8 -NoTypeInformation