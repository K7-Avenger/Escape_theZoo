# Define the directory you want to list items from
$directoryPath = "C:\Users\Cybr442\Desktop\Malx-main\theZoo\theZoo-master\malware\Binaries"
$zipPassword = "infected"
$7ZipPath = "C:\Program Files\7-Zip\7z.exe"

# Load the System.IO.Compression.FileSystem assembly
#Add-Type -TypeDefinition @"
#    using System.IO.Compression;
#"@

# Initialize an empty list to store the items
#$itemsList = @()

# Check if the specified directory exists
if (Test-Path -Path $directoryPath -PathType Container) {
    # Get all items (files and directories) in the specified directory
    $items = Get-ChildItem -Path $directoryPath

    # Add each item to the list
    foreach ($item in $items) {
        #$itemsList += $item.FullName
        $dirs_to_open = $item.FullName
        $jtems = Get-ChildItem -Path $dirs_to_open
        
        foreach($jtem in $jtems){
            $exten = [IO.Path]::GetExtension($jtem)
            if ($exten -eq ".zip" ){
                Write-Host $dirs_to_open
                Write-Host $jtem.FullName
                try {
                    Start-Process -FilePath $7ZipPath -ArgumentList "e -o$dirs_to_open -p$zipPassword -y $($jtem.FullName)"
                    Write-Host "Successfully extracted the ZIP file."
                } catch {
                    Write-Host "Failed to extract the ZIP file. Error: $($_.Exception.Message)"
                }
            }
            
        }
    }
}
else {
    Write-Host "The specified directory does not exist."
}
