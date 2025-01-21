param (
    [string]$source_dir
)

try {
    $videoFiles = Get-ChildItem -Path $source_dir -Filter "*.mkv"
    $subtitleFiles = Get-ChildItem -Path $source_dir -Filter "*.ass"

    if ($videoFiles.Count -ne $subtitleFiles.Count) {
        throw "The number of subtitle files and the number of video files are different! Check your directory, please."
    }

    for ($i = 0; $i -lt $videoFiles.Count; $i++) {
        $videoName = $videoFiles[$i].BaseName
        Rename-Item -Path $subtitleFiles[$i].FullName -NewName "$videoName.ass"
    }
}
catch {
    Write-Output "Error! Check the path to desired directory."
}