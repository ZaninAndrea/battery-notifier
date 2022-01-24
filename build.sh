rm -rf ./releases
mkdir ./releases
mkdir ./releases/linux ./releases/macos-apple ./releases/macos-intel ./releases/windows
cp -r "./Battery Notifier Template.app" "./releases/macos-apple/Battery Notifier.app/"
cp -r "./Battery Notifier Template.app" "./releases/macos-intel/Battery Notifier.app/"

env GOOS=darwin GOARCH=arm64 go build -o "./releases/macos-apple/Battery Notifier.app/Contents/MacOS/notifier" .
env GOOS=darwin GOARCH=amd64 go build -o "./releases/macos-intel/Battery Notifier.app/Contents/MacOS/notifier" .
env GOOS=windows GOARCH=amd64 go build -o "./releases/windows/notifier.exe" .
env GOOS=linux GOARCH=amd64 go build -o "./releases/linux/notifier" .

cd ./releases/macos-intel
zip -vr "./Battery Notifier (MacOS Intel Chip).zip" "./Battery Notifier.app"
cd ../macos-apple
zip -vr "./Battery Notifier (MacOS Apple Chip).zip" "./Battery Notifier.app"
cd ../..