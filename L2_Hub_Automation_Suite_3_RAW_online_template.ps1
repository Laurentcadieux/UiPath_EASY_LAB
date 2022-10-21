##  ************************** Azure CLI VARIABLE FOR POWERSHELL ************************************
##  ************************** Azure CLI INSTALL REQUIRED   ************************************
$sub = "XXXXXXXXXXXXXXXXXXX" 
$region = "EastUS"
$tam = "XXXXXXXXXXXXXXXXXXX"
$resourceGroup  = "$tam-lab-hub-rg"
$subnetname = "hubsub"
$subnetiprange = "10.10.0.0/24"
$vm =  "azlab"
$user =  "uipadmin"
$pwd = "XXXXXXXXXXXXXXXXXXX"
$vnet = "labhubvnet"
$imageraw = "RedHat:RHEL:86-gen2:8.6.2022070802"
$staticIPDNS = "10.1.0.10"


az login
az account set -s $sub

az group create --location $region --name $resourceGroup  --tags owner="XXXXXXXXXXX&xxxx.com" project=TAM

##  ************************** Create vnet and subnet ************************************
az network vnet create --name $vnet --resource-group $resourceGroup --address-prefix $subnetiprange --subnet-name $subnetname 


az vm create --resource-group $resourceGroup  --name "$vm-01s" --location $region --size Standard_D16s_v3  --admin-username $user  --admin-password $pwd  --image $imageraw --vnet-name $vnet  --subnet $subnetname --zone 1 --public-ip-address '""'
az vm disk attach --resource-group $resourceGroup --vm-name "$vm-01s"  --name "$vm-01s-DataDisk"  --size-gb 2048 --sku StandardSSD_LRS  --new
az vm disk attach --resource-group $resourceGroup --vm-name "$vm-01s"  --name "$vm-01s-etcdDisk"  --size-gb 16 --sku StandardSSD_LRS  --new
az vm disk attach --resource-group $resourceGroup --vm-name "$vm-01s"  --name "$vm-01s-clusterDisk"  --size-gb 256 --sku StandardSSD_LRS  --new


az vm create --resource-group $resourceGroup  --name "$vm-02s" --location $region --size Standard_D16s_v3  --admin-username uipadmin  --admin-password $pwd  --image "RedHat:RHEL:86-gen2:8.6.2022070802" --vnet-name $vnet  --subnet $subnetname  --zone 2 --public-ip-address '""'
az vm disk attach --resource-group $resourceGroup --vm-name "$vm-02s"  --name "$vm-02s-DataDisk" --size-gb 2048 --sku StandardSSD_LRS  --new
az vm disk attach --resource-group $resourceGroup --vm-name "$vm-02s"  --name "$vm-02s-etcdDisk"  --size-gb 16 --sku StandardSSD_LRS  --new
az vm disk attach --resource-group $resourceGroup --vm-name "$vm-02s"  --name "$vm-02s-clusterDisk"  --size-gb 256 --sku StandardSSD_LRS  --new

az vm create --resource-group $resourceGroup  --name "$vm-03s" --location $region --size Standard_D16s_v3  --admin-username uipadmin  --admin-password $pwd  --image "RedHat:RHEL:86-gen2:8.6.2022070802" --vnet-name $vnet  --subnet $subnetname  --zone 2 --public-ip-address '""'
az vm disk attach --resource-group $resourceGroup --vm-name "$vm-03s" --name "$vm-03s-DataDisk" --size-gb 2048 --sku StandardSSD_LRS  --new
az vm disk attach --resource-group $resourceGroup --vm-name "$vm-03s"  --name "$vm-03s-etcdDisk"  --size-gb 16 --sku StandardSSD_LRS  --new
az vm disk attach --resource-group $resourceGroup --vm-name "$vm-03s"  --name "$vm-03s-clusterDisk"  --size-gb 256 --sku StandardSSD_LRS  --new

