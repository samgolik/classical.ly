# classical.ly

A polished Material 3 prototype for keeping a living classical repertoire and performance log.

## Run

1. Install the [Flutter SDK](https://docs.flutter.dev/get-started/install).
2. From this folder, run:

```sh
flutter pub get
flutter run
```

The prototype is deliberately self-contained: all feed, repertoire, recording, and profile data is mock data in `lib/data/mock_repository.dart`.

## Structure

- `lib/models` — simple domain models
- `lib/data` — mock repository / seed data
- `lib/features` — screens and feature-specific views
- `lib/widgets` — reusable presentation components
- `lib/theme` — Material 3 theme tokens
