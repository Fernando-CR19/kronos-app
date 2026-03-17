<p align="center">
  <img src="https://storage.googleapis.com/cms-storage-bucket/ec64036b4eaab3c118aa.svg" width="120" alt="Flutter Logo" />
</p>

<p align="center">
  <strong>Kronos App</strong> — Personal calendar app with offline-first sync, color tags and local notifications.
</p>

## Description

Mobile app for Android built with [Flutter](https://flutter.dev/). Kronos is a personal calendar with offline-first support, color tags, event types, and local notifications — free from third-party services like Google Calendar.

API repository: [kronos-api](https://github.com/your-user/kronos-api)

## Requirements

- [Flutter SDK](https://docs.flutter.dev/get-started/install) 3.x+
- [Android SDK](https://developer.android.com/studio#command-line-tools-only) with API 36
- Android device or emulator

## Getting started

### 1. Install dependencies

```bash
$ flutter pub get
```

### 2. Connect your Android device

- Enable **Developer Mode** on your device (tap "Build number" 7 times in Settings → About phone)
- Enable **USB Debugging** in Developer Options
- Connect via USB and allow the connection on your device

### 3. Verify device is recognized

```bash
$ flutter devices
```

### 4. Run the app

```bash
$ flutter run
```

## Useful commands during development

While the app is running, use these shortcuts in the terminal:

| Key | Action |
|-----|--------|
| `r` | Hot reload — updates the app instantly |
| `R` | Hot restart — restarts the app |
| `q` | Quit |

## Build APK

```bash
# Debug APK
$ flutter build apk --debug

# Release APK
$ flutter build apk --release
```

The APK will be generated at `build/app/outputs/flutter-apk/app-release.apk`.

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Documentation](https://dart.dev/guides)
- [Kronos API Repository](https://github.com/Fernando-CR19/kronos-api)

## License

MIT licensed.