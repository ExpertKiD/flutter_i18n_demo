import 'package:intl/intl.dart';

class AppLocalization {
  String get appTitle => Intl.message(
        'Home',
        name: 'appTitle',
        desc: 'Application title/name',
      );

  String get helloWorld => Intl.message(
        'Hello World!',
        name: 'helloWorld',
        desc: 'Hello World message',
      );

  String getOrangesText(int numberOfOranges) => Intl.plural(
        numberOfOranges,
        zero: 'Zero orange',
        one: '$numberOfOranges orange',
        other: '$numberOfOranges oranges',
        name: 'getOrangesText',
        args: [numberOfOranges],
      );
}
