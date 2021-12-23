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
        zero: 'You\'ve got zero orange.',
        one: 'You\'ve got $numberOfOranges orange.',
        other: 'You\'ve got $numberOfOranges oranges.',
        name: 'getOrangesText',
        args: [numberOfOranges],
      );
}
