import 'package:expense_tracker/widget/expense_list/expense_list.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/widget/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/rendering.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  bool isScrolled = true;

  final List<ExpenseModel> _registeredExpenses = [
    ExpenseModel(
        title: 'Flutter Course',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.work,
        categoryPay: CategoryPay.card),
    ExpenseModel(
        title: 'Hoodie',
        amount: 39.21,
        date: DateTime.now(),
        category: Category.shopping,
        categoryPay: CategoryPay.cash),
    ExpenseModel(
        title: 'Pizza Hut',
        amount: 75.0,
        date: DateTime.now(),
        category: Category.food,
        categoryPay: CategoryPay.cash),
    ExpenseModel(
        title: 'Medicine',
        amount: 100.0,
        date: DateTime.now(),
        category: Category.medical,
        categoryPay: CategoryPay.card),
    ExpenseModel(
        title: 'Flight to Paris',
        amount: 199.99,
        date: DateTime.now(),
        category: Category.travel,
        categoryPay: CategoryPay.card),
    ExpenseModel(
        title: 'New Phone',
        amount: 999.99,
        date: DateTime.now(),
        category: Category.shopping,
        categoryPay: CategoryPay.cash),
    ExpenseModel(
        title: 'Battery Replacement',
        amount: 1999.99,
        date: DateTime.now(),
        category: Category.miscellaneous,
        categoryPay: CategoryPay.card),
    ExpenseModel(
        title: 'Flutter Course',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.work,
        categoryPay: CategoryPay.card),
    ExpenseModel(
        title: 'Hoodie',
        amount: 39.21,
        date: DateTime.now(),
        category: Category.shopping,
        categoryPay: CategoryPay.cash),
    ExpenseModel(
        title: 'Pizza Hut',
        amount: 75.0,
        date: DateTime.now(),
        category: Category.food,
        categoryPay: CategoryPay.cash),
    ExpenseModel(
        title: 'Medicine',
        amount: 100.0,
        date: DateTime.now(),
        category: Category.medical,
        categoryPay: CategoryPay.card),
    ExpenseModel(
        title: 'Flight to Paris',
        amount: 199.99,
        date: DateTime.now(),
        category: Category.travel,
        categoryPay: CategoryPay.card),
    ExpenseModel(
        title: 'New Phone',
        amount: 999.99,
        date: DateTime.now(),
        category: Category.shopping,
        categoryPay: CategoryPay.cash),
    ExpenseModel(
        title: 'Battery Replacement',
        amount: 1999.99,
        date: DateTime.now(),
        category: Category.miscellaneous,
        categoryPay: CategoryPay.card),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(context: context, builder: (ctx) {
      return const NewExpense();
    }, isScrollControlled: true);
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        if (notification.direction == ScrollDirection.forward) {
          setState(() {
            isScrolled = true;
          });
        } else if (notification.direction == ScrollDirection.reverse) {
          setState(() {
            isScrolled = false;
          });
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'ExpenseTracker',
            style: GoogleFonts.lato(
              fontWeight: FontWeight.bold,
              
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.sunny),
            )
          ],
          backgroundColor:
              const Color.fromARGB(118, 213, 180, 251), // Translucent color
          // shape: const RoundedRectangleBorder(
          //   borderRadius: BorderRadius.vertical(
          //     bottom: Radius.circular(20),
          //   ),
          // ),
        ),
        body: Column(
          children: [
            const Text('...'),
            Expanded(
              child: ExpenseList(expenses: _registeredExpenses),
            ),
          ],
        ),
        floatingActionButton: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: isScrolled ? 90 : 50,
          height: 50,
          child: FloatingActionButton.extended(
            onPressed: _openAddExpenseOverlay,
            isExtended: isScrolled,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            label: const Text('Add'),
            icon: const Icon(Icons.add),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
