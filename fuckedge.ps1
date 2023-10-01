while($true)
{
    get-process | Where-Object ProcessName -Like "*msedge*" | stop-process

    if ((get-process | Where-Object { $_.ProcessName -Like "*Diablo*" -or $_.ProcessName -like "*Cyber*"}).count -ne 0){
        if (-not (Get-MpPreference).DisableRealtimeMonitoring){
            Set-MpPreference -DisableRealtimeMonitoring $true
        }
    }
    else {
        if ( (Get-MpPreference).DisableRealtimeMonitoring){
            Set-MpPreference -DisableRealtimeMonitoring $false
        }
    }
start-sleep -seconds 3
}