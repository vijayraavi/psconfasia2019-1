$script:rover = [PSCustomObject]@{
    X = 0
    Y = 0
    Direction = "N"
}
function Get-Rover () {
    $script:rover
}

function  Set-Rover ($Direction) { 
    $r = Get-Rover
    $r.Direction = $Direction
}

function Move-Rover ($Instruction) {
    if ("R" -eq $Instruction) {
        Turn-Right
    }
    if ("L" -eq $Instruction) {
        Turn-Left
    }
}

function Turn-Right {
    $rover = Get-Rover
    $direction = switch ($rover.Direction) { 
        "N" { "E" }
        "E" { "S" }
        "S" { "W" }
        "W" { "N" }
    }

    Set-Rover -Direction $direction
}

function Turn-Left {
    $rover = Get-Rover
    $direction = switch ($rover.Direction) { 
        "N" { "W" }
        "W" { "S" }
        "S" { "E" }
        "E" { "N" }
    }

    Set-Rover -Direction $direction
}

Export-ModuleMember -Function @( 
    "Set-Rover"
    "Get-Rover"
    "Move-Rover"
)