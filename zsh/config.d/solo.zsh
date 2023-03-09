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


# Aliases to reach different repos
alias cdsi='cd $SOLO_DIR'
alias cdg='cd $SOLO_DIR/gloo'
alias nvg='cdg && nvim $SOLO_DIR/gloo/README.md'
alias cdgf='cd $SOLO_DIR/gloo-fed'
alias nvgf='cdgf && nvim $SOLO_DIR/gloo-fed/README.md'
alias cdsp='cd $SOLO_DIR/solo-projects'
alias nvsp='cdsp && nvim $SOLO_DIR/solo-projects/README.md'
alias cdsa='cd $SOLO_DIR/solo-apis'
alias nvsa='cdsa && nvim $SOLO_DIR/solo-apis/README.md'
alias cdsk='cd $SOLO_DIR/solo-kit'
alias nvsk='cdsa && nvim $SOLO_DIR/solo-kit/README.md'
alias cddp='cd $SOLO_DIR/dev-portal'
alias nvdp='cddp && nvim $SOLO_DIR/dev-portal/README.md'
alias cdgm='cd $SOLO_DIR/gloo-mesh'
alias nvgm='cdgm && nvim $SOLO_DIR/gloo-mesh/README.md'
alias cdgmui='cd $SOLO_DIR/gloo-mesh-ui'
alias nvgmui='cdgmui && nvim $SOLO_DIR/gloo-mesh-ui/README.md'
alias cdgme='cd $SOLO_DIR/gloo-mesh-enterprise'
alias nvgme='cdgme && nvim $SOLO_DIR/gloo-mesh-enterprise/README.md'
alias cdea='cd $SOLO_DIR/ext-auth-service'
alias nvea='cdea && nvim $SOLO_DIR/ext-auth-service/README.md'
alias cdrl='cd $SOLO_DIR/rate-limiter'
alias nvrl='cdrl && nvim $SOLO_DIR/rate-limiter/README.md'
alias cdeg='cd $SOLO_DIR/envoy-gloo'
alias nveg='cdeg && nvim $SOLO_DIR/envoy-gloo/README.md'
alias cdee='cd $SOLO_DIR/envoy-gloo-ee'
alias nvee='cdeg && nvim $SOLO_DIR/envoy-gloo-ee/README.md'

