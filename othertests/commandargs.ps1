# june 2018
# Anish King
# "command parameter as argument" script

param([string]$command)

if ($command -eq 'command1'){
     write-host 'output1'
     exit
}

if ($command -eq 'command2'){
     write-host 'output2'
     exit
}

if ($command -eq 'command3'){
     write-host 'output3'
     exit
}