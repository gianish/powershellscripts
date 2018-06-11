param([string]$version)

$name = 'Vacaville-CA.OPEB'

if($version -eq '') {
    write-host 'Error - version number required (-version parameter)'
    exit
}

& $PSScriptRoot\prep.ps1

$BUs = @('AMG', 'CC', 'DH', 'EL39', 'FMG', 'VCEA', 'VFA', 'VMO', 'VPMA', 'VPOA')

$runBase = join-path $PSScriptRoot 'run'
$packageBase = join-path $PSScriptRoot 'package'

rm -rec -for $packageBase -ea SilentlyContinue

$files = @('amort.json', 'plan.json', 'newissues.csv', 'census.csv', 'tables')

function package-plan($workDir, $packageName) {
    pushd $workDir; 7z a $packageName $files; popd
}

foreach($bu in $BUs) {
    $workDir = join-path $runBase $bu
    $packageName = join-path $packageBase "$name.$bu.v$version.zip"
    
    package-plan $workDir $packageName
}