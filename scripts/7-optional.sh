sudo apt install watchman

sdkmanager --install "emulator" "platform-tools" "platforms;android-29" "build-tools;29.0.2" "system-images;android-29;default;x86_64"

avdmanager create avd -n meru -k "system-images;android-29;default;x86_64"
