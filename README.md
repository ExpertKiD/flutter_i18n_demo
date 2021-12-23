
# Localizing your application

## 1. Introduction

We are going to localize our application using the `intl` package. This guide is based on 
[Flutter Docs - Internationalization](https://docs.flutter.dev/development/accessibility-and-localization/internationalization).

We'll make use of `*.arb` files for translations. And, we'll use `intl_generator` as dev dependency
for generating the arb files. You can check above link to documentation to check the guide for yourself.
We are going to use the initial approach from the guide. SO, let's begin.

## 2. Adding dependencies to project

1. In your `pubspec.yaml` file, add `flutter_localization` package.
```yaml
dependencies:
  flutter_localization:
    sdk: flutter
```
2. Then add `intl` package as dependency.
`flutter pub add intl`
   
3. Then add `intl_generator` package as dev dependency. We'll use it to generate the `.arb` file.
`flutter pub add -d intl_generator`

4. Set `generate` to `true`. This will automatically create the delegate for the application.

```yaml
flutter:
  generate: true
```

`pubspec.yaml` file should look something like this.


```yaml
dependencies:
  flutter_localization:
    sdk: flutter
  intl: ^0.17.0
  
dev_dependencies:
  intl_generator: ^0.2.1

flutter:
  generate: true
  uses-material-design: true

```


To generate the ARB file, run:

`flutter pub run intl_generator:extract_to_arb --output-dir=lib/l10n/translations --locale=en --output-file=app_en.arb lib/l10n/localization.dart`

Link:
1. https://lokalise.com/blog/flutter-i18n/#Getting_started_with_Flutter_i18n
2. https://flagpedia.net/emoji
3. https://docs.flutter.dev/development/accessibility-and-localization/internationalization#dart-tools