<# --- Day 7: Laboratories ---
You thank the cephalopods for the help and exit the trash compactor, finding yourself in the familiar halls of a North Pole research wing.

Based on the large sign that says "teleporter hub", they seem to be researching teleportation; you can't help but try it for yourself and step onto the large yellow teleporter pad.

Suddenly, you find yourself in an unfamiliar room! The room has no doors; the only way out is the teleporter. Unfortunately, the teleporter seems to be leaking magic smoke.

Since this is a teleporter lab, there are lots of spare parts, manuals, and diagnostic equipment lying around. After connecting one of the diagnostic tools, it helpfully displays error code 0H-N0, which apparently means that there's an issue with one of the tachyon manifolds.

You quickly locate a diagram of the tachyon manifold (your puzzle input). A tachyon beam enters the manifold at the location marked S; tachyon beams always move downward. Tachyon beams pass freely through empty space (.). However, if a tachyon beam encounters a splitter (^), the beam is stopped; instead, a new tachyon beam continues from the immediate left and from the immediate right of the splitter.

For example:

.......S.......
...............
.......^.......
...............
......^.^......
...............
.....^.^.^.....
...............
....^.^...^....
...............
...^.^...^.^...
...............
..^...^.....^..
...............
.^.^.^.^.^...^.
...............
In this example, the incoming tachyon beam (|) extends downward from S until it reaches the first splitter:

At that point, the original beam stops, and two new beams are emitted from the splitter:

Those beams continue downward until they reach more splitters:

At this point, the two splitters create a total of only three tachyon beams, since they are both dumping tachyons into the same place between them:

This process continues until all of the tachyon beams reach a splitter or exit the manifold:

.......S.......
.......|.......
......|^|......
......|.|......
.....|^|^|.....
.....|.|.|.....
....|^|^|^|....
....|.|.|.|....
...|^|^|||^|...
...|.|.|||.|...
..|^|^|||^|^|..
..|.|.|||.|.|..
.|^|||^||.||^|.
.|.|||.||.||.|.
|^|^|^|^|^|||^|
|.|.|.|.|.|||.|
To repair the teleporter, you first need to understand the beam-splitting properties of the tachyon manifold. In this example, a tachyon beam is split a total of 21 times.

Analyze your manifold diagram. How many times will the beam be split?
 #>


$TestMode = $false
$Tachyon = get-content "$PSScriptRoot\input.txt"
if ($TestMode) { $Tachyon = get-content "$PSScriptRoot\test-input.txt" }

$Count = 0
$YAxis = 0
$XAxis = 0
for ($i = 0; $i -lt $Tachyon.Length; $i++) {
    if ($Tachyon[$i] -isnot [char[]]) {
        $Tachyon[$i] = $Tachyon[$i].ToCharArray()
    }
}

do {
    $Above = $Tachyon[$($YAxis - 1)]
    $Active = $Tachyon[$YAxis]
    #$Below = $Tachyon[$($YAxis + 1)]
    $XAxis = 0

    for ($XAxis = 0; $XAxis -lt $Active.Length; $XAxis++) {
        if ($Active[$XAxis] -eq "S" -or $Active[$XAxis] -eq "|") {
            Continue
        }

        if ($Active[$XAxis] -eq "^" -and $Above[$XAxis] -eq "|") {
            if ($Active[$XAxis - 1] -eq "|" -and $Active[$XAxis + 1] -eq "|") {
                Continue
            }
            $Active[$XAxis - 1] = "|"
            $Active[$XAxis + 1] = "|"
            $Count++
            Continue
        }

        ## Search Above
        if ($YAxis -ne 0) {
            ## Directly Above
            if ($Above["$($XAxis)"] -eq "|" -or $Above["$($XAxis)"] -eq "S") {
                $Active[$XAxis] = "|"
            }
        }
    }
    $YAxis++
    [String]$Active

} while (
    $YAxis -lt $Tachyon.Length
)

for ($i = 0; $i -lt $Tachyon.Length; $i++) {
    [String]$Tachyon[$i] = $Tachyon[$i]
}

$Tachyon
Write-host "`n-- Beam split $Count Times --`n"