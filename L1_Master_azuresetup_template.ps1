##  ************************** Azure CLI VARIABLE FOR POWERSHELL ************************************
##  ************************** Azure CLI INSTALL REQUIRED   ************************************
################################################### UPDATE 1
$sub = "XXXXXXXXXXX" 
$region = "EastUS"
################################################### UPDATE 2
$tam = "XXXXXXXXXXX"
$resourceGroup  = "$tam-lab-master-rg"
$subnetiprange = "10.1.0.0/24"
$subnamebas = "AzureBastionSubnet"
$subnetbastion = "10.1.0.128/26"
$publicITbastion = "publicITbastion"
$subnamefw = "AzureFirewallSubnet"
$subnetfirewall = "10.1.0.64/26"
$subnamemain = "main"
$subnetmain = "10.1.0.0/26"




$vm =  "azlab"
$user =  "uipadmin"
## The password length must be between 12 and 123. Password must have the 3 of the following: 1 lower case character, 1 upper case character, 1 number and 1 special character.
################################################### UPDATE 3
$pwd = "XXXXXXXXXXX"
################################################### UPDATE 4
$vnet = "XXXXXXmastervnet"
$imageraw = "Win2019Datacenter"
$staticIP = "10.1.0.10"

az login
az account set -s $sub
##  ************************** Create Resouces group ************************************
################################################### UPDATE YOUR WITH YOUR EMAIL
az group create --location $region --name $resourceGroup  --tags owner=XXXXXXXX@uipath.com project=TAM
###############################################################################
##  ************************** Create vnet and subnet main ************************************
az network vnet create --name $vnet --resource-group $resourceGroup --address-prefix $subnetiprange --subnet-name $subnamemain  --subnet-prefixes $subnetmain
##  ************************** Create subnet bastion ************************************
az network vnet subnet create -g $resourceGroup --vnet-name $vnet -n $subnamebas  --address-prefix $subnetbastion
##  ************************** Create subnet firewall ************************************
az network vnet subnet create -g $resourceGroup --vnet-name $vnet -n $subnamefw  --address-prefix $subnetfirewall
##  ************************** Create subnet gateway ************************************

##  ************************** Create  bastion public NIC ************************************
az network public-ip create --resource-group $resourceGroup --name $publicITbastion --sku Standard --location $region

##  ************************** Create  bastion  ************************************
az network bastion create --name MyBastion --public-ip-address $publicITbastion --resource-group $resourceGroup --vnet-name $vnet --location $region


##  ************************** Create Windows VM  ************************************
az vm create --resource-group $resourceGroup  --name "$vm-dcsql01s" --location $region --size Standard_D2_v4  --admin-username $user  --admin-password $pwd  --image $imageraw --vnet-name $vnet  --subnet $subnamemain --zone 1  --private-ip-address $staticIP --public-ip-address '""'
##  ************************** Windows VM install step 1  ************************************
az vm run-command invoke -g $resourceGroup -n "$vm-dcsql01s" --command-id RunPowerShellScript --scripts "[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Laurentcadieux/UiPath_EASY_LAB/main/L1_master_win_dc_sql.ps1'))"
