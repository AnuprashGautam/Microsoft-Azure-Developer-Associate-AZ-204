$Location="North Europe"
$ResourceGroupName="web-grp"

New-AzResourceGroup -Name $ResourceGroupName -Location $Location

$AppServicePlanName="learningplan7000"

New-AzAppServicePlan -ResourceGroupName $ResourceGroupName -Name $AppServicePlanName `
-Location $Location -Tier Free

$AppName="leaningapp588787"

New-AzWebApp -ResourceGroupName $ResourceGroupName -Location $Location -Name $AppName `
-AppServicePlan $AppServicePlanName