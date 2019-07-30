[DscResource()]
class IniFileItem {
    [DscProperty()]
    [Ensure]$Ensure = 'Present'

    [DscProperty(Key)]
    [String]$Name

    [DscProperty()]
    [String]$Section

    [DscProperty()]
    [String]$Value

    [DscProperty()]
    [String]$NewValue

    [DscProperty(Key)]
    [String]$Path

    Hidden [Void] InitializeRequest() {
        if (-not (Test-Path $this.Path)) {
            throw 'The INI file, {0}, does not exist' -f $this.Path
        }
    }

    Hidden [Hashtable] GetParams() {
        $params = @{
            Name = $this.Name
            Path = $this.Path
        }
        if ($this.Section) {
            $params.Add('Section', $this.Section)
        }
        if ($this.Value) {
            $params.Add('Value', $this.Value)
        }

        return $params
    }

    [IniFileItem] Get() {
        $this.InitializeRequest()
        $params = $this.GetParams()
        $item = Get-IniFileItem @params

        if ($item) {
            $this.Ensure = 'Present'
            $this.NewValue = $item.Value
        } else {
            $this.Ensure = 'Absent'
        }

        return $this
    }

    [Void] Set() {
        $this.InitializeRequest()
        $params = $this.GetParams()
        if ($this.Ensure -eq 'Present') {
            Set-IniFileItem @params -NewValue $this.NewValue
        } elseif ($this.Ensure -eq 'Absent') {
            Remove-IniFileItem @params
        }
    }

    [Boolean] Test() {
        $this.InitializeRequest()
        $params = $this.GetParams()
        $item = Get-IniFileItem @params

        if ($this.Ensure -eq 'Present') {
            if (-not $item) {
                return $false
            }
            if ($item -and $item.Value -ne $this.NewValue) {
                return $false
            }
        } elseif ($this.Ensure -eq 'Absent') {
            if ($item) {
                return $false
            }
        }

        return $true
    }
}