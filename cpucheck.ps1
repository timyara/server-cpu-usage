<# 
 .Synopsis
  Pulls the Cpu Usage for a given server.
 .Description
  Pulls the Cpu Usage for a given server. This may be run on multiple servers
 .Parameter Computername
  The server(s) to seek cpu usage on.
  
 .Example
   # Show a single server 
   Get-ServerUsage -Computername server01
 .Example
   # Display multiple servers
   Get-ServerUsage -Computername server01,server02
#>


[CmdLetBinding()]
    Param(
    [Parameter(Mandatory=$true)][string[]]$Computername
          )
function Get-ServerUsage{

foreach($i in $Computername){

$proc =get-counter -Counter "\Processor(_Total)\% Processor Time" -SampleInterval 2 -ComputerName $i
[int]$cpu=($proc.readings -split ":")[-1]

$properties = @{'Name'=$i;
                'CpuUsage'=$cpu}
$Server= New-Object -TypeName PSobject -Property $properties
Write-Output $Server
}

}
Get-ServerUsage
