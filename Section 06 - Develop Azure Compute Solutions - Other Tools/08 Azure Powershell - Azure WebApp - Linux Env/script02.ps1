$Location="North Europe"
$ResourceGroupName="web-grp"

$AppServicePlanName="learningplan86509784580"

New-AzAppServicePlan -ResourceGroupName $ResourceGroupName -Name $AppServicePlanName `
-Location $Location -Tier Free -Linux

$AppName="learningapp86509784580"

New-AzWebApp -ResourceGroupName $ResourceGroupName -Location $Location -Name $AppName `
-AppServicePlan $AppServicePlanName