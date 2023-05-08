Install -module PSExcel

$excel = Open-ExcelPackage _path 'Vnetintegration.xlxs'

$sheet = $excel.Workbook.Worksheets['sheet1']

$row_max = $sheet.Dimension.Rows

$rg_count = 0

For($i=2 ; $i -le $row_max ; $i++){
  
    $siteName = $sheet.Cells.Item($i,1).Value
    $resourceGroupName = $sheet.Cells.Item($i,2).Value
    $vNetName = $sheet.Cells.Item($i,3).Value
    $integrationSubnetName = $sheet.Cells.Item($i,4).Value
    $subscriptiongID = $sheet.Cells.Item($i,5).Value
    $vresourceGroupName = $sheet.Cells.Item($i,6).Value

    Select-AzSubscription -Subscription $subscriptiongID

    $subnetResourceId= "/subscriptions/$subscriptionId/resourceGroups/$vresourceGroupName/providers/Microsoft.Network/virtualNetworks/$vNetName/subnets/$integrationSubnetName"
    $webApp= Get-AzResource _ResourceType Microsoft.web/sites -ResourceGroupName $resourceGroupName -ResourceName $siteName
    $webApp.Properties.virtualNetworkSubnrtId = $subnetResourceId
    $webApp | Set-AzResource -Force

    $rg_count = $rg_count+1

    sleep -Seconds 10 
}