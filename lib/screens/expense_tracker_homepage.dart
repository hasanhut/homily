import 'package:flutter/material.dart';
import 'package:homily/screens/top_card_expense_tracker.dart';
import '../model/transaction.dart';
import 'new_transaction.dart';

class ExpenseTrackerHomePage extends StatefulWidget {
  const ExpenseTrackerHomePage({Key? key}) : super(key: key);

  @override
  _ExpenseTrackerHomePage createState() => _ExpenseTrackerHomePage();
}

class _ExpenseTrackerHomePage extends State<ExpenseTrackerHomePage> {
  List<Transaction> transactions = getTransactions();
  final _textcontrollerAMOUNT = TextEditingController();
  final _textcontrollerITEM = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isIncome = false;

  // enter the new transaction into the spreadsheet
  /*void _enterTransaction() {
    GoogleSheetsApi.insert(
      _textcontrollerITEM.text,
      _textcontrollerAMOUNT.text,
      _isIncome,
    );
    setState(() {});
  }*/

  void _newTransaction() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return AlertDialog(
                title: Text('N E W  T R A N S A C T I O N'),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Expense'),
                          Switch(
                            value: _isIncome,
                            onChanged: (newValue) {
                              setState(() {
                                _isIncome = newValue;
                              });
                            },
                          ),
                          Text('Income'),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Amount?',
                                ),
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Enter an amount';
                                  }
                                  return null;
                                },
                                controller: _textcontrollerAMOUNT,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'For what ?',
                              ),
                              controller: _textcontrollerITEM,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  MaterialButton(
                    color: Colors.grey[600],
                    child:
                        Text('Cancel', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  MaterialButton(
                    color: Colors.grey[600],
                    child: Text('Enter', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        //_enterTransaction();
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              );
            },
          );
        });
  }

  static List<Transaction> getTransactions() {
    const data = [
      {"transactionName": "Okul", "money": "500", "expenseOrIncome": "expense"},
      {"transactionName": "İş", "money": "200", "expenseOrIncome": "Income"},
      {
        "transactionName": "Eğlence",
        "money": "600",
        "expenseOrIncome": "Expense"
      },
      {
        "transactionName": "Yemek",
        "money": "540",
        "expenseOrIncome": "expense"
      },
      {"transactionName": "Oyun", "money": "200", "expenseOrIncome": "Income"}
    ];

    return data.map<Transaction>(Transaction.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: Column(
          children: [
            TopNewCard(balance: '20.000', income: '200', expense: '100'),
            Expanded(
              child: Container(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Expanded(child: buildTransactions(transactions)),
                    ],
                  ),
                ),
              ),
            ),
            NewTransaction(
              function: _newTransaction,
            ),
          ],
        ));
  }

  Widget buildTransactions(List<Transaction> transactions) => ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: EdgeInsets.all(15),
                color: Colors.grey[100],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey[500]),
                          child: Center(
                            child: Icon(
                              Icons.attach_money_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(transaction.transactionName,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            )),
                      ],
                    ),
                    Text(
                      (transaction.expenseOrIncome == 'expense' ? '-' : '+') +
                          '\$' +
                          transaction.money,
                      style: TextStyle(
                        //fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: transaction.expenseOrIncome == 'expense'
                            ? Colors.red
                            : Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
}
