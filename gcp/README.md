# Google cloud

https://formulae.brew.sh/cask/google-cloud-sdk
brew install --cask google-cloud-sdk

source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

https://console.cloud.google.com/getting-started?project=versatile-nomad-305511

## cli
https://cloud.google.com/sdk/docs/quickstart-macos?hl=fr
export CLOUDSDK_PYTHON=python2
./install.sh

gcloud -v
gcloud init
gcloud info
gcloud help

gcloud auth list
gcloud config list
