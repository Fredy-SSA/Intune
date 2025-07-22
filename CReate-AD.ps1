# Configurare IP static
    $adapter = Get-NetAdapter | Where-Object Status -eq 'Up'
    $adapter | New-NetIPAddress -IPAddress "192.168.0.1" `
                                -PrefixLength 24 `
                                -DefaultGateway "192.168.0.1"
    
    Set-DnsClientServerAddress -InterfaceIndex $adapter.InterfaceIndex `
                               -ServerAddresses "192.168.0.1"
    
    # Dezactivare firewall
    Set-NetFirewallProfile -All -Enabled False

    # Instalare AD
    Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
    Install-ADDSForest -DomainName TSR.Local `
                       -DomainMode "WinThreshold" `
                       -ForestMode "WinThreshold" `
                       -InstallDNS `
                       -Force
}