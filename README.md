# UPM Mobile App - Using BloC, Clean Architecture, Getit, etc, ...

## Project Structure

* [android](./android)
* [ios](./ios)
* [lib](./lib)
  * [common](./lib/common)
  * [blocs](./lib/blocs)
  * [configs](./lib/configs)
  * [core](./lib/core)
  * [data](./lib/data)
    * [datasource](./lib/data/datasource)
      * [local](./lib/data/datasource/local)
      * [remote](./lib/data/datasource/remote)
    * [repositories](./lib/data/repositories)
  * [di](./lib/di)
  * [domain](./lib/domain)
    * [models](./lib/domain/models)
    * [repositories](./lib/domain/repositories)
    * [usecases](./lib/domain/usecases)
  * [modules](./lib/modules)
  * [presentation](./lib/presentation)
    * [base](./lib/presentation/base) 
    * [components](./lib/presentation/components)
    * [screens](./lib/presentation/screens)
 * [main_dev.dart](./lib/main_dev.dart)
 * [main_stag.dart](./lib/main_stag.dart)
 * [main_prod.dart](./lib/main_prod.dart)
 * [upm_app.dart](./lib/upm_app.dart)


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
```
Development: flutter run --flavor development -t lib/main_dev.dart
Staging: flutter run --flavor staging -t lib/main_stag.dart
Production: flutter run --flavor production -t lib/main_prod.dart
```
