# Version 2 - UA string length is randomized (1-18 bytes), remaining bytes padded with 0x00

$Host.UI.RawUI.WindowTitle = "GFW Anti-DPI Fingerprint UA Randomizer"
$pattern1 = [byte[]] (0x47,0x6f,0x2d,0x68,0x74,0x74,0x70,0x2d,0x63,0x6c,0x69,0x65,0x6e,0x74,0x2f,0x31,0x2e,0x31)
$pattern2 = [byte[]] (0x47,0x6f,0x2d,0x68,0x74,0x74,0x70,0x2d,0x63,0x6c,0x69,0x65,0x6e,0x74,0x2f,0x32,0x2e,0x30)

function Patch-File {
    param($inputFile)

    $randLen  = Get-Random -Minimum 1 -Maximum 19
    $randomUA = -join ((65..90) + (97..122) + (48..57) | Get-Random -Count $randLen | % {[char]$_})

    $repBytes = [byte[]]::new(18)
    $uaBytes  = [System.Text.Encoding]::ASCII.GetBytes($randomUA)
    [array]::Copy($uaBytes, 0, $repBytes, 0, $uaBytes.Length)

    $outputFile = $inputFile -replace '\.exe$', '-patched.exe'
    $bytes = [System.IO.File]::ReadAllBytes($inputFile)
    $data  = [byte[]]$bytes
    $patched = $false

    foreach ($pat in @($pattern1, $pattern2)) {
        $offset = [array]::IndexOf($data, $pat[0])
        while ($offset -ge 0) {
            $match = $true
            for ($i = 1; $i -lt $pat.Length; $i++) {
                if ($data[$offset + $i] -ne $pat[$i]) { $match = $false; break }
            }
            if ($match) {
                [array]::Copy($repBytes, 0, $data, $offset, 18)
                $patched = $true
            }
            $offset = [array]::IndexOf($data, $pat[0], $offset + 1)
        }
    }

    if ($patched) {
        [System.IO.File]::WriteAllBytes($outputFile, $data)
        Write-Host "`nPATCH SUCCESS!" -Foreground Green
        Write-Host "File: $outputFile" -Foreground Green
        Write-Host "UA Length: $randLen  |  New UA: $randomUA" -Foreground Green
        Read-Host "`nPress Enter to continue..."
    } else {
        Write-Host "`nNo patterns found in $inputFile" -Foreground Yellow
        Read-Host "Press Enter to continue..."
    }
}

Clear-Host
Write-Host "=== GFW Anti-DPI Fingerprint UA Randomizer ===" -Foreground Magenta

$exes = Get-ChildItem *.exe | Sort-Object Name
if ($exes.Count -eq 0) {
    Write-Host "No .exe files found!" -Foreground Red
    Read-Host "Press Enter to exit"
    exit
}

for ($i = 0; $i -lt $exes.Count; $i++) {
    Write-Host "$($i+1). $($exes[$i].Name)" -Foreground Cyan
}

do {
    $choice = Read-Host "`nSelect EXE (1-$($exes.Count)) or Q=Quit"
    if ($choice -eq 'Q' -or $choice -eq 'q') { break }

    if ($choice -match '^\d+$' -and [int]$choice -ge 1 -and [int]$choice -le $exes.Count) {
        Clear-Host
        Write-Host "Patching $($exes[[int]$choice - 1].Name)..." -Foreground Yellow
        Patch-File $exes[[int]$choice - 1].FullName
        Clear-Host
        Write-Host "=== GFW Anti-DPI Fingerprint UA Randomizer ===" -Foreground Magenta
        for ($i = 0; $i -lt $exes.Count; $i++) {
            Write-Host "$($i+1). $($exes[$i].Name)" -Foreground Cyan
        }
    } else {
        Write-Host "Invalid input!" -Foreground Red
    }
} while ($true)

Write-Host "`nGoodbye!" -Foreground Green
