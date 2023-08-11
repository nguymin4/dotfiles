#!/bin/bash

set -euo pipefail

# Install OpenJDK
sudo apt install openjdk-11-jdk-headless openjdk-11-jre-headless openjdk-11-jre

ANDROID_SDK_ROOT=$HOME/Programs/android
CLI_TOOL_DOWNLOAD_LINK=$(curl -s https://developer.android.com/studio\#command-tools | grep -o 'https.*commandlinetools-linux.*\.zip')
echo "Downloading $CLI_TOOL_DOWNLOAD_LINK..."
mkdir -p $ANDROID_SDK_ROOT && cd $ANDROID_SDK_ROOT
curl -L $CLI_TOOL_DOWNLOAD_LINK -o commandlinetools.zip

echo "Setting up Android command line tools..."
unzip commandlinetools.zip && rm commandlinetools.zip
mv cmdline-tools latest
mkdir cmdline-tools && mv latest cmdline-tools/

if ! grep -Fq "ANDROID_SDK_ROOT" $HOME/.path
then
  cat >> $HOME/.path <<-'EOH'
export ANDROID_SDK_ROOT=$HOME/Programs/android
export PATH=$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$PATH
export PATH=$ANDROID_SDK_ROOT/platform-tools:$PATH
export PATH=$ANDROID_SDK_ROOT/tools:$PATH
export PATH=$ANDROID_SDK_ROOT/emulator:$PATH
EOH
  source $HOME/.path
fi

function set_up_emulator() {
  sdkmanager --install "emulator" "platform-tools" "platforms;android-31" "build-tools;31.0.0" "system-images;android-31;google_apis_playstore;x86_64"

  avdmanager create avd -n pixel-android -k "system-images;android-31;google_apis_playstore;x86_64"

  # emulator -avd pixel-android
  # adb devices
}
