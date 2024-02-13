import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/widget/expense_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({
    super.key,
    required this.expenses,
  });

  final List<ExpenseModel> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => ExpenseItem(expenses[index]),
      separatorBuilder: (ctx, index) => 
      const Divider(
        height: 10,
        thickness: 0.14,
        color: Colors.grey,
        endIndent: 46,
        indent: 46,
      ),
      
    );
  }
}
