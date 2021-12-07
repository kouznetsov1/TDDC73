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
  final data = Data();

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
                      child: InputBox(/*data: data*/),
                    ),
                    margin: const EdgeInsets.only(top: 10),
                    color: Colors.white,
                  ),
                  height: 450,
                  width: 380,
                  right: 15,
                  top: 120),
              Positioned(
                  child: Container(
                    child: const FractionallySizedBox(
                      child: CreditCard(),
                      widthFactor: 0.85,
                    ),
                    margin: const EdgeInsets.only(top: 20),
                  ),
                  height: 230,
                  right: 10,
                  left: 10),
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

class Data {
  String expirationDateMonth = "";
  String expirationDateYear = "";
  String cardNumber = "";
  String cardCVV = "";
  String amexCardMask = "#### ###### #####";
  String otherCardMask = "#### #### #### ####";
  bool isCardFlipped = false;
}

class InputBox extends StatefulWidget {
  const InputBox({Key? key}) : super(key: key);

  @override
  _InputBoxState createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  String expirationDateMonth = "1";
  String expirationDateYear = "2021";
  List<String> months = [
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
    "12"
  ];
  List<String> years = [
    "2021",
    "2022",
    "2023",
    "2024",
    "2025",
    "2026",
    "2027",
    "2028",
    "2029",
    "2030"
  ];

  final myController = TextEditingController();


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
              padding: const EdgeInsets.only(left: 10, top: 25),
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
                          width: 100,
                          height: 40,
                          alignment: Alignment.center,
                          // Rounded border
                          decoration: const ShapeDecoration(
                              shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1.0, style: BorderStyle.solid, color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          )),
                          // MONTH DROPDOWN
                          child: DropdownButton(
                            hint: const Text("Month"),
                            alignment: Alignment.center,
                            value: expirationDateMonth,
                            items: months
                                .map((label) => DropdownMenuItem(
                                      child: Text(label),
                                      value: label,
                                    ))
                                .toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                expirationDateMonth = newValue!;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 100,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: const ShapeDecoration(
                              shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1.0, style: BorderStyle.solid, color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          )),
                          // YEAR DROPDOWN
                          child: DropdownButton(
                            hint: const Text("Year"),
                            alignment: Alignment.center,
                            value: expirationDateYear,
                            items: years
                                .map((label) => DropdownMenuItem(
                                      child: Text(label),
                                      value: label,
                                    ))
                                .toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                expirationDateYear = newValue!;
                              });
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: const Text("CVV"),
                      padding: const EdgeInsets.only(bottom: 10),
                    ),
                    Container(
                      child: TextField(
                        decoration: InputDecoration(
                        ),
                      ),
                      width: 100,
                      height: 40,
                      alignment: Alignment.center,
                      // Rounded border
                      decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      )),
                    ),
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
