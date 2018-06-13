# june 2018
# anish king
# downloads demo plan pkg from promdev
# runs for x amt of yrs

$workDir = "C:\Users\anish\Documents\Prometheus Work June 2018\working week2 june\powershellscripts\othertests"
$years = 5

function download-plan($workDir) {
    promctl downloadplan --env:promdev --output:"$workDir\results" --planId:Demo.City.General.v1.0
}

function run-plan($workDir) {
    promctl calc --input:"$workDir\results" --output:"$workDir\results" --years:$years
}

download-plan $workDir
run-plan $workDir
