param (
    [string]$source_dir
)

try {
    $videoFiles = Get-ChildItem -Path $source_dir -Filter "*.mkv"
    $subtitleFiles = Get-ChildItem -Path $source_dir -Filter "*.ass"
    for ($i = 0; $i -lt $videoFiles.Count; $i++){
        $videoName = $videoFiles[$i].Name
        Rename-Item $subtitleFiles[$i].Name $videoName
    }
}
catch {
    Write-Debug "В ходе выполнения возникла ошибка! Проверьте что путь до папки с файлами указан верно."
}

Write-Output "Субтитры успешно переименованы"