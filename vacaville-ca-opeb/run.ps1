$BUs = @('AMG', 'CC', 'DH', 'EL39', 'FMG', 'VCEA', 'VFA', 'VMO', 'VPMA', 'VPOA')
$years = 30

& $PSScriptRoot\prep.ps1

$runBase = join-path $PSScriptRoot 'run'

function run-plan($workDir) {
    promctl calc --input:$workDir --output:"$workDir\results" --years:$years
}

$fsOutput = @()

function summarize-output($workDir, $bu) {
    $resultsDir = join-path $workdir 'results'
    $script:fsOutput += (import-csv (join-path $resultsDir 'fs-0-0-Status.csv') | %{ $_ | add-member -membertype NoteProperty -name 'BU' -value $bu; $_ })
}

foreach($bu in $BUs) {
    $workDir = join-path $runBase $bu
    run-plan $workDir
    summarize-output $workDir $bu
}

$resultsDir = mkdir (join-path $runBase 'results')

$fsOutput | export-csv -noTypeInformation (join-path $resultsDir 'fs-0-0-Status.csv')
