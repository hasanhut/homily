import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final function;

  NewTransaction({this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: function,
        child: Container(
          height: 75,
          width: 75,
          decoration:
              BoxDecoration(color: Colors.grey[400], shape: BoxShape.circle),
          child: Center(
            child: Text(
              '+',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ));
  }
}
