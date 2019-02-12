InModuleScope Indented.IniFile {
    Describe IniFileItem {
        BeforeAll {
            Mock Set-IniFileItem
            Mock Remove-IniFileItem
        }

        BeforeEach {
            Set-Content TestDrive:\test.ini -Value (@(
                '[Section1]'
                'Name1=Value1'
            ) -join "`r`n")

            $class = [IniFileItem]@{
                Ensure   = 'Present'
                Name     = 'Name1'
                Section  = 'Section1'
                NewValue = 'NewValue'
                Path     = 'TestDrive:\test.ini'
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

                Assert-MockCalled Set-IniFileItem -Times 1 -Scope It
            }

            It 'When ensure is absent, calls Remove-IniFileItem' {
                $class.Ensure = 'Absent'
                $class.Set()

                Assert-MockCalled Remove-IniFileItem -Times 1 -Scope It
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
}