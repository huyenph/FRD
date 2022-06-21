# UPM Mobile App

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
