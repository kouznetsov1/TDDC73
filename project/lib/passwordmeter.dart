import 'package:flutter/material.dart';

class PasswordStrengthMeter extends StatefulWidget {
  final int difficulty;
  String? Function(String) onPasswordChange;
  PasswordStrengthMeter({Key? key, required this.difficulty, required this.onPasswordChange}) : super(key: key);

  @override
  _PasswordStrengthMeterState createState() => _PasswordStrengthMeterState();
}

class _PasswordStrengthMeterState extends State<PasswordStrengthMeter> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _criteriasSet = false;
  final List<Map> _criterias = [];
  String _warningText = "Too short";
  Color _warningColor = Colors.grey;


  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  // sets all criterias according to specified difficulty
  setCriterias(diff) {
    if (diff > 0) {
      _criterias.add({"length": false});
    }
    if (diff > 1) {
      _criterias.add({"lower_upper": false});
    }
    if (diff > 2) {
      _criterias.add({"numerical": false});
    }
    if (diff > 3) {
      _criterias.add({"special": false});
    }
  }

  evaluatePassword(password, difficulty) {
    if (!_criteriasSet) {
      setCriterias(difficulty);
      _criteriasSet = true;
    }
    checkLen(password);

    if (difficulty >= 2) {
      checkCase(password);
    }

    if (difficulty >= 3) {
      checkNumber(password);
    }

    if (difficulty >= 4) {
      checkSpecial(password);
    }
  }

  checkLen(password) {
    if (password.length >= 8) {
      _criterias[0]["length"] = true;
    } else {
      _criterias[0]["length"] = false;
    }
  }

  checkCase(password) {
    RegExp regEx = RegExp(r"(?=.*[a-z])(?=.*[A-Z])\w+");

    if (regEx.hasMatch(password)) {
      _criterias[1]["lower_upper"] = true;
    } else {
      _criterias[1]["lower_upper"] = false;
    }
  }

  checkNumber(password) {
    RegExp regEx = RegExp(r"([0-9])+");

    if (regEx.hasMatch(password)) {
      _criterias[2]["numerical"] = true;
    } else {
      _criterias[2]["numerical"] = false;
    }
  }

  checkSpecial(password) {
    RegExp regEx = RegExp(r"[!#¤%&/?=)(]");

    if (regEx.hasMatch(password)) {
      _criterias[3]["special"] = true;
    } else {
      _criterias[3]["special"] = false;
    }
  }

  getTooltip(diff) {
    String tooltip = "";

    if (diff > 0) {
      tooltip += "At least 8 characters needed.";
    }
    if (diff > 1) {
      tooltip += "\nLower and upper case letters needed.";
    }
    if (diff > 2) {
      tooltip += "\nAt least one numerical character.";
    }
    if (diff > 3) {
      tooltip += "\nAt least one special character required.";
    }

    return tooltip;
  }

  List warningText() {
    String text = "";
    int len = _criterias.length; // number of criterias = difficulty
    int hitCrits = 0; // criterias hit
    double percentageHit = 0;
    Color color;

    for (var i = 0; i < len; i++) {
      if (_criterias[i].containsValue(true)) {
        hitCrits++;
      }
    }

    percentageHit = (hitCrits / len) * 100;

    if (percentageHit <= 30 && percentageHit != 0) {
      text = "Weak";
      color = Colors.red;
    } else if (percentageHit > 30 && percentageHit <= 60) {
      text = "Fair";
      color = Colors.yellow;
    } else if (percentageHit > 60 && percentageHit <= 80) {
      text = "Good";
      color = Colors.lightBlueAccent;
    } else if (percentageHit == 0) {
      text = "Too short";
      color = Colors.grey;
    } else {
      text = "Strong";
      color = Colors.green;
    }

    return [text, color];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          child: const Text(
            "Password:",
            style: TextStyle(fontSize: 16),
          ),
          alignment: Alignment.bottomLeft,
        ),
        Container(
          padding: const EdgeInsets.all(3),
          child: TextField(
            controller: _textEditingController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(
              borderSide: BorderSide(width: 3, color: Colors.black),
            )),
            onChanged: (text) {
              evaluatePassword(text, widget.difficulty);
              setState(() {
                _warningText = warningText()[0];
                _warningColor = warningText()[1];
              });
              if (_warningText == "Good" || _warningText == "Strong"){
                widget.onPasswordChange(text);
              }
              else{
                widget.onPasswordChange("");
              }
              /*
              if (_warningText == "Fair" || _warningText == "Good"){
                widget.password = text;
              }
              else {
                widget.password = "";
              }*/
            },
          ),
        ),
        Container(
            padding: const EdgeInsets.all(3),
            child: Row(
              children: [
                Tooltip(
                  message: getTooltip(widget.difficulty),
                  child: const Text(
                    "Password strength: ",
                    style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    _warningText,
                    style: TextStyle(color: _warningColor),
                  ),
                )
              ],
            ))
      ],
    );
  }
}
