InModuleScope Indented.IniFile {
    Describe Set-IniFileItem {
        BeforeAll {
            $defaultParams = @{
                Path = 'TestDrive:\test.ini'
            }
        }

        BeforeEach {
            Set-Content @defaultParams -Value (@(
                '[Section1]'
                'Name1=Value1'
                'Name2 = Value2'
                'Name2 = Value2'
                'Name3=Value3'
                ''
                '[Section2]'
                'Name1 =Value1'
                'Name2= "RmFrZVBhc3N3ZA=="'
                'Name3=Value4'
            ) -join "`r`n")
        }

        It 'When the file does not exist, creates a new file' {
            $testParams = @{
                Path    = 'TestDrive:\new.ini'
                Name    = 'Name1'
                Section = 'Section1'
            }
            Set-IniFileItem -NewValue 'NewValue' @testParams

            Test-Path $testParams.Path | Should -Be $true
            (Get-IniFileItem @testParams).Value | Should -Be 'NewValue'
        }

        It 'When ExpandEnvironmentVariables is present, expands environment variables in NewValue' {
            $testParams = $defaultParams.Clone() + @{
                Name    = 'Name1'
                Section = 'Section1'
            }
            Set-IniFileItem -NewValue '%WINDIR%\Test' -ExpandEnvironmentVariables @testParams

            (Get-IniFileItem @testParams).Value | Should -Be "$env:WINDIR\Test"
        }

        It 'When a name and section are defined, updates or creates the value' {
            $testParams = $defaultParams.Clone() + @{
                Name    = 'Name1'
                Section = 'Section1'
            }
            Set-IniFileItem -NewValue 'NewValue' @testParams

            (Get-IniFileItem @testParams).Value | Should -Be 'NewValue'
        }

        It 'When a name is defined, updates the value across all sections' {
            $testParams = $defaultParams.Clone() + @{
                Name = 'Name3'
            }
            Set-IniFileItem -NewValue 'GlobalUpdate' @testParams
            $items = @(Get-IniFileItem @testParams)

            $items.Count | Should -Be 2
            $items[0].Value | Should -Be 'GlobalUpdate'
            $items[1].Value | Should -Be 'GlobalUpdate'
        }

        It 'When the value does not exist, adds the item to the end of an existing section' {
            $testParams = $defaultParams.Clone() + @{
                Name    = 'Name4'
                Section = 'Section1'
            }
            Set-IniFileItem -NewValue 'NewValue' @testParams

            (Get-IniFileItem @testParams).Value | Should -Be 'NewValue'
        }

        It 'When the section does not exist, adds a new section' {
            $testParams = $defaultParams.Clone() + @{
                Name    = 'Name5'
                Section = 'NewSection'
            }

            Set-IniFileItem -NewValue 'Value' @testParams
            $item = Get-IniFileItem @testParams

            $item.Section | Should -Be 'NewSection'
            $item.Name | Should -Be 'Name5'
            $item.Value | Should -Be 'Value'
        }

        It 'When the section is not defined, and no other values without a section exist, adds the value to the start of the file' {
            $testParams = $defaultParams.Clone() + @{
                Name = 'Name5'
            }

            Set-IniFileItem -NewValue 'Value' @testParams
            $item = Get-IniFileItem @testParams

            $item.Section | Should -BeNullOrEmpty
            $item.Name | Should -Be 'Name5'
            $item.Value | Should -Be 'Value'
            $item.Extent.ItemStart | Should -Be 0
        }

        It 'When the section is not defined, and other values without a section exist, adds the file after the existing values' {
            $testParams = $defaultParams.Clone() + @{
                Name = 'Name5'
            }

            Set-Content @defaultParams -Value (@(
                'Name0=Value0'
                ''
                '[Section1]'
                'Name1=Value1'
            ) -join "`r`n")

            Set-IniFileItem -NewValue 'Value' @testParams
            $item = Get-IniFileItem @testParams

            $item.Section | Should -BeNullOrEmpty
            $item.Name | Should -Be 'Name5'
            $item.Value | Should -Be 'Value'
            $item.Extent.ItemStart | Should -BeGreaterThan 0
        }
    }
}