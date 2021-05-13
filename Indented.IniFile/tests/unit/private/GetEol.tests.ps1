InModuleScope Indented.IniFile {
    Describe GetEol {
        BeforeAll {
            $defaultParams = @{
                Path = 'TestDrive:\test.ini'
            }
        }

        It 'When the file line ends with CRLF, returns \r\n' {
            Set-Content @defaultParams -Value "[Section]`r`nName=Value`r`n" -NoNewLine

            GetEol @defaultParams | Should -Be "`r`n"
        }

        It 'When the file line ends with LF, returns \n' {
            Set-Content @defaultParams -Value "[Section]`nName=Value`n" -NoNewLine

            GetEol @defaultParams | Should -Be "`n"
        }

        It 'When the file does not have a line ending, returns the operating system default' {
            Set-Content @defaultParams -Value "[Section]" -NoNewLine

            GetEol @defaultParams | Should -Be ([Environment]::NewLine)
        }
    }
}