# Store Assets — Oda App

## Files to prepare manually:
- screenshots/ (8 screenshots from emulator: Home, Detail, Reading, Profile, Login, Search, Dark Mode, Settings)
- feature_graphic_1024x500.png (hero image for Play Store listing)
- icon_512x512.png (copy from assets/icon/app_icon.png and resize to 512x512)

## Release AAB:
build/app/outputs/bundle/release/app-release.aab

## Build command:
flutter build appbundle --release --dart-define=BASE_URL=https://YOUR-RAILWAY-URL

## keystore:
~/oda-release.jks (alias: oda)
Password: stored in android/key.properties (not in git)
