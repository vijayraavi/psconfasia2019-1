$script:rover = [PSCustomObject]@{
    X = 0
    Y = 0
    Direction = "N"
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

function Move-Rover ($Instruction) {
    if ("R" -eq $Instruction) {
        Turn-Right
    }

    if ("L" -eq $Instruction) {
        Turn-Left
    }

    if ("M" -eq $Instruction) {
        Move-Forward
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

    switch ($rover.Direction) {
        "N" { $rover.Y++ }
        "E" { $rover.X++ }
        "S" { $rover.Y-- }
        "W" { $rover.X-- }
    }
}

Export-ModuleMember -Function @( 
    "Set-Rover"
    "Get-Rover"
    "Move-Rover"
)