import 'dart:math';

import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  ExpenseItem(this.expense, {super.key}) : containerColor = categoryContainerColors[expense.category]!,
        icon = categoryIcons[expense.category]!,
        iconColor = categoryIconColors[expense.category]!;

  final ExpenseModel expense;
  final Color containerColor;
  final IconData icon;
  final Color iconColor;
  
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color:containerColor,
                      child: Icon(
                        icon,
                        color: iconColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(expense.title),
                      const SizedBox(height: 3),
                      Text(
                        expense.category.name.toString(),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('\u{20B9} ${expense.amount.toStringAsFixed(2)}'),
                      const SizedBox(height: 5),
                      Text(
                        expense.formattedDate,
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
