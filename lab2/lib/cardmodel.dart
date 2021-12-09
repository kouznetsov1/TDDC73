import 'dart:ffi';

import 'package:flutter/cupertino.dart';

class CardModel extends ChangeNotifier {
  String _expirationDateMonth = "";
  String _expirationDateYear = "";
  String _cardNumber = "#### #### #### ####";
  String _cardCVV = "";
  String _cardHolderName = "";
  bool _frontCard = false;
  String _cardIcon = "visa";

  String get cardNumber => _cardNumber;
  String get expirationDateMonth => _expirationDateMonth;
  String get expirationDateYear => _expirationDateYear;
  String get cardCVV => _cardCVV;
  bool get frontCard => _frontCard;
  String get cardHolderName => _cardHolderName;
  String get cardIcon => _cardIcon;

  void changeCardNumber(String cardNumber) {
    if (cardNumber.isNotEmpty) {
      if (cardNumber[0] == "4") {
        _cardIcon = "visa";
      } else if (cardNumber[0] == "6") {
        _cardIcon = "discover";
      } else if (cardNumber[0] == "5") {
        _cardIcon = "mastercard";
      }
    }
    else{
      _cardNumber = "#### #### #### ####";
      _cardIcon = "visa";
    }

    if (cardNumber.length >= 2) {
      if (cardNumber.substring(0, 2) == "34" ||
          cardNumber.substring(0, 2) == "37") {
        _cardIcon = "amex";
      } else if (cardNumber.substring(0, 2) == "36") {
        _cardIcon = "dinersclub";
      } else if (cardNumber.substring(0, 2) == "35") {
        _cardIcon = "jcb";
      } else if (cardNumber.substring(0, 2) == "62") {
        _cardIcon = "unionpay";
      }
    }

    if (cardNumber.isNotEmpty){
      _cardNumber = fixMasking(cardNumber);
    }

    notifyListeners();
  }

  String fixMasking(cardNumber){
    int _length = cardNumber.length;
    String _fullNumber;
    String _maskedNumber;
    if (_cardIcon == "amex"){
      _fullNumber = "###############";
      _fullNumber = cardNumber + _fullNumber.substring(_length-1, _fullNumber.length);
      if (_length > 3 && _length < 11){
        _fullNumber = _fullNumber.replaceRange(4, _length, "*" * (_length-4));
      }
      if (_length >= 11){
        _fullNumber = _fullNumber.replaceRange(4, 10, "******");
      }
      // add spaces
      _maskedNumber = _fullNumber.substring(0,4) + " " + _fullNumber.substring(4,10) + " " + _fullNumber.substring(10, 14);
    }
    else {
      _fullNumber = "################";
      _fullNumber = cardNumber + _fullNumber.substring(_length-1, _fullNumber.length);
      if (_length > 3 && _length < 13){
        _fullNumber = _fullNumber.replaceRange(4, _length, "*" * (_length-4));
      }
      if (_length >= 13){
        _fullNumber = _fullNumber.replaceRange(4, 12, "********");
      }
      // add spaces
      _maskedNumber = _fullNumber.substring(0, 4) + " " + _fullNumber.substring(4, 8) + " " + _fullNumber.substring(8, 12) + " " + _fullNumber.substring(12, 16);
    }

    return _maskedNumber;
  }

  void changeName(String name) {
    _cardHolderName = name.toUpperCase();
    notifyListeners();
  }

  void changeCardCVV(String cardCVV) {
    _cardCVV = cardCVV;
    notifyListeners();
  }

  void changeExpirationDateMonth(String month) {
    _expirationDateMonth = month;
    notifyListeners();
  }

  void changeExpirationDateYear(String year) {
    _expirationDateYear = year;
    notifyListeners();
  }

  void setCardFront() {
    _frontCard = true;
    notifyListeners();
  }

  void setCardBack() {
    _frontCard = false;
    notifyListeners();
  }
}
