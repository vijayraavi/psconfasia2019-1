$xSize = 10
$ySize = 10
$field = [int[,]]::new($xSize,$ySize)
$x, $y = @((Get-Random -Max $xSize), (Get-Random -Max $ySize)) 

$field[$x, $y] = 1