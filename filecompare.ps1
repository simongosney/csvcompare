#this post probably has the answer to the problem:
# https://stackoverflow.com/questions/18259861/compare-object-not-working-if-i-dont-list-the-properties/18346380

$inputFile   = Import-Csv -Path .\input.csv
$outputFile  = Import-Csv -Path .\output.csv
#Compare-Object -ReferenceObject $input -DifferenceObject $output -Property 'Unique ID' -PassThru  | Format-Table -AutoSize
Compare-Object -ReferenceObject $inputFile -DifferenceObject $outputFile -PassThru  
        -Property

#| Format-Table -AutoSize 



# The original collection.
$inputCollection = Import-Csv -Path .\input.csv
$exportCollection = Import-Csv -Path .\output.csv 



# PSv3+: Get the array of all property names to compare 
#        from the original collection.
$propsToCompare = $inputCollection[0].psobject.properties.name

# Compare the 2 collections by all property values.
# -PassThru means that any input object in which a difference is found
# is passed through as-is.
Compare-Object -ReferenceObject $inputCollection -DifferenceObject $exportCollection -Property $propsToCompare -PassThru
