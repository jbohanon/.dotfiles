SOLO_DIR="$HOME/src/github.com/solo-io"
SOLO_GITHUB="https://github.com/solo-io"

mkdir -p $SOLO_DIR

REPOS=(
"gloo"
"gloo-fed"
"solo-projects"
"solo-apis"
"solo-kit"
"dev-portal"
"gloo-mesh"
"gloo-mesh-ui"
"gloo-mesh-enterprise"
"ext-auth-service"
"rate-limiter"
"envoy-gloo"
"envoy-gloo-ee"
)

for repo in "${REPOS[@]}"
do
    repo_addr="${SOLO_GITHUB}/${repo}"
    repo_dir="${SOLO_DIR}/${repo}"
    if [[ ! -d $repo_dir ]]; then
        pushd $SOLO_DIR
        git clone $repo_addr
        popd
    fi
done

function nvim_readme() {
    nvim ./README.md
}

# Aliases to reach different repos
alias cdsi='cd $SOLO_DIR'
alias cdg='cd $SOLO_DIR/gloo'
alias nvg='cdg && nvim_readme'
alias cdgf='cd $SOLO_DIR/gloo-fed'
alias nvgf='cdgf && nvim_readme'
alias cdsp='cd $SOLO_DIR/solo-projects'
alias nvsp='cdsp && nvim_readme'
alias cdsa='cd $SOLO_DIR/solo-apis'
alias nvsa='cdsa && nvim_readme'
alias cdsk='cd $SOLO_DIR/solo-kit'
alias nvsk='cdsk && nvim_readme'
alias cddp='cd $SOLO_DIR/dev-portal'
alias nvdp='cddp && nvim_readme'
alias cdgm='cd $SOLO_DIR/gloo-mesh'
alias nvgm='cdgm && nvim_readme'
alias cdgmui='cd $SOLO_DIR/gloo-mesh-ui'
alias nvgmui='cdgmui && nvim_readme'
alias cdgme='cd $SOLO_DIR/gloo-mesh-enterprise'
alias nvgme='cdgme && nvim_readme'
alias cdea='cd $SOLO_DIR/ext-auth-service'
alias nvea='cdea && nvim_readme'
alias cdrl='cd $SOLO_DIR/rate-limiter'
alias nvrl='cdrl && nvim_readme'
alias cdeg='cd $SOLO_DIR/envoy-gloo'
alias nveg='cdeg && nvim_readme'
alias cdee='cd $SOLO_DIR/envoy-gloo-ee'
alias nvee='cdee && nvim_readme'
alias cde='cd $SOLO_DIR/../envoyproxy/envoy'
alias nve='cde && nvim_readme'

