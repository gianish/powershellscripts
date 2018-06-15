#myscript.ps1 <filename> <text-to-search> <replacing-text>
#anish king
#june 2018

$var1 = $args[0] 
$var2 = $args[1] 

get-content myfile.txt
#foreach-object {$_ -replace '$var1', '$var2'} |
#out-file myfile.txt