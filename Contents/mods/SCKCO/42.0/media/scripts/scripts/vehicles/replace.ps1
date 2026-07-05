$dir     = 'C:\Users\sharkpc\Zomboid\Workshop\Kentucky-Car-Overhaul\Contents\mods\SCKCO\42.0\media\scripts\vehicles'
$preview = $true   # $true = report only; set $false to write changes
$enc     = [System.Text.UTF8Encoding]::new($false)   # no-BOM UTF-8
$changed = 0

Get-ChildItem -Path $dir -Filter *.txt -File -Recurse | ForEach-Object {
    $text = [System.IO.File]::ReadAllText($_.FullName)
    # (?<!SC_) lookbehind keeps the pass idempotent: already-converted tokens are skipped, no SC_SC_ doubling
    $new  = [regex]::Replace($text, '(?<!SC_)vehicle_noreflect', 'SC_vehicle_noreflect')
    if ($new -ne $text) {
        $hits = ([regex]::Matches($text, '(?<!SC_)vehicle_noreflect')).Count
        # ReadAllText/WriteAllText treat the file as one string, so existing CRLF endings are preserved
        if (-not $preview) { [System.IO.File]::WriteAllText($_.FullName, $new, $enc) }
        Write-Host "$($_.Name): $hits replacement(s)"
        $changed++
    }
}

Write-Host ("files with matches: {0} (preview={1})" -f $changed, $preview)
