#!/usr/bin/env sh
# Instala as skills deste repositorio em ~/.claude/skills (ou em $DESTINO).
# Uso: sh scripts/install.sh
# Substitui apenas pastas com o mesmo nome das skills do repositorio.
set -eu

raiz=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
destino=${DESTINO:-$HOME/.claude/skills}
mkdir -p "$destino"

for dir in "$raiz"/skills/*/; do
  dir=${dir%/}
  nome=$(basename "$dir")
  if [ ! -f "$dir/SKILL.md" ]; then
    echo "Pulando $nome: sem SKILL.md"
    continue
  fi
  alvo="$destino/$nome"
  if [ -d "$alvo" ]; then
    rm -rf "$alvo"
    acao=atualizada
  else
    acao=instalada
  fi
  cp -R "$dir" "$alvo"
  echo "$nome: $acao em $alvo"
done
echo "Pronto. Abra uma sessao nova do Claude para a skill aparecer."
