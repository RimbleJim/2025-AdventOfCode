<#--- Part Two ---
Now, the Elves just need help accessing as much of the paper as they can.

Once a roll of paper can be accessed by a forklift, it can be removed. Once a roll of paper is removed, the forklifts might be able to access more rolls of paper, which they might also be able to remove. How many total rolls of paper could the Elves remove if they keep repeating this process?

Starting with the same example as above, here is one way you could remove as many rolls of paper as possible, using highlighted @ to indicate that a roll of paper is about to be removed, and using x to indicate that a roll of paper was just removed:

Initial state:
..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.

Remove 13 rolls of paper:
..xx.xx@x.
x@@.@.@.@@
@@@@@.x.@@
@.@@@@..@.
x@.@@@@.@x
.@@@@@@@.@
.@.@.@.@@@
x.@@@.@@@@
.@@@@@@@@.
x.x.@@@.x.

etc... until

Remove 1 roll of paper:
..........
..........
..........
...x@@....
...@@@@...
...@@@@@..
...@.@.@@.
...@@.@@@.
...@@@@@..
....@@@...
Stop once no more rolls of paper are accessible by a forklift. In this example, a total of 43 rolls of paper can be removed.

Start with your original diagram. How many rolls of paper in total can be removed by the Elves and their forklifts?
#>


function Get-ToiletRolls {
$YAxis = 0
$XAxis = 0
$Iteration = 0
$MapAfter = $Map

do {
    $Above = $Map[$($YAxis-1)]
    $Active = $Map[$YAxis]
    $Below = $Map[$($YAxis+1)]
    $XAxis = 0

    for ($XAxis = 0; $XAxis -lt $Active.Length; $XAxis++){
        if($Active[$XAxis] -ne "@"){
            Continue
        }

        $Surrounding = 0

        ## Search Above
        if($YAxis -ne 0){
            ## Above Left
            if($XAxis -ne 0){
                if($Above["$($XAxis-1)"] -eq "@"){
                    $Surrounding++
                }
            }
            ## Directly Above
            if($Above["$($XAxis)"] -eq "@"){
                $Surrounding++
            }
            ## Above Right
            if($XAxis -ne $Active.Length-1){
                if($Above["$($XAxis+1)"] -eq "@"){
                    $Surrounding++
                }
            }
        }
        
        ## Search On-Line
        ## Directly Left
        if($XAxis -ne 0){
            if($Active["$($XAxis-1)"] -eq "@"){
                $Surrounding++
            }
        }
        ## Directly Right
        if($XAxis -ne $Active.Length-1){
            if($Active["$($XAxis+1)"] -eq "@"){
                $Surrounding++
            }
        }

        ## Search Below
        if($YAxis -ne $Map.Length-1){
            ## Below Left
            if($XAxis -ne 0){
                if($Below["$($XAxis-1)"] -eq "@"){
                    $Surrounding++
                }
            }
            ## Directly Below
            if($Below["$($XAxis)"] -eq "@"){
                $Surrounding++
            }
            ## Below Right
            if($XAxis -ne $Active.Length-1){
                if($Below["$($XAxis+1)"] -eq "@"){
                    $Surrounding++
                }
            }
        }
        if($Surrounding -lt 4){
            $Iteration++
            $AMA = $MapAfter[$($YAxis)] 
            $AMModified = $AMA.Substring(0,$($XAxis)) + "." + $AMA.Substring($($XAxis+1))
            $MapAfter[$YAxis] = $AMModified
        }
    }

    $YAxis++
    
} while (
    $YAxis -lt $Map.Length
)

$Map = $MapAfter
Return $Iteration

}

#####################################
########  Script Start  #############
#####################################

$Map = get-content "$PSScriptRoot\test-input.txt"
$Definitive = 0
$Iteration = 1


## This is all just for the pretty popup window
Add-Type -AssemblyName System.Windows.Forms
$form = New-Object System.Windows.Forms.Form
$form.Text = "Current Map"
$form.Width = 800
$form.Height = 1200
$textbox = New-Object System.Windows.Forms.TextBox
$textbox.Multiline = $true
$textbox.ScrollBars = "Both"
$textbox.BackColor = "Black"
$textbox.ForeColor = "Red"
$textbox.Font = New-Object System.Drawing.Font("Consolas", 5)
$textbox.Dock = "Fill"
$form.Controls.Add($textbox)
$form.Show()
## This is all just for the pretty popup window

while($Iteration -ne 0){
    ## Also Pretty Window 2 lines
    $textbox.Text = ($Map -join "`r`n")
    $form.Refresh()
    $Iteration = Get-ToiletRolls
    $Definitive+= $Iteration
}

## Pretty Window no die pls
[void][System.Windows.Forms.Application]::Run($form)

Return $Definitive