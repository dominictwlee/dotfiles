#!/bin/bash

echo "Dom's dotfile"
echo "Setting up your Ubuntu environment..."

if [ -d ~/.nvm ]; then
  echo "✅ nvm is installed"
else
  echo "nvm is not installed, installing..."
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
  echo "👍 nvm installation finished"
fi

echo "Installing node LTS"
nvm install --lts

if [ "$(which yarn)" ]; then
  echo "✅ yarn is installed"
else
  echo "Installing Yarn"
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list && \
  sudo apt-get update && sudo apt-get install --no-install-recommends yarn && \
  echo "PATH=$(yarn global bin):$PATH" >> ~/.bashrc || \
  echo "❌ yarn installation failed"
fi

echo "Installing VSCode"
cd ~/Downloads && sudo apt update && sudo apt install ./vscode.deb && \
echo "VSCode installed"
echo "Installing vscode settings sync extension..."
code --install-extension Shan.code-settings-sync

echo "Installing Android Studio..."
sudo apt install libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386 unzip
unzip android-studio-ide.zip
sudo mv ~/Downloads/android-studio /usr/local && cd /usr/local/android-studio/bin && ./studio.sh || \
echo "Android Studio installation failed"
