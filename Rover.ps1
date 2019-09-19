# TASK 7 - write a client
Get-Module MarsRover | Remove-Module
Import-Module $PSScriptRoot/MarsRover.psm1

$instructions = ''
while ("Q" -ne $instructions) { 
    $Rover = Get-Rover
    "Rover is at $($rover.X),$($rover.Y),$($rover.Direction)"
    $instructions = Read-Host "Give instructions to the rover."
    Move-Rover -Instruction $script:instructions
}

"Bye!"


