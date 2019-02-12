function UpdateString {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [AllowEmptyString()]
        [String]$String,

        [Parameter(Mandatory)]
        [String]$Value,

        [Int32]$Position = $String.Length,

        [String]$EndOfLine = [Environment]::NewLine
    )

    if ($Position -gt 0) {
        if ($String[$Position - 1] -ne "`n") {
            $Value = '{0}{1}' -f $EndOfLine, $Value
        }
    }
    if ($String.Length -gt $Position) {
        $Value = '{0}{1}' -f $Value, $EndOfLine
    }

    $String.Insert($Position, $Value)
}