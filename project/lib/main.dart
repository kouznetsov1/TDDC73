import 'package:flutter/material.dart';
import 'passwordmeter.dart';
import 'carousel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Project TDDC73'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            // diff 1 : password length => 8
            // diff 2 : lower and upper case
            // diff 3 : numbers required
            // diff 4 : special characters required
            child: PasswordStrengthMeter(
              difficulty: 4,
              onPasswordChange: (text) {
                _password = text;
              },
            ),
          ),
          Text(_password),
          const SizedBox(height: 50),
          Container(
            child: Carousel(
              data: const ["images/bild1.jpeg", "images/bild2.jpeg", "images/bild3.jpeg", "images/bild4.jpeg", "images/bild5.jpeg"],
              title: "Stuff",
              numOfItems: 2,
            )
          )
        ],
      )
    );
  }
}
