import 'package:flutter/material.dart';
import 'package:expense_tracker/widget/expense.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const Expenses()
      
    ),
  );
}
