Connect-AzAccount

$Location="North Europe"
$ResourceGroupName="web-grp"

$AppServicePlanName="learningplan8650978458"

New-AzAppServicePlan -ResourceGroupName $ResourceGroupName -Name $AppServicePlanName `
-Location $Location -Tier Basic

$AppName="learningapp8650978458"

New-AzWebApp -ResourceGroupName $ResourceGroupName -Location $Location -Name $AppName `
-AppServicePlan $AppServicePlanName

$gitrepo="https://github.com/AnuprashGautam/learningapp"

$PropertiesObject = @{
    repoUrl = $gitrepo;
    branch = "main";
    isManualIntegration = "true";
}

Set-AzResource -PropertyObject $PropertiesObject -ResourceGroupName $ResourceGroupName `
-ResourceType Microsoft.Web/sites/sourcecontrols `
-ResourceName $AppName/web -ApiVersion 2015-08-01 -Force
