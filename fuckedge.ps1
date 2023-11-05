$Logfile = ".\fuckedge.log"

function WriteLog
{
    Param ([string]$LogString)
    $Stamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
    $LogMessage = "$Stamp $LogString"
    Add-content $LogFile -value $LogMessage
}
while($true)
{
    if ((get-process | Where-Object ProcessName -Like "*msedge*" ).count -gt 0 )
    {
        get-process | Where-Object ProcessName -Like "*msedge*" | stop-process
        WriteLog("Killed Edge")
    }


    if ((get-process | Where-Object { $_.ProcessName -Like "*Diablo*" -or $_.ProcessName -like "*Cyber*" -or $_.ProcessName -like "*Overwatch*"}).count -ne 0){
        if (-not (Get-MpPreference).DisableRealtimeMonitoring){
            Set-MpPreference -DisableRealtimeMonitoring $true
            WriteLog("Disabled AV")
        }
    }
    else {
        if ( (Get-MpPreference).DisableRealtimeMonitoring){
            Set-MpPreference -DisableRealtimeMonitoring $false
            WriteLog("Enabled AV")
        }
    }
start-sleep -seconds 3
}