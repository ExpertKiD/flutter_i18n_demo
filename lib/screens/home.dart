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
    Language(1, "🇺🇸", "English", "en"),
    Language(1, "🇺🇸", "English(UK)", "en", regionCode: 'GB'),
    Language(2, "🇪🇸", "Spanish", "es"),
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
        title: const Text('Home'),
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
            child: Text('You\'ve got \$10 dollars!'),
          ),
        ],
      ),
    );
  }
}
