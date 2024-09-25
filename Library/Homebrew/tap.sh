# Does the quickest output of brew tap possible for no arguments.
# HOMEBREW_LIBRARY is set by bin/brew
# shellcheck disable=SC2154

normalise_tap_name() {
  local dir="$1"
  local user
  local repo

  user="$(tr '[:upper:]' '[:lower:]' <<<"${dir%%/*}")"
  repo="$(tr '[:upper:]' '[:lower:]' <<<"${dir#*/}")"
  repo="${repo#@(home|linux)brew-}"
  echo "${user}/${repo}"
}

homebrew-tap() {
  local taplib="${HOMEBREW_LIBRARY}/Taps"
  (
    shopt -s extglob

    for dir in "${taplib}"/*/*
    do
      [[ -d "${dir}" ]] || continue
      dir="${dir#"${taplib}"/}"
      normalise_tap_name "${dir}"
    done | sort
  )
}
