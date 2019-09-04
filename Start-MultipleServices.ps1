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
    Start-MultipleServices -Servers @("server1", "server2") -Services @("Service1","Service2") -StartupType Automatic -Status Running
.NOTES
    Author: Damon Breeden
    Github: https://github.com/damonbreeden
#>

[CmdletBinding()]
param (
    [string[]]$Servers = @('navappx', 'navapp7', 'navapp9', 'navapp8', 'navapp6', 'navapp5', 'navapp4', 'navapp3', 'navapp2', 'navapp'),

    [string[]]$Services = @('MicrosoftDynamicsNavServer$PROD', 'MicrosoftDynamicsNavServer$PROD_BOOMIWS', 'MicrosoftDynamicsNavServer$PROD_CUSTOMERWS', 'MicrosoftDynamicsNavServer$PROD_MobileNAV', 'MicrosoftDynamicsNavServer$PROD_NAS', 'MicrosoftDynamicsNavServer$PROD_O365', 'MicrosoftDynamicsNavServer$PROD_Public', 'MicrosoftDynamicsNavServer$PROD_WebClient', 'MicrosoftDynamicsNavServer$PROD_Admin', 'MicrosoftDynamicsNavServer$PROD_Admin_EXT'),

    [ValidateSet('Automatic', 'Boot', 'Disabled', 'Manual', 'System')]
    [string]$StartupType = "Automatic",

    [ValidateSet('Paused', 'Running', 'Stopped')]
    [string]$status = "Running"
)

foreach ($s in $Servers) {
    foreach ($svc in $Services) {
        Get-Service -ComputerName $s -Name $svc |
        Set-Service -Status $status -StartupType $StartupType
    }
}