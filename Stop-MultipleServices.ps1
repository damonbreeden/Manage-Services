<#
.SYNOPSIS
    This function connects to a number of different servers and starts the services listed, then sets the service(s) start action to Automatic
.PARAMETER Servers
    The servers to work with. Requires an array e.g @("server1", "server2"). Commas go between server names, but not at the end.
.PARAMETER Services
    The services to work with. Requires an array e.g @("service1", "service2"). Commas go between service names, but not at the end. Get Service names by running "Get-Service" and checking the Name column. Names with special characters must be enclosed by single quotes.
.PARAMETER StartupType
    The startup type to set. Defaults to Automatic. Valid choices are 'Automatic', 'Boot', 'Disabled', 'Manual' or 'System'
.PARAMETER Status
    The status to set the services to. Defaults to Running. Valid choices are 'Paused', 'Running' or 'Stopped'
.EXAMPLE
    Stop-MultipleServices -Servers @("server1", "server2") -Services @("Service1","Service2") -Status Stopped -StartupType Disabled
.NOTES
    Author: Damon Breeden
    Github: https://github.com/damonbreeden
#>

[CmdletBinding()]
param (
    [string[]]$Servers = @('vagrant-10'),

    [string[]]$Services = @('WlanSvc', 'XblAuthManager'),

    [ValidateSet('Automatic', 'Boot', 'Disabled', 'Manual', 'System')]
    [string]$StartupType = "Disabled",

    [ValidateSet('Paused', 'Running', 'Stopped')]
    [string]$status = "Stopped"
)

foreach ($s in $Servers) {
    foreach ($svc in $Services) {
        Get-Service -ComputerName $s -Name $svc |
        Set-Service -Status $status -StartupType $StartupType
    }
}