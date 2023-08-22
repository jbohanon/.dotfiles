[ "$(which clang-format)" != "" ] && export CLANG_FORMAT=/opt/llvm/bin/clang-format || echo "WARNING: clang-format not installed. Required to push to envoy repo"
[ "$(which buildozer)" != "" ] && export BUILDOZER_BIN=$HOME/.go/go/bin/buildozer || echo "WARNING: buildozer not installed. Required to push to envoy repo"
([ "$(which buildifier)" != "" ] && export BUILDIFIER_BIN=$HOME/.go/go/bin/buildifier) || echo "WARNING: buildifier not installed. Required to push to envoy repo"

