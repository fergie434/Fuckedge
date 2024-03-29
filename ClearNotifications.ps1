while ($true){
    [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
    $notifications = Get-ChildItem HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings | Select-Object Name
    for ($index = 0; $index -lt $notifications.Count; $index++) {
        $name = $notifications[$index]
        $split = $name -split "\\"
        $last = $split[$split.Count - 1]
        $last = $last.Substring(0, $last.Length - 1)
        $History = ([Windows.UI.Notifications.ToastNotificationManager]::History).GetHistory($last)
        $Count = ($History | Measure).Count
    
        if ($Count){
            ([Windows.UI.Notifications.ToastNotificationManager]::History).clear($last)
            write-host "Cleared $($last) Notifications"
        }
    }
    Start-Sleep -Seconds 3
}
