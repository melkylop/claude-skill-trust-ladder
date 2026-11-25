# Instala as skills deste repositorio em ~/.claude/skills (ou em -Destino).
# Uso: .\scripts\install.ps1 [-Destino CAMINHO]
# Substitui apenas pastas com o mesmo nome das skills do repositorio.
param(
    [string]$Destino = (Join-Path $env:USERPROFILE ".claude\skills")
)
$ErrorActionPreference = 'Stop'

$raiz = Split-Path -Parent $PSScriptRoot
$origem = Join-Path $raiz "skills"
New-Item -ItemType Directory -Force -Path $Destino | Out-Null

foreach ($skill in Get-ChildItem -Directory $origem) {
    if (-not (Test-Path (Join-Path $skill.FullName "SKILL.md"))) {
        Write-Warning "Pulando $($skill.Name): sem SKILL.md"
        continue
    }
    $alvo = Join-Path $Destino $skill.Name
    if (Test-Path $alvo) {
        Remove-Item -Recurse -Force $alvo
        $acao = "atualizada"
    } else {
        $acao = "instalada"
    }
    Copy-Item -Recurse -Path $skill.FullName -Destination $alvo
    Write-Host "$($skill.Name): $acao em $alvo"
}
Write-Host "Pronto. Abra uma sessao nova do Claude para a skill aparecer."
