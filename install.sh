#!/usr/bin/env bash
#
# Instalador das skills backend-dotnet.
#
# Escopo: global (por usuário). Interativo: nada vem selecionado — você digita
# quais ferramentas recebem as skills e, se forem ferramentas individuais, onde
# instalar (estrutura específica de cada uma ou ~/.agents/skills compartilhado).
#
# Uso:
#   git clone https://github.com/tallisazevedo/ia-skill.git
#   cd ia-skill
#   ./install.sh
#
# Atualizar depois:
#   git pull && ./install.sh

set -euo pipefail

REPO_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_SRC="$REPO_ROOT/skills"
SHARED_DIR="$HOME/.agents/skills"

TOOL_NAMES=("Claude Code" "Codex" "Gemini CLI" "Cursor" "OpenCode")
TOOL_COUNT=${#TOOL_NAMES[@]}
ALL=$((TOOL_COUNT + 1))

# Pasta de skills de cada ferramenta (escopo global, por usuário).
tool_dir() {
  case "$1" in
    1) printf '%s\n' "${CLAUDE_CONFIG_DIR:-$HOME/.claude}/skills" ;;
    2) printf '%s\n' "${CODEX_HOME:-$HOME/.codex}/skills" ;;
    3) printf '%s\n' "$HOME/.gemini/skills" ;;
    4) printf '%s\n' "$HOME/.cursor/skills" ;;
    5) printf '%s\n' "${XDG_CONFIG_HOME:-$HOME/.config}/opencode/skills" ;;
    *) return 1 ;;
  esac
}

# Skills do repositório: uma pasta por skill em skills/ (descoberta automática).
SKILLS="$(find "$SKILLS_SRC" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort)"
if [ -z "$SKILLS" ]; then
  echo "Nenhuma skill encontrada em $SKILLS_SRC" >&2
  exit 1
fi
SKILL_COUNT="$(printf '%s\n' "$SKILLS" | wc -l | tr -d ' ')"

# Copia as skills para dentro de uma pasta base, substituindo versões anteriores.
copy_skills_into() {
  local base="$1" skill
  mkdir -p "$base"
  while IFS= read -r skill; do
    rm -rf "$base/$skill"
    cp -R "$SKILLS_SRC/$skill" "$base/$skill"
  done <<< "$SKILLS"
  printf '  ✓ %s\n' "$base"
}

# Liga as skills de uma pasta base à cópia compartilhada em ~/.agents/skills.
link_skills_into() {
  local base="$1" skill
  mkdir -p "$base"
  while IFS= read -r skill; do
    rm -rf "$base/$skill"
    ln -s "$SHARED_DIR/$skill" "$base/$skill"
  done <<< "$SKILLS"
  printf '  ✓ %s (links → %s)\n' "$base" "$SHARED_DIR"
}

# Avisa quando a pasta de configuração da ferramenta não existia antes.
warn_if_new_tool_home() {
  local dir="$1" name="$2" home_dir
  home_dir="$(dirname "$dir")"
  if [ ! -d "$home_dir" ]; then
    printf '  ! %s: %s não existia e foi criado — confirme que a ferramenta está instalada\n' \
      "$name" "$home_dir"
  fi
}

echo
echo "Quais ferramentas devem receber as $SKILL_COUNT skills?"
echo
i=1
while [ "$i" -le "$TOOL_COUNT" ]; do
  printf '  %d) %s\n' "$i" "${TOOL_NAMES[$((i - 1))]}"
  i=$((i + 1))
done
printf '  %d) Todas\n' "$ALL"
echo

# Nada vem selecionado: a escolha é sempre digitada na hora.
SEL=""
MODE=""
while [ -z "$SEL" ]; do
  printf 'Digite os números separados por espaço (ex.: 1 3) ou %d para todas: ' "$ALL"
  if ! read -r LINE; then
    echo >&2
    echo "Entrada encerrada." >&2
    exit 1
  fi

  VALID=1
  WANT_ALL=0
  UNIQ=""
  for tok in $LINE; do
    case "$tok" in
      "$ALL")
        WANT_ALL=1
        ;;
      *[!0-9]*|"")
        VALID=0
        ;;
      *)
        if [ "$tok" -ge 1 ] && [ "$tok" -le "$TOOL_COUNT" ]; then
          case " $UNIQ " in
            *" $tok "*) ;;                       # duplicado: ignora
            *) UNIQ="${UNIQ:+$UNIQ }$tok" ;;
          esac
        else
          VALID=0
        fi
        ;;
    esac
  done

  if [ "$WANT_ALL" -eq 1 ]; then
    SEL="1 2 3 4 5"
    MODE="specific"
  elif [ "$VALID" -eq 1 ] && [ -n "$UNIQ" ]; then
    SEL="$UNIQ"
  else
    echo "Opção inválida. Use números de 1 a $TOOL_COUNT ou $ALL para todas."
  fi
done

# A pergunta de estrutura só existe para ferramentas individuais.
if [ -z "$MODE" ]; then
  echo
  echo "Onde instalar?"
  echo
  echo "  1) Na estrutura específica de cada ferramenta"
  echo "  2) Em $SHARED_DIR compartilhado (uma cópia + links)"
  echo
  while [ -z "$MODE" ]; do
    printf 'Escolha (1 ou 2): '
    if ! read -r STRUCT; then
      echo >&2
      echo "Entrada encerrada." >&2
      exit 1
    fi
    case "$STRUCT" in
      1) MODE="specific" ;;
      2) MODE="shared" ;;
      *) echo "Opção inválida. Digite 1 ou 2." ;;
    esac
  done
fi

echo
echo "Instalando $SKILL_COUNT skills..."
echo

if [ "$MODE" = "shared" ]; then
  copy_skills_into "$SHARED_DIR"
  for t in $SEL; do
    dir="$(tool_dir "$t")"
    warn_if_new_tool_home "$dir" "${TOOL_NAMES[$((t - 1))]}"
    link_skills_into "$dir"
  done
else
  for t in $SEL; do
    dir="$(tool_dir "$t")"
    warn_if_new_tool_home "$dir" "${TOOL_NAMES[$((t - 1))]}"
    copy_skills_into "$dir"
  done
fi

echo
echo "Pronto. Para atualizar depois: git pull && ./install.sh"
