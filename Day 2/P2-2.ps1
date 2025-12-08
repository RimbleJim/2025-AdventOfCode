<#--- Part Two ---
The clerk quickly discovers that there are still invalid IDs in the ranges in your list. Maybe the young Elf was doing other silly patterns as well?
Now, an ID is invalid if it is made only of some sequence of digits repeated at least twice. So, 12341234 (1234 two times), 123123123 (123 three times), 1212121212 (12 five times), and 1111111 (1 seven times) are all invalid IDs.
From the same example as before:

11-22 still has two invalid IDs, 11 and 22.
95-115 now has two invalid IDs, 99 and 111.
998-1012 now has two invalid IDs, 999 and 1010.
1188511880-1188511890 still has one invalid ID, 1188511885.
222220-222224 still has one invalid ID, 222222.
1698522-1698528 still contains no invalid IDs.
446443-446449 still has one invalid ID, 446446.
38593856-38593862 still has one invalid ID, 38593859.
565653-565659 now has one invalid ID, 565656.
824824821-824824827 now has one invalid ID, 824824824.
2121212118-2121212124 now has one invalid ID, 2121212121.
Adding up all the invalid IDs in this example produces 4174379265.

What do you get if you add up all of the invalid IDs using these new rules?
#>

Function Quintets ($5Number, $5NumberLen) {
    [string]$5Str = $5Number.ToString()
    [Int64]$5StrFirst = $5Str.Substring(0, $5NumberLen - 5)
    [Int64]$5StrLast = $5Str.Substring(5)
    if ($5StrFirst -eq $5StrLast) {
        Return $True
    }
    else {
        Return $False
    }
}
Function Quartets ($4Number, $4NumberLen) {
    [string]$4Str = $4Number.ToString()
    [Int64]$4StrFirst = $4Str.Substring(0, $4NumberLen - 4)
    [Int64]$4StrLast = $4Str.Substring(4)
    if ($4StrFirst -eq $4StrLast) {
        Return $True
    }
    else {
        Return $False
    }
}
Function Triplets ($3Number, $3NumberLen) {
    [string]$3Str = $3Number.ToString()
    ## If I ever feel like improving efficiency, this would be better if it could fail out immediately as it detects 2 non-matching triplets
    $3StrSplit = ($3Str -split '(.{3})') | Where-Object { $_ } | Select-Object -Unique
    if ($3StrSplit.count -eq 1) {
        Return $True
    }
    else {
        Return $False
    }
}
Function Couplets ($2Number, [int32]$2NumberLen) {
    [string]$2Str = $2Number.ToString()
    ## If I ever feel like improving efficiency, this would be better if it could fail out immediately as it detects 2 non-matching couplets
    $2StrSplit = ($2Str -split '(.{2})') | Where-Object { $_ } | Select-Object -Unique
    if ($2StrSplit.count -eq 1) {
        Return $True
    }
    else {
        Return $False
    }
}
Function Singlets ($1Number, $1NumberLen) {
    [string]$1Str = $1Number.ToString()
    ## If I ever feel like improving efficiency, this would be better if it could fail out immediately as it detects 2 non-matching singlets
    $1StrSplit = ($1Str -split '(.{1})') | Where-Object { $_ } | Select-Object -Unique
    if ($1StrSplit.count -eq 1) {
        Return $True
    }
    else {
        Return $False
    }
}

$List = get-content "c:\intel\poweshell\advent of code 2025\day 2\input.txt"
$ListasArray = $List.Split(",")
[Int64]$Total = 0

Foreach ($Range in $ListasArray) {

    [int64]$RangeLower = $($Range.split("-"))[0]
    [int64]$RangeUpper = $($Range.split("-"))[1]
    
    for ($i = $RangeLower; $i -le $RangeUpper; $i++) {
        $Number = $i
        [string]$Str = $Number.ToString()
        [int32]$StrLen = $Str.Length

        if ($StrLen -gt 5 -and $StrLen % 5 -eq 0) {
            $Bool = Quintets $Number $StrLen
            if ($Bool -eq $True) {
                $Total += $Number
                Continue
            }
        }
        if ($StrLen -gt 4 -and $StrLen % 4 -eq 0) {
            $Bool = Quartets $Number $StrLen
            if ($Bool -eq $True) {
                $Total += $Number
                Continue
            }
        }
        if ($StrLen -gt 3 -and $StrLen % 3 -eq 0) {
            $Bool = Triplets $Number $StrLen
            if ($Bool -eq $True) {
                $Total += $Number
                Continue
            }
        }
        if ($StrLen -gt 2 -and $StrLen % 2 -eq 0) {
            $Bool = Couplets $Number $StrLen
            if ($Bool -eq $True) {
                $Total += $Number
                Continue
            }
        }
        if ($StrLen -gt 1) {
            $Bool = Singlets $Number $StrLen
            if ($Bool -eq $True) {
                $Total += $Number
                Continue
            }
        }
    }
}

Return $Total