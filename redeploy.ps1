# ============================================================
#  USDQuest redeploy helper (called by redeploy.bat)
#  Commits local changes and pushes to GitHub. GitHub Pages
#  rebuilds automatically (~1 min). Reads credentials from
#  deploy.local.json (which is git-ignored, never published).
# ============================================================
$ErrorActionPreference = "Stop"
$repoPath = $PSScriptRoot
$cfgPath  = Join-Path $repoPath "deploy.local.json"

if (-not (Test-Path $cfgPath)) {
  Write-Host "ERROR: deploy.local.json not found next to this script." -ForegroundColor Red
  exit 1
}
$cfg   = Get-Content $cfgPath -Raw | ConvertFrom-Json
$user  = $cfg.github_username
$token = $cfg.github_token
$repo  = $cfg.repo_name

if ($user -match "YOUR-" -or $token -match "YOUR-") {
  Write-Host "ERROR: deploy.local.json still has placeholder values. Fill it in first." -ForegroundColor Red
  exit 1
}

# Stage everything (deploy.local.json stays excluded via .gitignore)
git -C $repoPath add -A

# Commit only if there is something to commit
$status = git -C $repoPath status --porcelain
if ([string]::IsNullOrWhiteSpace($status)) {
  Write-Host "No changes to deploy. Working tree is clean." -ForegroundColor Yellow
} else {
  $stamp = Get-Date -Format "yyyy-MM-dd HH:mm"
  $msg = $args -join " "
  if ([string]::IsNullOrWhiteSpace($msg)) { $msg = "Update USDQuest ($stamp)" }
  git -C $repoPath commit -m "$msg" | Out-Null
  Write-Host ("Committed: " + $msg) -ForegroundColor Green
}

# Safety: never push the token file
$leak = git -C $repoPath ls-files | Select-String "deploy.local.json"
if ($leak) { Write-Host "ABORT: token file is tracked by git!" -ForegroundColor Red; exit 1 }

# Push using a temporary token-embedded URL, then scrub it back to a clean URL
$pushUrl  = "https://${user}:${token}@github.com/${user}/${repo}.git"
$cleanUrl = "https://github.com/${user}/${repo}.git"
if ((git -C $repoPath remote) -contains "origin") {
  git -C $repoPath remote set-url origin $pushUrl
} else {
  git -C $repoPath remote add origin $pushUrl
}
git -C $repoPath push origin main
$code = $LASTEXITCODE
git -C $repoPath remote set-url origin $cleanUrl   # scrub token out of .git/config

if ($code -eq 0) {
  Write-Host ""
  Write-Host "Deployed. Live in ~1 minute at:" -ForegroundColor Green
  Write-Host ("  https://${user}.github.io/${repo}/") -ForegroundColor Cyan
} else {
  Write-Host "Push failed (exit $code). Check your token / network." -ForegroundColor Red
}
