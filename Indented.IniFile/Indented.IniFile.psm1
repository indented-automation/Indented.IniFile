$enumeration = @(
    'Ensure'
)

foreach ($file in $enumeration) {
    . ("{0}\enum\{1}.ps1" -f $psscriptroot, $file)
}

$class = @(
    'IniFileItem'
)

foreach ($file in $class) {
    . ("{0}\class\{1}.ps1" -f $psscriptroot, $file)
}

$private = @(
    'GetEol'
    'UpdateString'
)

foreach ($file in $private) {
    . ("{0}\private\{1}.ps1" -f $psscriptroot, $file)
}

$public = @(
    'Get-IniFileItem'
    'Get-IniFileSection'
    'Remove-IniFileItem'
    'Set-IniFileItem'
)

foreach ($file in $public) {
    . ("{0}\public\{1}.ps1" -f $psscriptroot, $file)
}

$functionsToExport = @(
    'Get-IniFileItem'
    'Get-IniFileSection'
    'Remove-IniFileItem'
    'Set-IniFileItem'
)
Export-ModuleMember -Function $functionsToExport


