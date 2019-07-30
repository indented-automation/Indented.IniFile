using namespace System.IO

function GetEol {
    <#
    .SYNOPSIS
        Attempt to find the end of line character.
    .DESCRIPTION
        Used to find the end of line character in a file.
    #>

    [CmdletBinding()]
    [OutputType([System.String])]
    param (
        # The path to an ini file.
        [Parameter(Mandatory)]
        [String]$Path
    )

    try {
        $eol = [Environment]::NewLine

        $Path = $pscmdlet.GetUnresolvedProviderPathFromPSPath($Path)

        if (-not (Test-Path $Path)) {
            return $eol
        }

        $streamReader = [StreamReader][File]::OpenRead($Path)
        [Char[]]$buffer = [Char[]]::new(100)
        while (-not $streamReader.EndOfStream) {
            $null = $streamReader.Read($buffer, 0, 100)
            $newLineIndex = $buffer.IndexOf([Char]"`n")

            if ($newLineIndex -gt -1) {
                if ($buffer[$newLineIndex - 1] -eq [Char]"`r") {
                    $streamReader.Close()
                    return "`r`n"
                } else {
                    $streamReader.Close()
                    return "`n"
                }
            }
        }
        $streamReader.Close()

        return $eol
    } catch {
        $pscmdlet.ThrowTerminatingError($_)
    }
}