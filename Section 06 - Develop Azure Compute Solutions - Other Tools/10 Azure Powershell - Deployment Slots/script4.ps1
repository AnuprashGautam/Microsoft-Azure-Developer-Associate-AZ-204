$ResourceGroupName="web-grp"
$AppServicePlanName="learningplan8650978458"
$AppName="learningapp8650978458"

Set-AzAppServicePlan -Name $AppServicePlanName -ResourceGroupName $ResourceGroupName -Tier Standard

New-AzWebAppSlot -Name $AppName -ResourceGroupName $ResourceGroupName -Slot "staging"

$gitrepo="https://github.com/AnuprashGautam/learningapp"

$PropertiesObject = @{
    repoUrl = $gitrepo;
    branch ="main";
    isManualIntegration = "true";
}

Set-AzResource -PropertyObject $PropertiesObject -ResourceGroupName $ResourceGroupName `
-ResourceType Microsoft.Web/sites/slots/sourcecontrols `
-ResourceName $AppName/staging/web -ApiVersion 2015-08-01 -Force