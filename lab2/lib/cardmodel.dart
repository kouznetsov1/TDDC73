import 'package:flutter/cupertino.dart';

class CardModel extends ChangeNotifier{
  String _expirationDateMonth = "";
  String _expirationDateYear = "";
  String _cardNumber = "";
  String _cardCVV = "";
  String _cardHolderName = "";
  bool _frontCard = false;

  String get cardNumber => _cardNumber;
  String get expirationDateMonth => _expirationDateMonth;
  String get expirationDateYear => _expirationDateYear;
  String get cardCVV => _cardCVV;
  bool get frontCard => _frontCard;
  String get cardHolderName => _cardHolderName;


  void changeCardNumber(String cardNumber){
    _cardNumber = cardNumber;
    notifyListeners();
  }

  void changeName(String name){
    _cardHolderName = name;
    notifyListeners();
  }

  void changeCardCVV(String cardCVV){
    _cardCVV = cardCVV;
    notifyListeners();
  }

  void changeExpirationDateMonth(String month){
    _expirationDateMonth = month;
    notifyListeners();
  }

  void changeExpirationDateYear(String year){
    _expirationDateYear = year;
    notifyListeners();
  }

  void setCardFront(){
    _frontCard = true;
    notifyListeners();
  }

  void setCardBack(){
    _frontCard = false;
    notifyListeners();
  }
}