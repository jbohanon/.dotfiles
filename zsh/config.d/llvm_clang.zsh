if [[ -d /opt/llvm ]]; then
    export PATH=/opt/llvm/bin:$PATH
elif [[ -d /opt/clang+llvm ]]; then
    export PATH=/opt/clang+llvm/bin:$PATH
fi
