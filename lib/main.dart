import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Globoticket',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Ticket Purchase'),
        ),
        body: OrderForm(),
      ),
    );
  }
}

class OrderForm extends StatefulWidget {
  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _controller;
  double _ticketPrice = 0;
  int _amount = 0;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Map<String, double> _categories = {
      'Standing': 33.33,
      'Upper Level': 44.44,
      'Lower Level': 55.55,
    };

    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image(image: AssetImage('assets/logo.png')),
              TextFormField(
                controller: _controller,
                decoration: new InputDecoration(
                  icon: const Icon(Icons.calendar_today),
                  labelText: 'Event Date',
                  hintText: 'Enter event date here',
                ),
                keyboardType: TextInputType.datetime,
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());

                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(new Duration(days: 31)),
                  ).then((value) {
                    _controller.text = value.toString().substring(0, 10);
                  });
                },
              ),
              DropdownButtonFormField(
                  decoration: new InputDecoration(
                    icon: const Icon(Icons.event_seat_outlined),
                    labelText: 'Seat Category',
                    hintText: 'Choose a seat category',
                  ),
                  items: _categories
                      .map((name, price) {
                        return MapEntry(
                            name,
                            DropdownMenuItem(
                              value: price,
                              child: Text('$name (\$$price)'),
                            ));
                      })
                      .values
                      .toList(),
                  onChanged: (value) {
                    _ticketPrice = value as double;
                  }),
              TextFormField(
                  decoration: new InputDecoration(
                    icon: const Icon(Icons.confirmation_number),
                    labelText: 'Amount',
                    hintText: 'Enter number of tickets',
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    _amount = int.tryParse(value) ?? 0;
                  }),
              Padding(
                  padding: EdgeInsets.all(16.0),
                  child: RaisedButton(
                      child: Text('Order'),
                      onPressed: () {
                        if (_formKey.currentState != null &&
                            _formKey.currentState!.validate()) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'You ordered $_amount tickets for a total of \$${_amount * _ticketPrice}'),
                          ));
                        }
                      })),
            ],
          ),
        ));
  }
}
