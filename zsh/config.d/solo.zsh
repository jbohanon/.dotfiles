SOLO_DIR="$HOME/src/github.com/solo-io"
SOLO_GITHUB="https://github.com/solo-io"

SOLO_REPOS=(
"gloo"
"gloo-gateway"
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
"caching-service"
"envoy-gloo-ee"
"agentgateway-enterprise"
)

AGW_DIR="$HOME/src/github.com/agentgateway"
AGW_GITHUB="https://github.com/agentgateway"

AGW_REPOS=(
    "agentgateway"
)

KGW_DIR="$HOME/src/github.com/kgateway-dev"
KGW_GITHUB="https://github.com/kgateway-dev"

KGW_REPOS=(
    "kgateway"
)


mkdir -p $SOLO_DIR $AGW_DIR $KGW_DIR

# Used to generalize the git clone loop for different orgs
# Don't mind the fuckery that claude found for passing the 
# repos arrays as namerefs
#
# Pass the following arguments
# 1: github as should be defined in above
# 2: dir as should be defined in above
# 3: repos arr as should be defined above
function clone_repos() {
    local gh="${1}"
    local dir="${2}"
    local -a repos=("${(@P)3}")

    for repo in "${repos[@]}"
    do
        local repo_addr="${gh}/${repo}"
        local repo_dir="${dir}/${repo}"

        if [[ ! -d $repo_dir ]]; then
            pushd $dir
            git clone $repo_addr
            popd
        fi
    done
}

clone_repos "${SOLO_GITHUB}" "${SOLO_DIR}" SOLO_REPOS
clone_repos "${KGW_GITHUB}" "${KGW_DIR}" KGW_REPOS
clone_repos "${AGW_GITHUB}" "${AGW_DIR}" AGW_REPOS

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
alias cdcs='cd $SOLO_DIR/caching-service'
alias nvcs='cdcs && nvim_readme'
alias cdeg='cd $SOLO_DIR/envoy-gloo'
alias nveg='cdeg && nvim_readme'
alias cdee='cd $SOLO_DIR/envoy-gloo-ee'
alias nvee='cdee && nvim_readme'
alias cde='cd $SOLO_DIR/../envoyproxy/envoy'
alias nve='cde && nvim_readme'
alias cdgg='cd $SOLO_DIR/gloo-gateway'
alias nvgg='cdgg && nvim_readme'
alias cdagw='cd $AGW_DIR/agentgateway'
alias nvagw='cdagw && nvim_readme'
alias cdagwe='cd $SOLO_DIR/agentgateway-enterprise'
alias nvagwe='cdagwe && nvim_readme'
alias cdkgw='cd $KGW_DIR/kgateway'
alias nvkgw='cdkgw && nvim_readme'

