# UPM Mobile App - Using BloC, Clean Architecture, Getit, etc, ...

## Folder structure

```
android/
  app/
    src/
      debug/
      development/
      main/
      production/
      profile/
      staging/
ios/
  Config/
    development/
    production/
    staging/
lib/
  src/
    blocs/
    common/
    configs/
    core/
    data/
      datasources/
      repositories/
    di/
    domain/
      models/
      repositories/
      usecases/
    modules/
    presentation/
      widgets/
      components/
      screens/
  main_dev.dart
  main_stag.dart
  main_prod.dart
  upm_app.dart
  test/
  pubspec.lock
  pubspec.yaml
  README.md
```

## Visual Studio Code

You would need to have the latest version of VS Code.

Then add the block below to your launch.json file and put it inside the .vscode folder in your app’s root directory.

```json
  {
    "name": "flavor-prod",
    "request": "launch",
    "type": "dart",
    "program": "lib/main_prod.dart",
    "args": [
      "--flavor",
      "production",
    ]
  },
```

## Terminal

Development: flutter run --flavor development -t lib/main_dev.dart
Staging: flutter run --flavor staging -t lib/main_stag.dart
Production: flutter run --flavor production -t lib/main_prod.dart
