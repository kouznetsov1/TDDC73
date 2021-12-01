import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Text("Laboration dos"),
          ),
          body: Column(
            children: [
              Container(
                child: const Center(
                  child: FractionallySizedBox(
                    child: CreditCard(),
                    widthFactor: 0.8,
                  ),
                ),
                margin: const EdgeInsets.only(top: 20),
              ),
              Container(
                child: const Center(
                  child: FractionallySizedBox(
                      child: InputBox(),
                      widthFactor: 0.9,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

class CreditCard extends StatefulWidget {
  const CreditCard({Key? key}) : super(key: key);

  @override
  _CreditCardState createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  var randomImg = "images/" + (Random().nextInt(25) + 1).toString() + ".jpeg";

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // for rounded corners
        borderRadius: BorderRadius.circular(15),
        child: Container(
          height: 210,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(randomImg),
                fit: BoxFit.cover,
              )),
          child: Column(
            children: [
              // FIRST ROW
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 0,
                      child: Container(
                        child: Image.asset("images/chip.png"),
                        height: 40,
                        margin: const EdgeInsets.all(10),
                      )),
                  Expanded(
                      flex: 2,
                      child: Container(
                        width: double.infinity,
                      )),
                  Expanded(
                      flex: 1,
                      child: Container(
                        child: Image.asset("images/troy.png"),
                        height: 40,
                        margin: const EdgeInsets.all(10),
                      )),
                ],
              ),
              // SECOND ROW
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(
                      top: 30, right: 15, left: 15, bottom: 30),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                  ),
                  child: Container(
                      margin: const EdgeInsets.all(2),
                      child: const Text(
                        "2494 1824 1924 1824",
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ))),
              // THIRD ROW
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 0,
                    child: Container(
                      margin: const EdgeInsets.only(left: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Card Holder",
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text("Card Holder Name",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                        width: double.infinity,
                      )
                  ),
                  Expanded(
                    flex: 0,
                    child: Container(
                      margin: const EdgeInsets.only(right: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text(
                            "Expires",
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text("09/27",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

class InputBox extends StatefulWidget {
  const InputBox({Key? key}) : super(key: key);

  @override
  _InputBoxState createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  @override
  Widget build(BuildContext context) {
    return Column(

    );
  }
}
