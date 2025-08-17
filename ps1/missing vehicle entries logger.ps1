$folder = "C:\Users\shark\Documents\GitHub\Kentucky-Car-Overhaul\Contents\mods\SCKCO - Vehicles\42.0\media\lua\client\SC\SC_Animations"

# Get all Lua files recursively, search for SC_ entries
$matches = Get-ChildItem -Path $folder -Filter *.lua -Recurse | 
    Select-String -Pattern '\bSC_[A-Za-z0-9_]+' | 
    ForEach-Object { $_.Matches } | 
    ForEach-Object { $_.Value }

# Output unique entries
$matches | Sort-Object -Unique
