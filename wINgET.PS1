# Verificăm dacă WinGet este instalat
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Output "WinGet nu este instalat. Instalarea va fi inițiată."
    # Comanda pentru a instala WinGet (asigura-te ca ai setările corecte pentru a permite instalarea)
    Start-Process "powershell.exe" -ArgumentList "scoop install winget" -Wait -NoNewWindow
}

# Verificăm din nou dacă WinGet este acum disponibil
if (Get-Command winget -ErrorAction SilentlyContinue) {
    Write-Output "WinGet este disponibil. Continuăm cu actualizările."

    # Executăm comanda de upgrade pentru toate aplicațiile
    $upgradeOutput = winget upgrade --all --accept-source-agreements --accept-package-agreements

    # Generăm un raport
    $logPath = "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\winget_upgrade_report.txt"
    $upgradeOutput | Out-File -FilePath $logPath -Encoding utf8

    Write-Output "Actualizările au fost finalizate. Raportul este disponibil la: $logPath"
} else {
    Write-Output "WinGet nu a putut fi instalat. Asigurați-vă că aveți permisiunile necesare."
}

# Scriptul se va termina aici
exit