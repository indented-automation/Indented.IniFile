Describe IniFileItem {
    BeforeAll {
        $module = @{ ModuleName = 'Indented.IniFile' }

        Mock Set-IniFileItem @module
        Mock Remove-IniFileItem @module
    }

    BeforeEach {
        Set-Content TestDrive:\test.ini -Value (
            @(
                '[Section1]'
                'Name1=Value1'
            ) -join "`r`n"
        )

        $class = InModuleScope @module {
            [IniFileItem]@{
                Ensure   = 'Present'
                Name     = 'Name1'
                Section  = 'Section1'
                NewValue = 'NewValue'
                Path     = 'TestDrive:\test.ini'
            }
        }
    }

    Context 'Get, value is present' {
        It 'When the value is present, sets ensure to present and fills corresponding properties' {
            $class.Ensure = 'Absent'
            $instance = $class.Get()

            $instance.Ensure | Should -Be 'Present'
            $instance.NewValue | Should -Be 'Value1'
        }
    }

    Context 'Get, value is absent' {
        BeforeEach {
            $class.Name = 'Name2'
        }

        It 'When the value is absent, sets ensure to absent' {
            $instance = $class.Get()

            $instance.Ensure | Should -Be 'Absent'
        }
    }

    Context 'Set' {
        It 'When ensure is present, calls Set-IniFileItem' {
            $class.Set()

            Should -Invoke Set-IniFileItem -Times 1 @module
        }

        It 'When ensure is absent, calls Remove-IniFileItem' {
            $class.Ensure = 'Absent'
            $class.Set()

            Should -Invoke Remove-IniFileItem -Times 1 @module
        }
    }

    Context 'Test, value is present' {
        It 'When ensure is present, and the value matches, returns true' {
            $class.NewValue = 'Value1'

            $class.Test() | Should -BeTrue
        }

        It 'When ensure is present, and the value does not match, returns false' {
            $class.Test() | Should -BeFalse
        }

        It 'When ensure is absent, returns false' {
            $class.Ensure = 'Absent'

            $class.Test() | Should -BeFalse
        }
    }

    Context 'Test, value is absent' {
        BeforeEach {
            $class.Name = 'Name2'
        }

        It 'When ensure is present, returns false' {
            $class.Test() | Should -BeFalse
        }

        It 'When ensure is absent, returns true' {
            $class.Ensure = 'Absent'

            $class.Test() | Should -BeTrue
        }
    }
}
