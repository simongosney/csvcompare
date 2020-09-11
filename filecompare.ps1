$inputFile   = Import-Csv -Path .\input.csv
$outputFile  = Import-Csv -Path .\output.csv
#Compare-Object -ReferenceObject $input -DifferenceObject $output -Property 'Unique ID' -PassThru -IncludeEqual | Format-Table -AutoSize
Compare-Object -ReferenceObject $input -DifferenceObject $output -PassThru -IncludeEqual | Format-Table -AutoSize