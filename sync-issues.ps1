param([string]$Repo = 'dawidseipold/blind-step')
$ErrorActionPreference = 'Stop'
function Github([string[]]$Arguments) {
    $result = & gh @Arguments
    if ($LASTEXITCODE -ne 0) { throw "GitHub: $($Arguments[0]) $($Arguments[1]) failed." }
    $result
}
$catalog = @{}
foreach ($label in ((Github @('label','list','-R',$Repo,'--limit','10000','--json','name')) | ConvertFrom-Json)) {
    $catalog[$label.name] = $true
}
function EnsureLabel([string]$name) {
    if ($catalog.ContainsKey($name)) { return }
    $colors = @{area='1D76DB'; priority='B60205'; status='0E8A16'; type='5319E7'}
    $color = $colors[($name -split ':')[0]]
    if (!$color) { $color = '666666' }
    Github @('label','create',$name,'-R',$Repo,'--color',$color) | Out-Null
    $catalog[$name] = $true
}
$areas = 'workflow','level','player','player','player','lighting','lighting','rendering','rendering','audio','level','ai','ai','audio','gameplay','art','tools','rendering','workflow','workflow','player','player','gameplay','rendering','rendering','player','player','gameplay','level'
$rows = @{}
foreach ($line in Get-Content (Join-Path $PSScriptRoot 'ROADMAP.md') -Encoding UTF8) {
    if ($line -match '^\| (T\d+) \| ([^|]+) \| ([^|]+) \| ([^|]+) \|$') {
        $rows[$Matches[1]] = @{title=$Matches[2]; depends=$Matches[3]; test=$Matches[4]}
    }
}
function Defaults($id, $state) {
    $area = 'triage'
    if ($id -and [int]$id.Substring(1) -lt $areas.Count) { $area = $areas[[int]$id.Substring(1)] }
    $type = 'feature'
    if (!$id -or $id -in 'T00','T01','T15','T16','T18','T19','T27') { $type = 'task' }
    if ($id -eq 'T17') { $type = 'bug' }
    $status = 'todo'
    if ($id -in 'T02','T18') { $status = 'review' }
    if ($state -eq 'CLOSED') { $status = 'done' }
    "area:$area",'priority:medium',"status:$status","type:$type"
}
foreach ($name in 'area:triage','priority:high','priority:medium','priority:low','status:todo','status:in-progress','status:review','status:done','type:task','type:bug','type:feature') { EnsureLabel $name }
$issues = (Github @('issue','list','-R',$Repo,'--state','all','--limit','10000','--json','number,title,state,labels')) | ConvertFrom-Json
$seen = @{}
foreach ($issue in $issues) {
    $id = ''
    if ($issue.title -match '^(T\d+)\b') { $id = $Matches[1]; $seen[$id] = $true }
    $old = @($issue.labels | ForEach-Object { $_.name })
    $wanted = @()
    foreach ($label in (Defaults $id $issue.state)) {
        $prefix = ($label -split ':')[0]
        $existing = @($old | Where-Object { $_ -match "^${prefix}:[a-z0-9][a-z0-9-]*$" })
        if ($existing.Count -and !($prefix -eq 'status' -and ($issue.state -eq 'CLOSED' -or $existing[0] -eq 'status:done'))) {
            $wanted += $existing[0]
        } else { $wanted += $label }
    }
    foreach ($label in $old) {
        if ($label -match '^(area|priority|status|type):') { continue }
        if ($label -match '^[a-z0-9-]+:[\p{L}0-9-]+$') { $wanted += $label; continue }
        $slug = ($label.ToLowerInvariant() -replace '[^\p{L}0-9]+','-').Trim('-')
        if (!$slug) { $slug = 'other' }
        $wanted += "tag:$slug"
    }
    $edit = @('issue','edit',"$($issue.number)",'-R',$Repo)
    foreach ($name in ($wanted | Select-Object -Unique)) {
        if ($name -notin $old) { EnsureLabel $name; $edit += '--add-label',$name }
    }
    foreach ($name in $old) { if ($name -notin $wanted) { $edit += '--remove-label',$name } }
    if ($edit.Count -gt 5) { Github $edit }
}
$file = [IO.Path]::GetTempFileName()
try {
    foreach ($id in ($rows.Keys | Sort-Object)) {
        if ($seen.ContainsKey($id)) { continue }
        $row = $rows[$id]
        [IO.File]::WriteAllText($file, "Zadanie: $($row.title)`n`nPo: $($row.depends)`n`nOdbior: $($row.test)")
        $labels = Defaults $id 'OPEN'
        foreach ($name in $labels) { EnsureLabel $name }
        Github @('issue','create','-R',$Repo,'--title',"$id $($row.title)",'--body-file',$file,'--label',($labels -join ','))
    }
} finally { Remove-Item -LiteralPath $file }
