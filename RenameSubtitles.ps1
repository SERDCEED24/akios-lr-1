# Устанавливаем входной параметр для скрипта в виде пути к директории, с файлами которой будут проводиться операции. 
param (
    [string]$source_dir
)

# Предусматриваем сообщение об ошибке, для случая если скрипт где-то упадёт.
try {
    $videoFiles = Get-ChildItem -Path $source_dir -Filter "*.mkv" # Получаем все видеофайлы из требуемой директории
    $subtitleFiles = Get-ChildItem -Path $source_dir -Filter "*.ass" # Получаем все файлы субтитров из требуемой директории

    if ($videoFiles.Count -ne $subtitleFiles.Count) { # Если количество субтитров и видеофайлов не совпадает, выдаём ошибку, о том что вероятно пользователю нужно проверить содержимое своей директории.
        throw "The number of subtitle files and the number of video files are different! Check your directory, please." # Выкидываем исключение с соответствующим сообщением
    }

    for ($i = 0; $i -lt $videoFiles.Count; $i++) { # Цикл работает ровно столько раз сколько у нас видеофайлов, от 0 до их количества
        $videoName = $videoFiles[$i].BaseName # Получим имя видеофайла без расширения и сохраним его в переменную
        Rename-Item -Path $subtitleFiles[$i].FullName -NewName "$videoName.ass" # Переименуем соответствующий по порядку файл с субтитрами на имя видеофайла без расширения + .ass (расширение субтитров)
    }
}
catch {
    throw "Error! Check the path to desired directory." # Выкидываем исключение с сообщением о том, что стоит проверить указанный путь.
}