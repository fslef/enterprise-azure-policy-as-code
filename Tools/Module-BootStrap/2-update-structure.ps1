function Move-Files {
    param (
        [Parameter(Mandatory = $true)]
        [string]$source,
        [Parameter(Mandatory = $true)]
        [string]$destination,
        [Parameter(Mandatory = $false)]
        [switch]$recursive
    )

    # Check if the source exists
    if (-not (Test-Path -Path $source)) {
        Write-Host "`nError: Source $source does not exist." -ForegroundColor Red
        return
    }

    # Create the destination directory if it doesn't exist
    if (-not (Test-Path -Path $destination)) {
        New-Item -ItemType Directory -Path $destination | Out-Null
        Write-Host "`nCreated destination directory: $destination" -ForegroundColor Green
    }

    # Check if the source is a file or a directory
    if (Test-Path -Path $source -PathType Leaf) {
        # Source is a file
        Move-Item -Path $source -Destination $destination
        Write-Host "`nMoved file: $source to $destination" -ForegroundColor Cyan
    }
    else {
        # Source is a directory
        $files = Get-ChildItem -Path $source -File -Recurse:$recursive

        # Move files
        foreach ($file in $files) {
            Move-Item -Path $file.FullName -Destination $destination
            Write-Host "`nMoved file: $($file.FullName) to $destination" -ForegroundColor Cyan
        }

        # Delete the source directory if it's empty
        if ($null -eq (Get-ChildItem -Path $source)) {
            Remove-Item -Path $source
            Write-Host "`nDeleted empty source directory: $source" -ForegroundColor Yellow
        }
    }
}

Move-Files -source "~/gitrepos/fslef/fork-epac/test1.txt" -destination "~/gitrepos/fslef/fork-epac/test-destination/"
Move-Files -source "~/gitrepos/fslef/fork-epac/test2.txt" -destination "~/gitrepos/fslef/fork-epac/test-destination/sub1/"
Move-Files -source "~/gitrepos/fslef/fork-epac/test-source/" -destination "~/gitrepos/fslef/fork-epac/test-destination/sub1/"