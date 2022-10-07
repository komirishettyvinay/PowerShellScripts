Install -module PSExcel

$excel = Open-ExcelPackage _path 'ExcelRG.xlxs'

$sheet = $excel.Workbook.Worksheets['sheet1']

$row_max = $sheet.Dimension.Rows

 For($i=2 ; $i -le $row_max ; $i++){
  
    $sub_id = $sheet.Cells.Item($i,1).Value
    $rg_name = $sheet.Cells.Item($i,2).Value
    $loc = $sheet.Cells.Item($i,3).Value
    $humappid = $sheet.Cells.Item($i,4).Value
    $ClarityBillingID = $sheet.Cells.Item($i,5).Value
    $Env = $sheet.Cells.Item($i,6).Value
    $privacylevel = $sheet.Cells.Item($i,7).Value
    $supportgroup = $sheet.Cells.Item($i,8).Value
    $Dept = $sheet.Cells.Item($i,9).Value
    #$Owners = $sheet.Cells.Item($i,10).Value
    Select-AzSubscription -Subscription $sub_id
    New-AzureRmResourceGroup -Name "$rg_name" -Location "$loc" -Tag @{"eapmid"="$humappid"; "billing-ids"="$ClarityBillingID"}

}

$rg_notcreated = @()

$rg_created = @()

$a = 0

$b = 0

For ($i=2 ; $i -le $row_max ; $i++){
    $sub_id = $sheet.Cells.Item($i,1).Value
    $rg_name = $sheet.Cells.Item($i,2).Value
    Select-AzSubscription -Subscription $sub_id
    $rg = Get-AzureRMResourceGroup -Name $rg_name -ErrorAction SilentlyContinue
    if ($rg) {
            $rg_created += $rg_name
            $a = $a+1
    }
    else{
            $rg_notcreated += $rg_name
            $b = $b+1
    }
}

Write-Host "Number of Resource Groups created are :" $a

Write-Host "Number of Resource Groups Not created are :" $b

$rg_created | Out-File .\CreatedRGs.txt

$rg_created | Out-File .\NotCreatedRGs.txt

Write-Host "Check CreatedRGs.txt for Resource Groups that are created"

Write-Host "Check NotCreatedRGs.txt for Resource Groups that are Not created" 