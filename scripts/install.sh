#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: ./scripts/install.sh codex|claude|both" >&2
  exit 2
}

[[ $# -eq 1 ]] || usage

target="$1"
repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_dir="${repo_root}/skills/da-sao-chu"
codex_dir="${CODEX_HOME:-${HOME}/.codex}/skills/da-sao-chu"
claude_dir="${HOME}/.claude/skills/da-sao-chu"
cleanup_paths=()

cleanup() {
  local status="$?"
  local path

  trap - EXIT INT TERM HUP
  for path in "${cleanup_paths[@]}"; do
    if [[ -e "${path}" || -L "${path}" ]]; then
      rm -R "${path}"
    fi
  done
  exit "${status}"
}

trap cleanup EXIT INT TERM HUP

install_skill() {
  local destination="$1"
  local parent
  local staging

  if [[ -e "${destination}" || -L "${destination}" ]]; then
    echo "Refusing to overwrite existing installation: ${destination}" >&2
    echo "Move or remove it explicitly, then run the installer again." >&2
    exit 1
  fi

  parent="$(dirname "${destination}")"
  mkdir -p "${parent}"
  staging="$(mktemp -d "${parent}/.da-sao-chu.install.XXXXXX")"
  cleanup_paths+=("${staging}")

  if ! cp -R "${source_dir}/." "${staging}/"; then
    return 1
  fi

  if ! mkdir "${destination}"; then
    return 1
  fi
  cleanup_paths+=("${destination}")

  cp -R "${staging}/." "${destination}/"
  rm -R "${staging}"

  echo "Installed da-sao-chu -> ${destination}"
}

case "${target}" in
  codex)
    install_skill "${codex_dir}"
    ;;
  claude)
    install_skill "${claude_dir}"
    ;;
  both)
    if [[ -e "${codex_dir}" || -L "${codex_dir}" || -e "${claude_dir}" || -L "${claude_dir}" ]]; then
      [[ -e "${codex_dir}" || -L "${codex_dir}" ]] && echo "Existing installation: ${codex_dir}" >&2
      [[ -e "${claude_dir}" || -L "${claude_dir}" ]] && echo "Existing installation: ${claude_dir}" >&2
      echo "No files were installed. Resolve the existing installation first." >&2
      exit 1
    fi
    install_skill "${codex_dir}"
    install_skill "${claude_dir}"
    ;;
  *)
    usage
    ;;
esac

cleanup_paths=()
trap - EXIT INT TERM HUP
