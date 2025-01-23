# Устанавливаем входной параметр для скрипта в виде пути к директории, с файлами которой будут проводиться операции. 
param (
    [string]$source_dir
)

# Предусматриваем сообщение об ошибке, для случая если указанный путь не существует или не может быть обработан по какой-то причине.
try {
    $videoFiles = Get-ChildItem -Path $source_dir -Filter "*.mkv" # Получаем все видеофайлы из требуемой директории.
    $subtitleFiles = Get-ChildItem -Path $source_dir -Filter "*.ass" # Получаем все файлы субтитров из требуемой директории.
}
catch {
    throw "Check path to your directory! The path entered probably doesn't exist." # Выкидываем исключение с сообщением о том, что стоит проверить правильность указанного пути.
}


if ($videoFiles.Count -eq 0 -or $subtitleFiles.Count -eq 0) {
    # Проверяем есть ли в директории субтитры и видеофайлы. Если чего-то не хватает, выводим ошибку.
    throw "There is no subtitles or no videos in desired folder! Check your directory, please." # Выкидываем исключение с соответствующим сообщением.
}

if ($videoFiles.Count -ne $subtitleFiles.Count) {
    # Если количество субтитров и видеофайлов не совпадает, выдаём ошибку, о том что вероятно пользователю нужно проверить содержимое своей директории.
    throw "The number of subtitle files and the number of video files are different! Check your directory, please." # Выкидываем исключение с соответствующим сообщением.
}
try { # Предусматриваем сообщение об ошибке во время переименования
    for ($i = 0; $i -lt $videoFiles.Count; $i++) {
        # Цикл работает ровно столько раз сколько у нас видеофайлов, от 0 до их количества.
        $videoName = $videoFiles[$i].BaseName # Получим имя видеофайла без расширения и сохраним его в переменную.
        Rename-Item -Path $subtitleFiles[$i].FullName -NewName "$videoName.ass" # Переименуем соответствующий по порядку файл с субтитрами на имя видеофайла без расширения + .ass (расширение субтитров).
    }
}
catch {
    throw "Error! Some file/s can't be renamed." # Выкидываем исключении о том что некий файл не смог быть переименован.
}