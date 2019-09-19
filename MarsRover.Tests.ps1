Describe "Get-Rover" {
    BeforeEach {
        Get-Module MarsRover | Remove-Module
        Import-Module $PSScriptRoot/MarsRover.psm1
    }

    # TASK 1 - ICEBREAKER TEST 2
    # It "Starts at 0,0,N" {
    #     $actual = Get-Rover

    #     $actual.X | Should -Be 0
    #     $actual.Y | Should -Be 0
    #     $actual.Direction | Should -Be "N"
    # }
}

# Describe "Set-Rover" {
#     BeforeEach {
#         Get-Module MarsRover | Remove-Module
#         Import-Module $PSScriptRoot/MarsRover.psm1
#     }

#     It "Sets the Direction" { 
#         Set-Rover -Direction "E"
#         $actual = Get-Rover 
#         $actual.Direction | Should -Be "E" 
#     }

#     It "Sets the X position" { 
#         Set-Rover -X 10
#         $actual = Get-Rover 
#         $actual.X | Should -Be 10 
#     }

#     It "Sets the Y position" { 
#         Set-Rover -Y 11
#         $actual = Get-Rover
#         $actual.Y | Should -Be 11
#     }
# }

Describe "Move-Rover" {
    BeforeEach {
        Get-Module MarsRover | Remove-Module
        Import-Module $PSScriptRoot/MarsRover.psm1
    }

    # TASK 1 - ice breaker test
    # It "Does nothing when it gets no instruction" {
    #     $expected = Get-Rover

    #     Move-Rover 

    #     $actual = Get-Rover
    #     $actual | Should -Not -BeNullOrEmpty
    #     $actual.X | Should -Be $expected.X
    #     $actual.Y | Should -Be $expected.Y
    #     $actual.Direction | Should -Be $expected.Direction
    # }

    # TASK 2 - Turning right
    # It "Turns to right from 0,0,N" {
    #     $expected = "E"

    #     Move-Rover -Instruction "R"

    #     $actual = Get-Rover
    #     $actual.Direction | Should -Be $expected
    # }

    # It "Turns to right from 0,0,E" {
    #     $expected = "S"
    #     Set-Rover -Direction "E"

    #     Move-Rover -Instruction "R"

    #     $actual = Get-Rover
    #     $actual.Direction | Should -Be $expected
    # }

    # TASK 3 - turning right from any direction
    # It "Turns to right from 0,0,<direction>" -TestCases @( 
    #     @{ Direction = "N"; Expected = "E" }
    #     @{ Direction = "E"; Expected = "S" }
    #     @{ Direction = "S"; Expected = "W" }
    #     @{ Direction = "W"; Expected = "N" }
    # ) {
    #     param ($Direction, $Expected)
    #     Set-Rover -Direction $Direction

    #     Move-Rover -Instruction "R"

    #     $actual = Get-Rover
    #     $actual.Direction | Should -Be $Expected
    # }

    # TASK 4 - turning left from any direction
    # It "Turns to left from 0,0,<direction>" -TestCases @( 
    #     @{ Direction = "N"; Expected = "W" }
    #     @{ Direction = "W"; Expected = "S" }
    #     @{ Direction = "S"; Expected = "E" }
    #     @{ Direction = "E"; Expected = "N" }
    # ) {
    #     param ($Direction, $Expected)
    #     Set-Rover -Direction $Direction

    #     Move-Rover -Instruction "L"

    #     $actual = Get-Rover
    #     $actual.Direction | Should -Be $Expected
    # }

    # TASK 5 - moving forward
    # It "Moves in the direction <direction>" -TestCases @(
    #     @{ X = 0; Y = 0; Direction = "N"; EndX = 0; EndY = 1 }
    #     @{ X = 0; Y = 0; Direction = "E"; EndX = 1; EndY = 0 }
    #     @{ X = 0; Y = 0; Direction = "S"; EndX = 0; EndY = -1 }
    #     @{ X = 0; Y = 0; Direction = "W"; EndX = -1; EndY = 0 }
    #     @{ X = -5; Y = 10; Direction = "N"; EndX = -5; EndY = 11 }
    # ) {
    #     param ($X, $Y, $Direction, $EndX, $EndY)

    #     Set-Rover -X $X -Y $Y -Direction $Direction
    #     Move-Rover -Instruction "M"

    #     $rover = Get-Rover
    #     $rover.Direction | Should -Be $Direction
    #     $rover.X | Should -Be $EndX -Because "X"
    #     $rover.Y | Should -Be $EndY -Because "Y"
    # }

    # TASK 6 - consuming multiple instructions
    # Context "Multiple instructions" {
    #     It "Processes more than 1 instruction" -TestCases @( 
    #         @{  Instructions = "LLMRM";
    #             X = -1; Y = -1; Direction = "W" }
    #     ) {
    #         param ($Instructions, $X, $Y, $Direction)
    #         Move-Rover -Instruction $Instructions

    #         $rover = Get-Rover
    #         $rover.Direction | Should -Be $Direction
    #         $rover.X | Should -Be $X -Because "X"
    #         $rover.Y | Should -Be $Y -Because "Y"
    #     }
    # }

    # TASK 8 - add obstacles 
    # Context "Obstacles" {
    #     It "Reports an obstacle when it encounters it" {
    #         $obstacles = @(@{ X = 0; Y = 1})
            
    #         Set-RoverObstacle -Obstacle $obstacles
    #         Move-Rover -Instruction "M"

    #         $rover = Get-Rover
    #         $rover.PathBlocked | Should -Be $true
    #         $rover.Direction | Should -Be "N"
    #         $rover.X | Should -Be 0 -Because "X"
    #         $rover.Y | Should -Be 0 -Because "Y"
    #     }

    #     It "Reports no obstacle when there is none" {
    #         $obstacles = @(@{ X = 1; Y = 0})
            
    #         Set-RoverObstacle -Obstacle $obstacles
    #         Move-Rover -Instruction "M"

    #         $rover = Get-Rover
    #         $rover.PathBlocked | Should -Be $false
    #         $rover.Direction | Should -Be "N"
    #         $rover.X | Should -Be 0 -Because "X"
    #         $rover.Y | Should -Be 1 -Because "Y"
    #     }
    # }

    # TASK 9 - world wrapping
    # Context "World wrapping" {  
    #     It "wraps around the Y axis on top" {    
    #         Move-Rover -Instruction ("M"*6)

    #         $rover = Get-Rover
    #         $rover.PathBlocked | Should -Be $false
    #         $rover.Direction | Should -Be "N"
    #         $rover.X | Should -Be 0 -Because "X"
    #         $rover.Y | Should -Be -5 -Because "we moved to the edge and wrapped back"
    #     }

    #     It "wraps around the Y on the bottom" {    
    #         Move-Rover -Instruction ("LL"+"M"*6)

    #         $rover = Get-Rover
    #         $rover.PathBlocked | Should -Be $false
    #         $rover.Direction | Should -Be "S"
    #         $rover.X | Should -Be 0 -Because "X"
    #         $rover.Y | Should -Be 5 -Because "we moved to the edge and wrapped back"
    #     }

    #     It "wraps around the X axis on right" {    
    #         Move-Rover -Instruction ("R"+"M"*6)

    #         $rover = Get-Rover
    #         $rover.PathBlocked | Should -Be $false
    #         $rover.Direction | Should -Be "E"
    #         $rover.X | Should -Be -5 -Because "X"
    #         $rover.Y | Should -Be 0 -Because "we moved to the edge and wrapped back"
    #     }

    #     It "wraps around the X axis on left" {    
    #         Move-Rover -Instruction ("L"+"M"*6)

    #         $rover = Get-Rover
    #         $rover.PathBlocked | Should -Be $false
    #         $rover.Direction | Should -Be "W"
    #         $rover.X | Should -Be 5 -Because "X"
    #         $rover.Y | Should -Be 0 -Because "we moved to the edge and wrapped back"
    #     }
    # }
}

