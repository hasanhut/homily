import 'package:flutter/material.dart';

class Transaction {
  final String transactionName;
  final String money;
  final String expenseOrIncome;

  Transaction(
      {required this.transactionName,
      required this.money,
      required this.expenseOrIncome});

  static Transaction fromJson(json) => Transaction(
      transactionName: json["transactionName"],
      money: json["money"],
      expenseOrIncome: json["expenseOrIncome"]);
}
