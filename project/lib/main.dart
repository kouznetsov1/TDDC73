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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            child: PasswordStrengthMeter(
              difficulty: 3,
            ),
          ),
          SizedBox(height: 50),
          Container(
            child: Carousel(
              data: const ["images/bild1.jpeg", "images/bild2.jpeg", "images/bild3.jpeg", "images/bild4.jpeg", "images/bild5.jpeg"],
              title: "Stuff",
              numOfItems: 5,
            )
          )
        ],
      )
    );
  }
}
