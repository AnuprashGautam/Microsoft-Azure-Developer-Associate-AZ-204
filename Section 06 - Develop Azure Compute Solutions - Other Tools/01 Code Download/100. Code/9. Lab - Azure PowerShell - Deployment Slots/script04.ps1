
$ResourceGroupName="web-grp"
$AppServicePlanName="learningplan7000"
$AppName="leaningapp588787"

Set-AzAppServicePlan -Name $AppServicePlanName -ResourceGroupName $ResourceGroupName -Tier Standard

New-AzWebAppSlot -Name $AppName -ResourceGroupName $ResourceGroupName -Slot "staging"

$gitrepo="https://github.com/cloudlearning4000/learningapp"

$PropertiesObject = @{
    repoUrl = $gitrepo;
    branch ="main";
    isManualIntegration = "true";
}

Set-AzResource -PropertyObject $PropertiesObject -ResourceGroupName $ResourceGroupName `
-ResourceType Microsoft.Web/sites/slots/sourcecontrols `
-ResourceName $AppName/staging/web -ApiVersion 2015-08-01 -Force

