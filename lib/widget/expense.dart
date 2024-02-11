import 'package:expense_tracker/widget/expense_list/expense_list.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<ExpenseModel> _registeredExpenses = [
    ExpenseModel(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    ExpenseModel(
      title: 'Hoodie',
      amount: 39.21,
      date: DateTime.now(),
      category: Category.shopping,
    ),
    ExpenseModel(
      title: 'Pizza Hut',
      amount: 75.0,
      date: DateTime.now(),
      category: Category.food,
    ),
    ExpenseModel(
      title: 'Medicine',
      amount: 100.0,
      date: DateTime.now(),
      category: Category.medical,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('The chart'),
          Expanded(
            child: ExpenseList(expenses: _registeredExpenses),
          ),
        ],
      ),
    );
  }
}
