echo "hello world"
# Install AD DS and AD DNS
### Open Pwershell as Administrator 
### Install key services needed 
Add-WindowsFeature AD-Domain-Services, DNS -IncludeManagementTools 
# DC PROMO WITH DNS
Install-ADDSForest -CreateDnsDelegation:$false -DomainName "uipathlab.com" -DomainNetbiosName "uipathlab" -DatabasePath "c:\Windows\NTDS" -InstallDns:$true -LogPath "c:\Windows\NTDS" -NoRebootOnCompletion:$false -SysvolPath "c:\Windows\SYSVOL" -Force:$true  -DomainMode "WinThreshold" -ForestMode "WinThreshold"
## You will be asked to provide a Password.
## Server will reboot after 

### RDP to your new future Domain Controller 
### Open Pwershell as Administrator
# ADD User & Groups
$Password = Read-Host -AsSecureString
New-LocalUser "User1" -Password $Password -FullName "User1" -Description "Test user account" -AccountNeverExpires
New-LocalUser "User2" -Password $Password -FullName "User2" -Description "Test user account" -AccountNeverExpires
New-LocalUser "User3" -Password $Password -FullName "User3" -Description "Test user account" -AccountNeverExpires
New-LocalUser "User4" -Password $Password -FullName "User4" -Description "Test user account" -AccountNeverExpires
New-LocalUser "uipdbadmin" -Password $Password -FullName "uipDBadmin" -Description "DB owner Uipathlab" -AccountNeverExpires
New-LocalUser "uipsqladmin" -Password $Password -FullName "uipSQLadmin" -Description "SQL admin Uipathlab" -AccountNeverExpires
New-LocalUser "uipkerbadmin" -Password $Password -FullName "uipKERBadmin" -Description "kerb services account" -AccountNeverExpires
New-LocalUser "uiporchbadmin" -Password $Password -FullName "uipOrchadmin" -Description "Orchestrator admin account" -AccountNeverExpires

New-LocalGroup -Name "teamA"
New-LocalGroup -Name "teamB"
## Server will reboot after 


## Cheat code

#install chocolatey CHEAT CODE
 [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

#via chocolatey install sql-server with tools CHEAT CODE
choco install sql-server-2019 -y  /IsoPath:"c:\downloads\SQLServer2019-x64-ENU-Dev.iso"


# SQL Server 2019 Configuration Manager
#	-Enable TCP/IP 1433
#   -Restart SQL Server

netsh advfirewall firewall add rule name="SQL Server 1433" dir=in action=allow protocol=TCP localport=1433 profile=any enable=yes service=any
# SQL Server 2019 Installation Center (64-bit)
#    - Mount the install DVD ( Path in the Choco installation output)
#    - next next ( add feature to exisitng server)
#	- add Full-Text Search ( attach ISO and add feature to existing instance )
#	- next, install , wait then close.

#via chocolatey install SQL Studio 
choco install sql-server-management-studio -y	

# Microsoft SQL Server Management Studio 18
#	- Enable SA (Enabl login)
#	- Reset SA password
#	- Enable SQL Server and Windows Authentication mode
#	- restart SQL server
#	- Try an ODBC connect via SA
	

choco install putty.install --version=0.71 -y