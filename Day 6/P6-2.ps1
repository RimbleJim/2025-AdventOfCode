<# --- Part Two ---
The big cephalopods come back to check on how things are going. When they see that your grand total doesn't match the one expected by the worksheet, they realize they forgot to explain how to read cephalopod math.

Cephalopod math is written right-to-left in columns. Each number is given in its own column, with the most significant digit at the top and the least significant digit at the bottom. (Problems are still separated with a column consisting only of spaces, and the symbol at the bottom of the problem is still the operator to use.)

Here's the example worksheet again:

123 328  51 64 
 45 64  387 23 
  6 98  215 314
*   +   *   +  
Reading the problems right-to-left one column at a time, the problems are now quite different:

The rightmost problem is 4 + 431 + 623 = 1058
The second problem from the right is 175 * 581 * 32 = 3253600
The third problem from the right is 8 + 248 + 369 = 625
Finally, the leftmost problem is 356 * 24 * 1 = 8544
Now, the grand total is 1058 + 3253600 + 625 + 8544 = 3263827.

Solve the problems on the math worksheet again. What is the grand total found by adding together all of the answers to the individual problems? 
#>
$TestMode = $false
$Homework = get-content "$PSScriptRoot\input.txt"
if ($TestMode) { $Homework = get-content "$PSScriptRoot\test-input.txt" }

#Split lines into individual character.
$Line1 = $Homework[0].ToCharArray()
$Line2 = $Homework[1].ToCharArray()
$Line3 = $Homework[2].ToCharArray()
$Line4 = $Homework[3].ToCharArray()

#If a full line of whitespace is detected must be a new number
#Otherwise replace any whitespace with zeroes
for ($i = 0; $i -lt $Line1.Length; $i++) {
    if ($line1[$i] -eq " " -and $line2[$i] -eq " " -and $line3[$i] -eq " " -and $line4[$i] -eq " ") {
        continue
    }
    if ($line1[$i] -eq " ") {
        $line1[$i] = "x"
    }
    if ($line2[$i] -eq " ") {
        $line2[$i] = "x"
    }
    if ($line3[$i] -eq " ") {
        $line3[$i] = "x"
    }
    if ($Line4[$i] -eq " ") {
        $line4[$i] = "x"
    }
}

##Now can split the numbers into seperate values to do math on
$line1 = -join $Line1
$Line1 = $Line1 -split '\s+'
$line2 = -join $Line2
$Line2 = $Line2 -split '\s+'
$line3 = -join $Line3
$Line3 = $Line3 -split '\s+'
$line4 = -join $Line4
$Line4 = $Line4 -split '\s+'
$Operators = $Homework[4] -split '\s+'


$Column = 0
$Total = 0
foreach ($Number in $Line1) {
    $var = @()
    $numlen = $number.length
    for ($i = 0; $i -lt $numlen; $i++) {
        [String]$String = ""
        $String = "$($Line1[$Column][$i])$($Line2[$Column][$i])$($Line3[$Column][$i])$($Line4[$Column][$i])"
        $String = $String -replace "x", ""
        $Var += $String
    }

    if ($Operators[$Column] -eq '*') {
        [Int64]$RunningTotal = 1
        foreach ($Value in $Var) {
            if ( [Int32]$Value -gt 0 ) { $RunningTotal = $RunningTotal * [Int32]$Value }
        }
        $Total += $RunningTotal
        write-host $RunningTotal
        $Column++
        Continue
    }

    if ($Operators[$Column] -eq '+') {
        [Int64]$RunningTotal = 0
        foreach ($Value in $Var) {
            if ( [Int32]$Value -gt 0 ) { [Int64]$RunningTotal += [Int32]$Value }
        }
        $Total += $RunningTotal
        write-host $RunningTotal
        $Column++
        Continue
    }
}

$Total