import 'package:flutter/material.dart';
import 'package:expense_tracker/widget/expense.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Expenses()
    ),
  );
}
