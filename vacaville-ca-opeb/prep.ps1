$BUs = @('AMG', 'CC', 'DH', 'EL39', 'FMG', 'VCEA', 'VFA', 'VMO', 'VPMA', 'VPOA')

$planTemplateFile = join-path $PSScriptRoot 'plan-template.json'
$planTemplate = [IO.File]::ReadAllText($planTemplateFile)

$amortTemplateFile = join-path $PSScriptRoot 'amort-template.json'
$amortTemplate = [IO.File]::ReadAllText($amortTemplateFile)

$replacementsFile = join-path $PSScriptRoot 'replacements.csv'
$replacements = import-csv $replacementsFile

$censusInFile = join-path $PSScriptRoot 'census-in.csv'
$newIssuesInFile = join-path $PSScriptRoot 'newissues-in.csv'

$tablesSrc = join-path $PSScriptRoot 'tables'

$runBase = join-path $PSScriptRoot 'run'
rm -rec -for $runBase -ea SilentlyContinue

function write-template($template, $bu, $outFile) {
    $r = $template
    $repl = $replacements | ?{ $_.BU -eq $bu }

    $r = $r.Replace('{FriendlyName}', $repl.FriendlyName)
    $r = $r.Replace('{Assets}', $repl.Assets)
    $r = $r.Replace('{AmortHistory}', $repl.AmortHistory)
    $r = $r.Replace('{ERNCHistoryPct}', $repl.ERNCHistoryPct)
    $r = $r.Replace('{SalaryAdj}', $repl.SalaryAdj)
    $r = $r.Replace('{ActiveBenAdj}', $repl.ActiveBenAdj)
    $r = $r.Replace('{ORM1RetAdj}', $repl.ORM1RetAdj)
    $r = $r.Replace('{ORM2RetAdj}', $repl.ORM2RetAdj)
    $r = $r.Replace('{ORD1RetAdj}', $repl.ORD1RetAdj)
    $r = $r.Replace('{ORD2RetAdj}', $repl.ORD2RetAdj)

    [IO.File]::WriteAllText($outFile, $r)
}

function filter-census($bu, $inFile, $outFile) {
    $buPrefix = "$($bu)."
    $inputCensus = import-csv $inFile | ?{ $_.BargainingUnit.StartsWith($buPrefix) -and $_.Weight -gt 0 }
    foreach ($row in $inputCensus) {
        if($row.Status -eq 'Active') {
            $row.BargainingUnit = 'A' + $row.BargainingUnit.Split('.')[1]
        } else {
            if($row.Status -eq 'ServiceDisabled' -and $row.Classification -eq 'Misc') {
                $row.Status = 'Disabled'
            }
            $row.BargainingUnit = 'R' + $row.BargainingUnit.Split('.')[1]
        }
    }
    $inputCensus | export-csv $outFile -NoTypeInformation
    [IO.File]::WriteAllText($outFile, [IO.File]::ReadAllText($outFile).Replace("`"`"", ""))
}

function setup-plan($bu) {
    $workDir = join-path $runBase $bu
    mkdir $workDir | out-null
    write-template $planTemplate $bu (join-path $workDir 'plan.json')
    write-template $amortTemplate $bu (join-path $workDir 'amort.json')
    cp -rec $tablesSrc $workDir | out-null
    filter-census $bu $censusInFile (join-path $workDir 'census.csv')
    filter-census $bu $newIssuesInFile (join-path $workDir 'newissues.csv')
}

foreach($bu in $BUs) {
    setup-plan $bu
}