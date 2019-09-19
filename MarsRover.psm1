$script:rover = [PSCustomObject]@{
    X = 0
    Y = 0
    Direction = "N"
    PathBlocked = $false
}
function Get-Rover () {
    $script:rover
}

function  Set-Rover { 
    [CmdletBinding()]
    param (
        [string] $Direction, 
        [int] $X, 
        [int] $Y
    )
    
    $r = Get-Rover
    if ($PSBoundParameters.ContainsKey('Direction')) { 
        $r.Direction = $Direction
    }

    if ($PSBoundParameters.ContainsKey('X')) { 
        $r.X = $X
    }
    
    if ($PSBoundParameters.ContainsKey('Y')) { 
        $r.Y = $Y
    }
}

function Move-Rover ($Instruction, $Obstacle) {
    foreach ($i in $Instruction -split "") {
        if ("R" -eq $i) {
            Turn-Right
        }

        if ("L" -eq $i) {
            Turn-Left
        }

        if ("M" -eq $i) {
            Move-Forward
        }
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

function Move-Forward {
    $rover = Get-Rover

    $nextStep = switch ($rover.Direction) {
        "N" { @{ Y = $rover.Y + 1; X = $rover.X; } }
        "E" { @{ Y = $rover.Y;     X = $rover.X + 1; } }
        "S" { @{ Y = $rover.Y - 1; X = $rover.X; } }
        "W" { @{ Y = $rover.Y;     X = $rover.X - 1; } }
    }

    # wrapping world
    if ($nextStep.Y -eq 6) {
        $nextStep.Y = -5
    }
    if ($nextStep.Y -eq -6) {
        $nextStep.Y = 5
    } 
    if ($nextStep.X -eq 6) {
        $nextStep.X = -5
    }
    if ($nextStep.X -eq -6) {
        $nextStep.X = 5
    } 

    # detecting obstacles
    $o = $script:obstacles | where { $_.X -eq $nextStep.X -and $_.Y -eq $nextStep.Y }
    
    $rover.PathBlocked = $null -ne $o
    if ($rover.PathBlocked) {    
        return
    }
    else {
        $rover.X = $nextStep.X
        $rover.Y = $nextStep.Y
    }
}

function Set-RoverObstacle ($Obstacle) {
    $script:obstacles = $Obstacle
}
 
Export-ModuleMember -Function @( 
    "Set-Rover"
    "Get-Rover"
    "Move-Rover"
    "Set-RoverObstacle"
)