# Localizing your application

## 1. Introduction

We are going to localize our application using the `intl` package. This guide is based on
[Flutter Docs - Internationalization](https://docs.flutter.dev/development/accessibility-and-localization/internationalization)
.

We'll make use of `*.arb` files for translations. And, we'll use `intl_generator` as dev dependency
for generating the arb files. You can check above link to documentation to check the guide for
yourself. We are going to use the initial approach from the guide. SO, let's begin.

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

## 3. Creating the localization configuration

Add `l10n.yaml` file in the root directory along with `pubspec.yaml`. By default, flutter
applications supports the english language. But, you may choose to start with any language you like
as the base.

```yaml
arb-dir: lib/l10n/translations
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
```

## 4. Create localization messages

Create any file containing the localization texts. For our case, we'll make `localization.dart` file
inside the `lib/l10n/` folder. You must add messages here using `Intl.message(...)`
, `Intl.plural(...)`
and so on.

```dart
import 'package:intl/intl.dart';

class AppLocalization {
  String get appTitle =>
      Intl.message(
        'Home',
        name: 'appTitle',
        desc: 'Application title/name',
      );

  String get helloWorld =>
      Intl.message(
        'Hello World!',
        name: 'helloWorld',
        desc: 'Hello World message',
      );

  String getOrangesText(int numberOfOranges) =>
      Intl.plural(
        numberOfOranges,
        zero: 'You\'ve got zero orange.',
        one: 'You\'ve got $numberOfOranges orange.',
        other: 'You\'ve got $numberOfOranges oranges.',
        name: 'getOrangesText',
        args: [numberOfOranges],
      );
}
```

In this way, write all of the messages for the application in one locale.

## 5. Generate the initial translation file

Run the below command to generate the first translation. We'll name it as `app_en.arb`. Feel free to
change the name to your preferred locale.

`flutter pub run intl_generator:extract_to_arb --output-dir=lib/l10n/translations --locale=en --output-file=app_en.arb lib/l10n/localization.dart`

Now, there will be a new file generated in the folder `lib/l10n/transalations` named `app_en.arb`.

**File:** app_en.arb

```json
{
  "@@last_modified": "2021-12-23T13:00:15.533122",
  "appTitle": "Home",
  "@appTitle": {
    "description": "Application title/name",
    "type": "text",
    "placeholders_order": [],
    "placeholders": {}
  },
  "helloWorld": "Hello World!",
  "@helloWorld": {
    "description": "Hello World message",
    "type": "text",
    "placeholders_order": [],
    "placeholders": {}
  },
  "getOrangesText": "{numberOfOranges,plural, =0{You've got zero orange.}=1{You've got {numberOfOranges} orange.}other{You've got {numberOfOranges} oranges.}}",
  "@getOrangesText": {
    "type": "text",
    "placeholders_order": [
      "numberOfOranges"
    ],
    "placeholders": {
      "numberOfOranges": {}
    }
  }
}
```

## 6. Translate to another locale

Now, that you have the file generated, duplicate the file to other locale. This is the step known as
translation. Duplicate the file and rename to `app_es.arb`.

```json
{
  "@@locale": "es",
  "@@last_modified": "2021-12-22T23:49:10.302862",
  "appTitle": "Casa",
  "@appTitle": {
    "description": "Application title/name",
    "type": "text",
    "placeholders_order": [],
    "placeholders": {}
  },
  "helloWorld": "Hola Mundo!",
  "@helloWorld": {
    "description": "Hello World message",
    "type": "text",
    "placeholders_order": [],
    "placeholders": {}
  },
  "getOrangesText": "{numberOfOranges,plural, =0{Tienes cero naranjas.}=1{Tienes {numberOfOranges} naranja.}other{Tienes {numberOfOranges} naranjas.}}",
  "@getOrangesText": {
    "type": "text",
    "placeholders_order": [
      "numberOfOranges"
    ],
    "placeholders": {
      "numberOfOranges": {}
    }
  }
}
```

## 7. Import the generated package for use

**Note:** Flutter will automatically generate the `AppLocalizations` class inside the folder
`.dart_tool/flutter_gen/gen_l10n` folder. Likewise, a new package `flutter_gen` will be available to
import. The `AppDelegate` for localization wil lbe provided by flutter.

Now, import the package as below for use.

`import 'package:flutter_gen/gen_l10n/app_localizations.dart';`

## 8. Update settings in MaterialApp/CupertinoApp

Now in your `MaterialApp`/`CupertinoApp`, add the following lines:

```dart
return MaterialApp(
   onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
   supportedLocales: AppLocalizations.supportedLocales, // Add supported locales
   localizationsDelegates: AppLocalizations.localizationsDelegates, // Add localization delegates
   locale: _locale,
   home: HomeScreen(),
);
```

## 9. Use the translated texts

Now, wherever you need the translated texts, use `AppLocalizations.of(context)!.[fieldOrMethodName]`
to get the text.

For example, we can use `AppLocalaization.of(context)!.appTitle` to get the application title in 
system locale.

```dart
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:globalapp/app/app.dart';
import 'package:globalapp/models/langauge.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var supportedLanguages = <Language>[
    Language(1, '', 'System Default', 'system'),
    Language(2, "🇺🇸", "English", "en"),
    Language(3, "🇺🇸", "English(UK)", "en", regionCode: 'GB'),
    Language(4, "🇪🇸", "Spanish", "es"),
    Language(5, "🇸🇦", "Arabic", "ar"),
  ];

  void onSelect(Language item) {
    switch (item.languageCode) {
      case 'en':
        print('English selected');
        if (item.regionCode == 'GB') {
          MyApp.of(context)?.setLocale(const Locale('en', 'GB'));
        } else {
          MyApp.of(context)?.setLocale(const Locale('en'));
        }

        break;
      case 'es':
        print('Spanish selected');
        MyApp.of(context)?.setLocale(const Locale('es'));
        break;

      case 'ar':
        print('Arabic selected');
        MyApp.of(context)?.setLocale(const Locale('ar'));
        break;

      case 'system':
        print('System selected ${Platform.localeName}');
        MyApp.of(context)?.setLocale(null);
        break;

      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(
        context); // Returns the current locale of the app
    print("App locale: " + myLocale.toString());

    final String defaultLocale =
        Platform.localeName; // Returns the current locale of the system
    print("Current Locale(system): " + defaultLocale);

    final List<Locale> systemLocales = window
        .locales; // Returns the list of locales that user defined in the system settings.

    print("System Locales: " + systemLocales.toString());
    print("System Locales Count: " + systemLocales.length.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
        actions: [
          PopupMenuButton<Language>(
              onSelected: onSelect,
              itemBuilder: (BuildContext context) {
                return supportedLanguages.map((Language choice) {
                  return PopupMenuItem<Language>(
                    child: Text(choice.toString()),
                    value: choice,
                  );
                }).toList();
              }),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(AppLocalizations.of(context)!.helloWorld),
          ),
          Center(
            child: Text(AppLocalizations.of(context)!.getOrangesText(5)),
          ),
        ],
      ),
    );
  }
}
```

___

# Additional guide

## 1. Get Locale

### 1.1. Getting current system preferences

1. **Get the current system locale**

```dart
import 'dart:io';

final String defaultLocale = Platform.localeName; // Returns locale string in the form 'en_US'
```

2. **Get the list of system locales**
```dart
import 'package:flutter/material.dart';
// Returns the list of locales that user defined in the system settings.
// [en_US, en_GB, es_US, ar_EG]
final List<Locale> systemLocales = WidgetsBinding.instance.window.locales; 
```
or
```dart
import 'dart:ui';

final List<Locale> systemLocales = window.locales;
```
## 1.2. **Get the current system locale**

```dart
// Getting your application locale
final Locale appLocale = Localizations.localeOf(context);
```


## References

1. [Lokalise](https://lokalise.com/blog/flutter-i18n/#Getting_started_with_Flutter_i18n)
2. [Flag Emoji](https://flagpedia.net/emoji)
3. [Flutter Internationlization Documentation](https://docs.flutter.dev/development/accessibility-and-localization/internationalization#dart-tools)