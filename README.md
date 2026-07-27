# classical.ly

A polished Material 3 prototype for keeping a living classical repertoire and performance log.

## Run

1. Install the [Flutter SDK](https://docs.flutter.dev/get-started/install).
2. From this folder, run:

```sh
flutter pub get
flutter run
```

The prototype starts with an empty personal repertoire. Add a work through the Log tab and it will appear across Home, Search, and Profile for the current app session. A future persistence layer can replace `lib/data/repertoire_store.dart`.

## Structure

- `lib/models` — simple domain models
- `lib/data` — in-memory repertoire store
- `lib/features` — screens and feature-specific views
- `lib/widgets` — reusable presentation components
- `lib/theme` — Material 3 theme tokens
