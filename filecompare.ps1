Param(
    [Parameter(Mandatory=$true)][string] $inputFilesDirectory,
    [Parameter(Mandatory=$true)][string] $outputFilesDirectory,
    [string] $compareFileDirectory = ".\"
)

# create compare output directory for this execution
$datePortion = Get-Date -Format "yyyyMMdd_HHmmss"
$compareOutputDirectory = Join-Path $compareFileDirectory $datePortion

# create output directory
New-Item $compareOutputDirectory -ItemType directory

# Loop through files in input directory and process
$inputFilesList = Get-ChildItem -Path $inputFilesDirectory -Filter *.csv
foreach ($file in $inputFilesList)
{
    # Load input file into object
    $inputCollection = Import-Csv -Path $file.FullName

    # get equivelent output file
    $outputFile = Join-Path -Path $outputFilesDirectory -ChildPath $file.name
    $outputFile
    $outputFileExists = Test-Path $outputFile
    if ($outputFileExists -eq $false)
    {
        Write-Host("No matching output file for $file.FullName")
            break
    }

    # load equivalent output file into object
    $exportCollection = Import-Csv -Path $outputFile

    # derive compare file name
    $compareFile = Join-Path $compareOutputDirectory $file.name 
    $compareFile

    # Get the array of all property names to compare from the original collection.
    $propsToCompare = $inputCollection[0].psobject.properties.name

    # Compare the 2 collections by all property values.
    # -PassThru means that any input object in which a difference is found
    # is passed through as-is.
    Compare-Object -ReferenceObject $inputCollection -DifferenceObject $exportCollection -Property $propsToCompare -PassThru | Format-Table -AutoSize | Out-File -FilePath $compareFile 
}
