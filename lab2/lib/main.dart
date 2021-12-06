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
          body: Stack(
            children: [
              Positioned(
                  child: Container(
                    child: const Positioned(
                      child: InputBox(),
                    ),
                    margin: const EdgeInsets.only(top: 10),
                    color: Colors.white,
                  ),
                  height: 450,
                  width: 380,
                  right: 15,
                  top: 120),
              /*Positioned(
                  child: Container(
                    child: const FractionallySizedBox(
                      child: CreditCard(),
                      widthFactor: 0.85,
                    ),
                    margin: const EdgeInsets.only(top: 20),
                  ),
                  height: 230,
                  right: 10,
                  left: 10),*/
            ],
          ),
          backgroundColor: Colors.blue[100]),
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
                    )),
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
      ),
    );
  }
}

class InputBox extends StatefulWidget {
  const InputBox({Key? key}) : super(key: key);

  @override
  _InputBoxState createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  String expirationDateMonth = "Month";
  String expirationDateYear = "Year";

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // this one does not work for some reason
      borderRadius: BorderRadius.circular(15),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 100,
            ),
            Container(
              child: const Text("Card Number"),
              padding: const EdgeInsets.only(left: 10, top: 10),
            ),
            Container(
                child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    )),
                width: 400,
                height: 70),
            Container(
              child: const Text("Card Name"),
              padding: const EdgeInsets.only(left: 10),
            ),
            Container(
                child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    )),
                width: 400,
                height: 70),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        child: const Text("Expiration Date"),
                        padding: const EdgeInsets.only(left: 10, bottom: 10)),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 60,
                          height: 40,
                          // Rounded border
                          decoration: const ShapeDecoration(
                              shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1.0, style: BorderStyle.solid),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          )),
                          // MONTH DROPDOWN
                          child: DropdownButton(
                            alignment: Alignment.center,
                            value: expirationDateMonth,
                            hint: const Text("Month"),
                            items: <String>[
                              "1",
                              "2",
                              "3",
                              "4",
                              "5",
                              "6",
                              "7",
                              "8",
                              "9",
                              "10",
                              "11",
                              "12",
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                expirationDateMonth = newValue!;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 60,
                          height: 40,
                          decoration: const ShapeDecoration(
                              shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1.0, style: BorderStyle.solid),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          )),
                          // YEAR DROPDOWN
                          child: const Text("hej")
                        )
                      ],
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
