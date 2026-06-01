cdf_preview() {
    if [ -d $1 ]; then 
        tree -L 1 $1
    else
        cat $1
    fi
}
# cdf - cd with fuzzy finder
# Usage: cdf [path]
cdf() {
    local fd_options fzf_options target

    fd_options=(
        --hidden
    )

    fzf_options=(
        # --preview='echo {}'
        --preview='([[ -d {} ]] && tree -L 1 {}) || ([[ -L {} ]] && ls -al {}) || cat {}'
        --bind=ctrl-space:toggle-preview
        --exit-0
    )

    target="$(fdfind . "${1:-.}" "${fd_options[@]}" | fzf "${fzf_options[@]}")"

    ([[ -f "$target" ]] || [[ -L "$target" ]]) && target="${target%/*}"

    cd "$target" || return 1
}
