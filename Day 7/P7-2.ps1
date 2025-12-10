<# --- Part Two ---
With your analysis of the manifold complete, you begin fixing the teleporter. However, as you open the side of the teleporter to replace the broken manifold, you are surprised to discover that it isn't a classical tachyon manifold - it's a quantum tachyon manifold.
With a quantum tachyon manifold, only a single tachyon particle is sent through the manifold. A tachyon particle takes both the left and right path of each splitter encountered.
Since this is impossible, the manual recommends the many-worlds interpretation of quantum tachyon splitting: each time a particle reaches a splitter, it's actually time itself which splits. In one timeline, the particle went left, and in the other timeline, the particle went right.
To fix the manifold, what you really need to know is the number of timelines active after a single particle completes all of its possible journeys through the manifold.
In the above example, there are many timelines. For instance, there's the timeline where the particle always went left:
Or, there's the timeline where the particle alternated going left and right at each splitter:
Or, there's the timeline where the particle ends up at the same point as the alternating timeline, but takes a totally different path to get there:
In this example, in total, the particle ends up on 40 different timelines.

Apply the many-worlds interpretation of quantum tachyon splitting to your manifold diagram. In total, how many different timelines would a single tachyon particle end up on?
 #>


################################
## It's a pachinko machine :) ##
################################

$TestMode = $false
$Tachyon = get-content "$PSScriptRoot\input.txt"
if ($TestMode) { $Tachyon = get-content "$PSScriptRoot\test-input.txt" }

$Total = 0
$YAxis = 0
$XAxis = 0
$Array = @{}

## Turn the strings into an assignable array, that I can modify using $Tachyon[$var]
for ($i = 0; $i -lt $Tachyon.Length; $i++) {
    if ($Tachyon[$i] -isnot [char[]]) {
        $Tachyon[$i] = $Tachyon[$i].ToCharArray()
    }
}

## Create the array that holds the count for each column
for ($a = 0; $a -lt $tachyon[0].Length; $a++) {
    $Array[$a] = 0
}

do {
    ## Set the above and current rows as assignable
    $Above = $Tachyon[$($YAxis - 1)]
    $Active = $Tachyon[$YAxis]

    ## Iterate through the X-Axis one at a time
    for ($XAxis = 0; $XAxis -lt $Active.Length; $XAxis++) {
        ## Indicates the Start
        if ($Active[$XAxis] -eq "S") {
            $Array.$XAxis = 1
            Continue
        }
        ## We can ignore existing the beam, 
        if ($Active[$XAxis] -eq "|") {
            Continue
        }

        if ($Active[$XAxis] -eq "^" -and $Above[$XAxis] -eq "|") {
            ## We still need to draw the new beam
            if ($Active[$XAxis - 1] -ne "|" -or $Active[$XAxis + 1] -ne "|") {
                $Active[$XAxis - 1] = "|"
                $Active[$XAxis + 1] = "|"
            }

            ## Pachinko Math, The current XAxis is no longer possible to reach, so all of it's current options need to be passed to either side of it.
            ## Write a visualisation of a pachinko machine filling up?? Center option in the trillions of outcomes.
            ## Either side must inherit all possible outcomes of the current pachink, 
            ## Ex. If to this point 40 balls could have made it to this exact point, then 50% of the time they will go left and 50% of the time they will go right
            ## Doubling the number of possible paths to this point.

            $Array.$($Xaxis - 1) += $Array.$XAxis
            $Array.$($Xaxis + 1) += $Array.$XAxis
            ## Current Column becomes impossible as it will always split at this point (Becomes possible again further down but the count must reset to 0)
            $Array.$XAxis = 0
            Continue
        }
        if ($YAxis -ne 0) {
            if ($Above["$($XAxis)"] -eq "|" -or $Above["$($XAxis)"] -eq "S") {
                $Active[$XAxis] = "|"
            }
        }
    }
    ## Iterated through all columns in this row, time for the next row.
    $YAxis++
    ## Draw in powershell window to keep track of progress, not needed but pretty
    #[String]$Active

} while (
    ## Stop after you parse to the bottom row 
    $YAxis -lt $Tachyon.Length
)

## Add all those values together.
foreach ($Val in $Array.Values) {
    $Total += $Val
}

$Total