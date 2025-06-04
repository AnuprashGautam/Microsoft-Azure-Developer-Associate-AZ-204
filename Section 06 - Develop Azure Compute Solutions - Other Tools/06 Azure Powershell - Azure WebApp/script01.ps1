$Location="North Europe"
$ResourceGroupName="web-grp"

New-AzResourceGroup -Name $ResourceGroupName -Location $Location

$AppServicePlanName="learningplan8650978458"

New-AzAppServicePlan -ResourceGroupName $ResourceGroupName -Name $AppServicePlanName `
-Location $Location -Tier Free

$AppName="learningapp8650978458"

New-AzWebApp -ResourceGroupName $ResourceGroupName -Location $Location -Name $AppName `
-AppServicePlan $AppServicePlanName