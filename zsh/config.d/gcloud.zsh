# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

alias startenvoydev="gcloud compute instances start bohanon-envoy-dev --zone us-central1-c --project solo-test-236622 && gcloud compute config-ssh --force-key-file-overwrite --project solo-test-236622"
alias stopenvoydev="gcloud compute instances stop bohanon-envoy-dev --zone us-central1-c --project solo-test-236622"
alias sshenvoydev="gcloud beta compute ssh --zone us-central1-c bohanon-envoy-dev --project solo-test-236622"

