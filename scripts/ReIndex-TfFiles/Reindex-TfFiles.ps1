# How to use: 
# Step-1: Prepare .tfindex file with the list of files in sequence to be arranged
#         Keep .tfindex file in the child module folder 
# Step-2: Run this script with 2 args: 
# .\Reindex-TFFiles.ps1 -IndexFile "C:\Terraform\.tfindex" -TargetPath "C:\Terraform"
# Example: 
# .\Reindex-TFFiles.ps1 -IndexFile "<path>\Governance-Collection\modules\Governance-Collection\spoke_networking\.tfindex" -TargetPath "<path>\Governance-Collection\modules\Governance-Collection\spoke_networking"


param(
    [Parameter(Mandatory = $true)]
    [string]$IndexFile,

    [Parameter(Mandatory = $true)]
    [string]$TargetPath
)

# Validate paths
if (-not (Test-Path -Path $IndexFile)) {
    Write-Error "The .tfindex file was not found at path: $IndexFile"
    exit
}
if (-not (Test-Path -Path $TargetPath)) {
    Write-Error "The target folder was not found: $TargetPath"
    exit
}

# Read ordered list, skipping comments and blank lines
$sequenceList = Get-Content -Path $IndexFile | Where-Object {
    $_ -and ($_ -notmatch '^\s*#')
}

# Process each file in order with a generated sequence number
for ($i = 0; $i -lt $sequenceList.Count; $i++) {
    $filename = $sequenceList[$i].Trim()
    $seq = $i.ToString("D2")  # Pad with leading zero

    # Match files ignoring existing NN- prefix
    $fileMatch = Get-ChildItem -Path $TargetPath -Filter *.tf |
                 Where-Object { $_.Name -replace '^\d+-', '' -eq $filename }

    if ($fileMatch) {
        $newName = "$seq-$filename"
        if ($fileMatch.Name -ne $newName) {
            Write-Host "Renaming '$($fileMatch.Name)' -> '$newName'"
            Rename-Item -Path $fileMatch.FullName -NewName $newName
        }
    }
    else {
        Write-Warning "File '$filename' (from index) not found in $TargetPath."
    }
}
