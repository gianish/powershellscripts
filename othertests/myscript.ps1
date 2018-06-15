#myscript.ps1 <filename> <text-to-search> <replacing-text>
#anish king
#june 2018

$var0 = $args[0] 
$var1 = $args[1] 
$var2 = $args[2]

write-host $var0
write-host $var1
write-host $var2

#(Get-Content $var0) |
#Foreach-Object {$_ -replace '\[$FLAG\]','youyou'}  | 
#Set-Content $var0

#Get-Content $var0

$content = [System.IO.File]::ReadAllText("C:\Users\anish\Documents\Prometheus Work June 2018\working week2 june\powershellscripts\othertests\$var0").Replace("$var1","$var2")
[System.IO.File]::WriteAllText("C:\Users\anish\Documents\Prometheus Work June 2018\working week2 june\powershellscripts\othertests\$var0", $content)