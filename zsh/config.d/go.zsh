# GO stuff
export GOPATH="${HOME}/go"
#export GOROOT="$(brew --prefix golang)/libexec"
export GOROOT="/usr/local/go"
export PATH=${GOPATH}/bin:${GOROOT}/bin:$PATH
export GOPRIVATE="github.com/solo-io"
export ACK_GINKGO_DEPRECATIONS=1.16.5
export GOLANG_PROTOBUF_REGISTRATION_CONFLICT=warn

