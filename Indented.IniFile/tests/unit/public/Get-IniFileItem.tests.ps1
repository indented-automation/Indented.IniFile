Describe Get-IniFileItem {
    BeforeAll {
        $defaultParams = @{
            Path = 'TestDrive:\test.ini'
        }

        Set-Content @defaultParams -Value (
            @(
                '[Section1]'
                'Name1=Value1'
                'Name2 = Value2'
                ''
                '[Section2]'
                'Name1 =Value1'
                'Name2= "RmFrZVBhc3N3ZA=="'
            ) -join "`r`n"
        )
    }

    It 'When no params are supplied, gets all items' {
        @(Get-IniFileItem @defaultParams).Count | Should -Be 4
    }

    It 'When a section is defined, gets all items from the section' {
        @(Get-IniFileItem -Section Section1 @defaultParams).Count | Should -Be 2
        @(Get-IniFileItem -Section Section2 @defaultParams).Count | Should -Be 2
    }

    It 'When a name is defined, gets items by name from all sections' {
        @(Get-IniFileItem -Name Name1 @defaultParams).Count | Should -Be 2
    }

    It 'When a name and section are defined, gets items by name and section' {
        $item = Get-IniFileItem -Name Name2 -Section Section1 @defaultParams

        $item | Should -Not -BeNullOrEmpty
        $item.Name | Should -Be 'Name2'
        $item.Value | Should -Be 'Value2'
    }

    It 'When a value is read, correctly splits the name and value' {
        $item = Get-IniFileItem -Name Name2 -Section Section2 @defaultParams

        $item | Should -Not -BeNullOrEmpty
        $item.Name | Should -Be 'Name2'
        $item.Value | Should -Be '"RmFrZVBhc3N3ZA=="'
    }

    It 'When an item is returned, includes Section position in the extent' {
        $iniFile = Get-Content @defaultParams -Raw
        $section1Index = $iniFile.IndexOf('[Section1]')
        $section2Index = $iniFile.IndexOf('[Section2]')
        $item1 = Get-IniFileItem -Name Name1 -Section Section1 @defaultParams
        $item2 = Get-IniFileItem -Name Name2 -Section Section2 @defaultParams

        $item1.Extent.SectionStart | Should -Be $section1Index
        $item2.Extent.SectionStart | Should -Be $section2Index
    }

    It 'When an item is returned, includes Item position in the extent' {
        $iniFile = Get-Content @defaultParams -Raw
        $item1Index = $iniFile.IndexOf('Name2')
        $item2Index = $iniFile.LastIndexOf('Name1')
        $item1 = Get-IniFileItem -Name Name2 -Section Section1 @defaultParams
        $item2 = Get-IniFileItem -Name Name1 -Section Section2 @defaultParams

        $item1.Extent.ItemStart | Should -Be $item1Index
        $item2.Extent.ItemStart | Should -Be $item2Index
    }
}
