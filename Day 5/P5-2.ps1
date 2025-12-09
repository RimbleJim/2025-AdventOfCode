<# --- Part Two ---
The Elves start bringing their spoiled inventory to the trash chute at the back of the kitchen.

So that they can stop bugging you when they get new inventory, the Elves would like to know all of the IDs that the fresh ingredient ID ranges consider to be fresh. An ingredient ID is still considered fresh if it is in any range.

Now, the second section of the database (the available ingredient IDs) is irrelevant. Here are the fresh ingredient ID ranges from the above example:

3-5
10-14
16-20
12-18
The ingredient IDs that these ranges consider to be fresh are 3, 4, 5, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, and 20. So, in this example, the fresh ingredient ID ranges consider a total of 14 ingredient IDs to be fresh.

Process the database file again. How many ingredient IDs are considered to be fresh according to the fresh ingredient ID ranges?
 #>

$TestMode = $false
$GnomeDb = get-content .\input.txt
if ($TestMode) { $GnomeDb = get-content .\test-input.txt }

$FreshRanges = @()
$FreshRangesArr = @()
$NewRangesArr = @()
foreach ($Line in $GnomeDb) {
    if ($Line -eq "") {
        Break
    }
    $FreshRanges += $Line
}

Foreach ($Range in $FreshRanges) {
    [Int64]$FRUpper = $($Range.split("-"))[1]
    [int64]$FRLower = $($Range.split("-"))[0]
    $FreshRangesArr += [pscustomobject]@{
        Lower = [int64]$FRLower
        Upper = [Int64]$FRUpper
    }
}

$FreshRangesArr = $FreshRangesArr | Sort-Object Lower
$i = 0

foreach ($Range in $FreshRangesArr) {
    if ($i -eq 0) {
        $i++
        $NewRangesArr += [pscustomobject]@{
            Lower = [int64]$Range.Lower
            Upper = [Int64]$Range.Upper
        }
        Continue
    }

    if (($Range.Lower - 1) -le $NewRangesArr[$($NewRangesArr).Length - 1].Upper) {
        if ($Range.Upper -gt $NewRangesArr[$($NewRangesArr).Length - 1].Upper) {
            $NewRangesArr[$($NewRangesArr).Length - 1].Upper = $Range.Upper
        }
        Continue
    }
    
    $NewRangesArr += [pscustomobject]@{
        Lower = [int64]$Range.Lower
        Upper = [Int64]$Range.Upper
    }
}

[Int64]$Total = 0

Foreach ($NewRange in $NewRangesArr) {
    $Total += (($NewRange.Upper - $NewRange.Lower) + 1)
}

$Total