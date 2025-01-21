param (
    [string]$source_dir
)

try {
    $videoFiles = Get-ChildItem -Path $source_dir -Filter "*.mkv"
    $subtitleFiles = Get-ChildItem -Path $source_dir -Filter "*.ass"

    if ($videoFiles.Count -ne $subtitleFiles.Count) {
        throw "Количество субтитров и видео файлов не совпадают. Проверьте директорию с файлами."
    }

    for ($i = 0; $i -lt $videoFiles.Count; $i++){
        $videoName = $videoFiles[$i].BaseName
        Rename-Item -Path $subtitleFiles.FullName -NewName "$videoName.ass"
    }
}
catch {
    Write-Output "В ходе выполнения возникла ошибка! Проверьте что путь до папки с файлами указан верно."
}

Write-Output "Субтитры успешно переименованы."