import 'dart:math';

import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';

class ExpenseItem extends StatelessWidget {
  ExpenseItem(this.expense, {super.key})
      : containerColor = categoryContainerColors[expense.category]!,
        icon = categoryIcons[expense.category]!,
        iconColor = categoryIconColors[expense.category]!,
        iconName = categoryNames[expense.category]!,
        payIcon = categoryPayIcons[expense.categoryPay]!,
        payIconColor = categoryPayIconsColors[expense.categoryPay]!;

  final ExpenseModel expense;
  final Color containerColor;
  final IconData icon;
  final Color iconColor;
  final String iconName;
  final IconData payIcon;
  final Color payIconColor;

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
                      padding: const EdgeInsets.all(8),
                      color: containerColor,
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
                      Text(
                        expense.title,
                        style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4,),
                      Text(
                        expense.formattedDate,
                        style: GoogleFonts.lato(
                          fontSize: 11,
                          fontWeight: FontWeight.w300,
                        
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('- \u{20B9}${expense.amount.toStringAsFixed(2)}',
                      style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),),
                      const SizedBox(height: 1),
                      Icon(
              
                        payIcon,
                        color: payIconColor,
                        size: 18,
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
