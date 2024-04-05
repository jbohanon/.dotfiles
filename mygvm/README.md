### My GVM
This tool was written to share a single `GOPATH` despite multiple different Go versions, which require their own `GOROOT`.

It will find and install latest minor or explicit patch versions.

Due to `GOBIN` switching around, a list of modules can be specified to install. These should be located at
`$HOME/.config/mygvm/modules_to_install` separated by newlines
