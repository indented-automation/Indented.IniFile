InModuleScope Indented.IniFile {
    Describe Get-IniFileSection {
        BeforeAll {
            $defaultParams = @{
                Path = 'TestDrive:\test.ini'
            }

            Set-Content @defaultParams -Value (@(
                '[Section1]'
                'Name1=Value1'
                'Name2 = Value2'
                ''
                '[Section2]'
                'Name1 =Value1'
                'Name2= "RmFrZVBhc3N3ZA=="'
            ) -join "`r`n")
        }

        It 'When section name is not defined, gets all sections' {
            $sections = Get-IniFileSection @defaultParams

            @($sections).Count | Should -Be 2
        }

        It 'When a section is defined, gets the named section' {
            $section = Get-IniFileSection @defaultParams -Name 'Section2'

            @($section).Count | Should -Be 1
            $section.Name | Should -Be 'Section2'
            $section.Items.Count | Should -Be 2
        }
    }
}