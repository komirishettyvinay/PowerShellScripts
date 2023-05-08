param(
       [Parameter(Mandatory=$true)]
       [string]$applicationisd,

       [Parameter(Mandatory=$true)]
       [string]$department,

       [Parameter(Mandatory=$true)]
       [ValidateSet('dev','int','qa','non-prod','prod')]
       [string]$environment,


       )
Write-Host "Provide mandatory details for RG"

$subscription = Read-Host "Enter the subscription name or ID"

$a = Select-AzSubscription -Subscription $subscription -ErrorAction SilentlyContinue

if($null -eq $a){Throw "Incorrect subscription provided."}

$rgName = Read-Host "Enter Resource Group Name"
$location = Read-Host "Type E of eastus2 or C for centralUS"
if($location -eq "E"){$location = "East Us 2"}
elseif($location -eq "C"){$location = "CentralUS"}
else{Throw "Location provided is incorrect."}
if(!(applicationid -match '^APP*')){Throw "application id must starts with APP."}
New-AzureRmResourceGroup -Name "$rgname" -Location "$location" -Tag @{"application-id"="$application-id";"department"=$department;"environment"="$environment"} 