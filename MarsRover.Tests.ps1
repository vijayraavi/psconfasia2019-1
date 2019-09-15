Describe "Get-Rover" {
    BeforeEach {
        Get-Module MarsRover | Remove-Module
        Import-Module $PSScriptRoot/MarsRover.psm1
    }

    It "Starts at 0,0,N" {
        $actual = Get-Rover

        $actual.X | Should -Be 0
        $actual.Y | Should -Be 0
        $actual.Direction | Should -Be "N"
    }
}

Describe "Set-Rover" {
    BeforeEach {
        Get-Module MarsRover | Remove-Module
        Import-Module $PSScriptRoot/MarsRover.psm1
    }

    It "Sets the Direction" { 
        Set-Rover -Direction "E"
        $actual = Get-Rover 
        $actual.Direction | Should -Be "E" 
    }
}

Describe "Move-Rover" {
    BeforeEach {
        Get-Module MarsRover | Remove-Module
        Import-Module $PSScriptRoot/MarsRover.psm1
    }

    It "Does nothing when it gets no instruction" {
        $expected = Get-Rover
        Move-Rover 
        $actual = Get-Rover

        $actual | Should -Not -BeNullOrEmpty
        $actual.X | Should -Be $expected.X
        $actual.Y | Should -Be $expected.Y
        $actual.Direction | Should -Be $expected.Direction
    }

    It "Turns to right from 0,0,N" {
        $expected = "E"
        Move-Rover -Instruction "R"
        $actual = Get-Rover

        $actual.Direction | Should -Be $expected
    }

    It "Turns to right from 0,0,E" {
        $expected = "S"
        Set-Rover -Direction "E"
        Move-Rover -Instruction "R"
        $actual = Get-Rover

        $actual.Direction | Should -Be $expected
    }

    It "Turns to right from 0,0,<direction>" -TestCases @( 
        @{ Direction = "N"; Expected = "E" }
        @{ Direction = "E"; Expected = "S" }
        @{ Direction = "S"; Expected = "W" }
        @{ Direction = "W"; Expected = "N" }
    ) {
        param ($Direction, $Expected)

        Set-Rover -Direction $Direction
        Move-Rover -Instruction "R"
        $actual = Get-Rover

        $actual.Direction | Should -Be $Expected
    }
}

