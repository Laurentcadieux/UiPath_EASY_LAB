# Install AD DS and AD DNS
### Open Pwershell as Administrator 
### Install key services needed 
Add-WindowsFeature AD-Domain-Services, DNS -IncludeManagementTools
## Cheat code
#install chocolatey CHEAT CODE
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
#via chocolatey install sql-server with tools CHEAT CODE
netsh advfirewall firewall add rule name="SQL Server 1433" dir=in action=allow protocol=TCP localport=1433 profile=any enable=yes service=any
#via chocolatey install SQL Studio 
choco install sql-server-management-studio -y	
choco install putty.install --version=0.71 -y
shutdown -r
