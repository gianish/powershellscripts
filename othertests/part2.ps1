# june 2018
# anish king
# downloads demo plan pkg from promdev
# runs for x amt of yrs


$years = 5

function download-plan($workDir) {
    promctl downloadplan --
}

function run-plan($workDir) {
    promctl calc --input:$workDir --output:"$workDir\results" --years:$years
}

