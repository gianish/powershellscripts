Get-Content .\test.csv | %{ $_.Split(',')[1]; }
Get-Content .\test.csv | %{ [int]$total+=$_.Split(',')[2]; } ; Write-Host "Total: $total"
#testing testing testingtestingtesting
