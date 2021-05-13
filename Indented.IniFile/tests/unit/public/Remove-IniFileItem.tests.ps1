Describe Remove-IniFileItem {
    BeforeAll {
        $defaultParams = @{
            Path = 'TestDrive:\test.ini'
        }

        Set-Content @defaultParams -Value (
            @(
                '[Section1]'
                'Name1=Value1'
                'Name2 = Value2'
                'Name3=Value3'
                ''
                '[Section2]'
                'Name1 =Value1'
                'Name2= "RmFrZVBhc3N3ZA=="'
                'Name3=Value4'
            ) -join "`r`n"
        )
    }

    It 'When an item exists, removes a single item' {
        $testParams = $defaultParams.Clone() + @{
            Name    = 'Name1'
            Section = 'Section1'
        }
        Remove-IniFileItem @testParams

        Get-IniFileItem @testParams | Should -BeNullOrEmpty
    }

    It 'When an item exists, and a name is defined, removes all items by name in all sections' {
        $testParams = $defaultParams.Clone() + @{
            Name = 'Name2'
        }
        Remove-IniFileItem @testParams

        Get-IniFileItem @testParams | Should -BeNullOrEmpty
    }

    Context 'EOL handler' {
        It 'When a name and section are defined, and the item is the last in the file, removes the item' {
            $testParams = $defaultParams.Clone() + @{
                Name    = 'Name3'
                Section = 'Section2'
            }

            { Remove-IniFileItem @testParams } | Should -Not -Throw
            Get-IniFileItem @testParams | Should -BeNullOrEmpty
        }

        It 'When the end of line is \n, correctly detects the EOL length' {
            Set-Content @defaultParams -Value (
                @(
                    '[Section1]'
                    'Name1=Value1'
                    'Name2=Value2'
                ) -join "`n"
            )

            $testParams = $defaultParams.Clone() + @{
                Name    = 'Name1'
                Section = 'Section1'
            }
            Remove-IniFileItem @testParams

            $item = Get-IniFileItem -Name Name2 @defaultParams
            $item | Should -Not -BeNullOrEmpty
            $item.Value | Should -Be 'Value2'
        }
    }
}
