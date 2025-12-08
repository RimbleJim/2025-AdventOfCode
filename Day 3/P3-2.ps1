<#--- Part Two ---
The escalator doesn't move. The Elf explains that it probably needs more joltage to overcome the static friction of the system and hits the big red "joltage limit safety override" button. You lose count of the number of times she needs to confirm "yes, I'm sure" and decorate the lobby a bit while you wait.

Now, you need to make the largest joltage by turning on exactly twelve batteries within each bank.

The joltage output for the bank is still the number formed by the digits of the batteries you've turned on; the only difference is that now there will be 12 digits in each bank's joltage output instead of two.

Consider again the example from before:

987654321111111
811111111111119
234234234234278
818181911112111
Now, the joltages are much larger:

In 987654321111111, the largest joltage can be found by turning on everything except some 1s at the end to produce 987654321111.
In the digit sequence 811111111111119, the largest joltage can be found by turning on everything except some 1s, producing 811111111119.
In 234234234234278, the largest joltage can be found by turning on everything except a 2 battery, a 3 battery, and another 2 battery near the start to produce 434234234278.
In 818181911112111, the joltage 888911112111 is produced by turning on everything except some 1s near the front.
The total output joltage is now much larger: 987654321111 + 811111111119 + 434234234278 + 888911112111 = 3121910778619.
#>

$List = get-content "$PSScriptRoot\input.txt"
[Int64]$Final = 0
foreach($Item in $List){
 # -Split "(\d)"
    $Array = $Item[0..($Item.Length+1)]
    #[Array]::Reverse($Array)
    [Int32]$HBils = 0
    [Int32]$TBils = 0
    [Int32]$Bils = 0
    [Int32]$HMils = 0
    [Int32]$TMils = 0
    [Int32]$Mils = 0
    [Int32]$HThos = 0
    [Int32]$TThos = 0
    [Int32]$Thos = 0
    [Int32]$Huns = 0
    [Int32]$Tens = 0
    [Int32]$Ones = 0

    while($Array.Length -ne 1){
        [Int]$Int = [int][string]$Array[0]
        if($Int -gt $HBils -and $Array.Length -gt 11){
            $HBils = $Int
            $TBils = 0
            $Bils = 0
            $HMils = 0
            $TMils = 0
            $Mils = 0
            $HThos = 0
            $TThos = 0
            $Thos = 0
            $Huns = 0
            $Tens = 0
            $Ones = 0
            $Array = $Array[1..($Array.Length-1)]
            Continue
        }        
        if($Int -gt $TBils -and $Array.Length -gt 10){
            $TBils = $Int
            $Bils = 0
            $HMils = 0
            $TMils = 0
            $Mils = 0
            $HThos = 0
            $TThos = 0
            $Thos = 0
            $Huns = 0
            $Tens = 0
            $Ones = 0
            $Array = $Array[1..($Array.Length-1)]
            Continue
        }        
        if($Int -gt $Bils -and $Array.Length -gt 9){
            $Bils = $Int
            $HMils = 0
            $TMils = 0
            $Mils = 0
            $HThos = 0
            $TThos = 0
            $Thos = 0
            $Huns = 0
            $Tens = 0
            $Ones = 0
            $Array = $Array[1..($Array.Length-1)]
            Continue
        }        
        if($Int -gt $HMils -and $Array.Length -gt 8){
            $HMils = $Int
            $TMils = 0
            $Mils = 0
            $HThos = 0
            $TThos = 0
            $Thos = 0
            $Huns = 0
            $Tens = 0
            $Ones = 0
            $Array = $Array[1..($Array.Length-1)]
            Continue
        }        
        if($Int -gt $TMils -and $Array.Length -gt 7){
            $TMils = $Int
            $Mils = 0
            $HThos = 0
            $TThos = 0
            $Thos = 0
            $Huns = 0
            $Tens = 0
            $Ones = 0
            $Array = $Array[1..($Array.Length-1)]
            Continue
        }        
        if($Int -gt $Mils -and $Array.Length -gt 6){
            $Mils = $Int
            $HThos = 0
            $TThos = 0
            $Thos = 0
            $Huns = 0
            $Tens = 0
            $Ones = 0
            $Array = $Array[1..($Array.Length-1)]
            Continue
        }        
        if($Int -gt $HThos -and $Array.Length -gt 5){
            $HThos = $Int
            $TThos = 0
            $Thos = 0
            $Huns = 0
            $Tens = 0
            $Ones = 0
            $Array = $Array[1..($Array.Length-1)]
            Continue
        }        
        if($Int -gt $TThos -and $Array.Length -gt 4){
            $TThos = $Int
            $Thos = 0
            $Huns = 0
            $Tens = 0
            $Ones = 0
            $Array = $Array[1..($Array.Length-1)]
            Continue
        }        
        if($Int -gt $Thos -and $Array.Length -gt 3){
            $Thos = $Int
            $Huns = 0
            $Tens = 0
            $Ones = 0
            $Array = $Array[1..($Array.Length-1)]
            Continue
        }        
        if($Int -gt $Huns -and $Array.Length -gt 2){
            $Huns = $Int
            $Tens = 0
            $Ones = 0
            $Array = $Array[1..($Array.Length-1)]
            Continue
        }
        if($Int -gt $Tens -and $Array.Length -gt 1){
            $Tens = $Int
            $Ones = 0
            $Array = $Array[1..($Array.Length-1)]
            Continue
        }
        if($Int -gt $Ones){
            $Ones = $Int
            $Array = $Array[1..($Array.Length-1)]
            Continue
        }
        $Array = $Array[1..($Array.Length-1)]
    }
    ##One last pass to catch the final item in the array else it's missed since arrays cannot have their last member removed.
    [Int]$Int = [int][string]$Array[0]
    if($Int -gt $Ones){
        $Ones = $Int
    }

    [Int64]$Val = "$HBils" + "$TBils" + "$Bils" + "$HMils" + "$TMils" + "$Mils" + "$HThos" + "$TThos" + "$Thos" + "$Huns" + "$Tens" + "$Ones"
    [Int64]$Final += $Val
    Write-host $Val
}    
return $Final