#myscript.ps1 <filename> <text-to-search> <replacing-text>
#anish king
#june 2018

#$text = $args[0]
#$replacer = $args[1]

function print-out(){
    Write-Host "$($args[0])"
    Write-Host "$($args[1])"
}

print-out

#function replace-text(){
#    $r = $r.Replace('{$FLAG}', $)
#}

#replace-text $FLAG



