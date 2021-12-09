import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'cardmodel.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CardModel(),
      child: const MyApp(),
    ),
  );
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
              // INPUTBOX
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
              // CREDITCARD
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
        child: Consumer<CardModel>(
          builder: (context, card, child) {
            if (card.frontCard) {
              return Container(
                height: 210,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(randomImg),
                  fit: BoxFit.cover,
                )),
                child: Column(
                  children: [
                    // FIRST ROW - SILVER CARD, CARD LOGO
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
                              child: Consumer<CardModel>(
                                builder: (context, card, child) {
                                  return Image.asset(
                                      "images/${card.cardIcon}.png");
                                },
                              ),
                              height: 40,
                              margin: const EdgeInsets.all(10),
                            )),
                      ],
                    ),
                    // SECOND ROW - CARD NUMBER
                    Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(
                            top: 30, right: 15, left: 15, bottom: 30),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(2),
                          child: Consumer<CardModel>(
                            builder: (context, card, child) {
                              return Text(card.cardNumber,
                                  style: const TextStyle(
                                      fontSize: 24, color: Colors.white));
                            },
                          ),
                        )),
                    // THIRD ROW - CARD HOLDER NAME, NUMBER, EXPIRATION DATE
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 0,
                          child: Container(
                            margin: const EdgeInsets.only(left: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Card Holder",
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Consumer<CardModel>(
                                  builder: (context, card, child) {
                                    return Text(card.cardHolderName,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold));
                                  },
                                )
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
                              children: [
                                const Text(
                                  "Expires",
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Consumer<CardModel>(
                                    builder: (context, card, child) {
                                  return Text(
                                      "${card.expirationDateMonth}/${card.expirationDateYear}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold));
                                }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return Container(
                  height: 210,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(randomImg),
                    fit: BoxFit.cover,
                  )),
                  child: Column(
                    children: [
                      Container(
                          padding: EdgeInsets.only(top: 30),
                          child: const SizedBox(
                              width: 300,
                              height: 40,
                              child: DecoratedBox(
                                decoration: BoxDecoration(color: Colors.black),
                              ))),
                      Container(
                        child: const Text(
                          "CVV",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        alignment: Alignment.bottomRight,
                        padding: const EdgeInsets.only(right: 22, top: 10)
                      ),
                      Container(
                        child: Text(card.cardCVV, style: TextStyle(fontSize: 18),),
                        color: Colors.white,
                        width: 300,
                        height: 35,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 5),
                      ),
                      Container(
                        child: Image.asset("images/${card.cardIcon}.png", width: 70,),
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 20, top: 20),
                      )
                    ],
                  ));
            }
          },
        ));
  }
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

  final TextEditingController _myControllerNumber = TextEditingController();
  final TextEditingController _myControllerName = TextEditingController();
  final TextEditingController _myControllerCVV = TextEditingController();

  @override
  void dispose() {
    // Clean up controller when widget is disposed.
    _myControllerNumber.dispose();
    _myControllerName.dispose();
    _myControllerCVV.dispose();
    super.dispose();
  }

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
            // CARD NUMBER - TEXT
            Container(
              child: const Text("Card Number"),
              padding: const EdgeInsets.only(left: 10, top: 25),
            ),
            // CARD NUMBER - INPUT
            Container(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  child: Consumer<CardModel>(builder: (context, card, child) {
                    return TextField(
                        keyboardType: TextInputType.number,
                        maxLength: 16,
                        controller: _myControllerNumber,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          counterText: "",
                        ),
                        onTap: () => card.setCardFront(),
                        onChanged: (text) {
                          card.changeCardNumber(text);
                        });
                  }),
                ),
                width: 400,
                height: 70),
            // CARD NAME - TEXT
            Container(
              child: const Text("Card Name"),
              padding: const EdgeInsets.only(left: 10),
            ),
            // CARD NAME - INPUT
            Container(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 12),
                    child: Consumer<CardModel>(
                      builder: (context, card, child) {
                        return TextField(
                          maxLength: 25,
                          controller: _myControllerName,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            counterText: "",
                          ),
                          onChanged: (text) {
                            card.changeName(text);
                          },
                          onTap: () => card.setCardFront(),
                        );
                      },
                    )),
                width: 400,
                height: 70),
            // EXPIRATION DATE, CVV
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
                                width: 1.0,
                                style: BorderStyle.solid,
                                color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          )),
                          // MONTH DROPDOWN
                          child: Consumer<CardModel>(
                              builder: (context, card, child) {
                            return DropdownButton(
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
                                card.changeExpirationDateMonth(newValue!);
                              },
                              onTap: () => card.setCardFront(),
                            );
                          }),
                        ),
                        const SizedBox(width: 10),
                        Container(
                            width: 100,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: const ShapeDecoration(
                                shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                  color: Colors.grey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            )),
                            // YEAR DROPDOWN
                            child: Consumer<CardModel>(
                                builder: (context, card, child) {
                              return DropdownButton(
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
                                  card.changeExpirationDateYear(newValue!);
                                },
                                onTap: () => card.setCardFront(),
                              );
                            })),
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
                      child: Consumer<CardModel>(
                        builder: (context, card, child) {
                          if (card.cardIcon == "amex"){
                            return TextField(
                              // hide counter text
                                decoration: const InputDecoration(
                                  counterText: "",
                                ),
                                keyboardType: TextInputType.number,
                                maxLength: 4,
                                onTap: () => card.setCardBack(),
                                controller: _myControllerCVV,
                                onChanged: (text) {
                                  card.changeCardCVV(text);
                                });
                          }
                          else{
                            return TextField(
                              // hide counter text
                                decoration: const InputDecoration(
                                  counterText: "",
                                ),
                                keyboardType: TextInputType.number,
                                maxLength: 3,
                                onTap: () => card.setCardBack(),
                                controller: _myControllerCVV,
                                onChanged: (text) {
                                  card.changeCardCVV(text);
                                });
                          }
                        },
                      ),
                      width: 100,
                      height: 40,
                      alignment: Alignment.center,
                      // Rounded border
                      decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 1.0,
                            style: BorderStyle.solid,
                            color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      )),
                    ),
                  ],
                )
              ],
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("SUBMIT"),
                style: ElevatedButton.styleFrom(minimumSize: Size(350, 40)),
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 12),
            )
          ],
        ),
      ),
    );
  }
}
