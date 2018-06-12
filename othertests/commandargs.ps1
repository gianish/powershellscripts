# june 2018
# Anish King
# "command parameter as argument" script

param([string]$command)

if ($command -eq 'command1'){
     write-host 'command1 => output1'
     exit
}

if ($command -eq 'command2'){
     write-host 'command2 => output2'
     exit
}

if ($command -eq 'command3'){
     write-host 'command3 => output3'
     exit
}

else {'invalid command, try again'}