import 'package:expense_tracker/widget/expense_list/expense_list.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/widget/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  bool isScrolled = true;
  final List<ExpenseModel> _registeredExpenses = [];

  @override
  void initState() {
    super.initState();
    _loadExpenses();
  }

  void _loadExpenses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? expenseStrings = prefs.getStringList('expenses');
    if (expenseStrings != null) {
      setState(() {
        _registeredExpenses.clear();
        _registeredExpenses.addAll(
            expenseStrings.map((e) => ExpenseModel.fromJson(jsonDecode(e))));
      });
    }
  }

  void _saveExpenses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> expenseStrings =
        _registeredExpenses.map((e) => jsonEncode(e.toJson())).toList();
    prefs.setStringList('expenses', expenseStrings);
  }

  void _addExpense(ExpenseModel expense) {
    setState(() {
      _registeredExpenses.add(expense);
      _saveExpenses();
    });
  }

  void _removeExpense(ExpenseModel expense) {
    setState(() {
      _registeredExpenses.remove(expense);
      _saveExpenses();
    });
  }
  // final List<ExpenseModel> _registeredExpenses = [
  //   ExpenseModel(
  //       title: 'Flutter Course',
  //       amount: 19.99,
  //       date: DateTime.now(),
  //       category: Category.work,
  //       categoryPay: CategoryPay.card),
  //   ExpenseModel(
  //       title: 'Hoodie',
  //       amount: 39.21,
  //       date: DateTime.now(),
  //       category: Category.shopping,
  //       categoryPay: CategoryPay.cash),
  //   ExpenseModel(
  //       title: 'Pizza Hut',
  //       amount: 75.0,
  //       date: DateTime.now(),
  //       category: Category.food,
  //       categoryPay: CategoryPay.cash),
  //   ExpenseModel(
  //       title: 'Medicine',
  //       amount: 100.0,
  //       date: DateTime.now(),
  //       category: Category.medical,
  //       categoryPay: CategoryPay.card),
  //   ExpenseModel(
  //       title: 'Flight to Paris',
  //       amount: 199.99,
  //       date: DateTime.now(),
  //       category: Category.travel,
  //       categoryPay: CategoryPay.card),
  //   ExpenseModel(
  //       title: 'New Phone',
  //       amount: 999.99,
  //       date: DateTime.now(),
  //       category: Category.shopping,
  //       categoryPay: CategoryPay.cash),
  //   ExpenseModel(
  //       title: 'Battery Replacement',
  //       amount: 1999.99,
  //       date: DateTime.now(),
  //       category: Category.miscellaneous,
  //       categoryPay: CategoryPay.card),
  // ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return NewExpense(onAddExpense: _addExpense);
        },
        isScrollControlled: true,
        backgroundColor: Colors.white,
        useSafeArea: true);
  }

  // void _addExpense(ExpenseModel expense) {
  //   setState(() {
  //     _registeredExpenses.add(expense);
  //   });
  // }

  // void _removeExpense(ExpenseModel expense) {
  //   setState(() {
  //     _registeredExpenses.remove(expense);
  //   });
  // }

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
              fontWeight: FontWeight.w900,
              fontSize: 25,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.sunny),
              color: Colors.white,
            )
          ],
          backgroundColor: const Color.fromARGB(255, 69, 100, 234),
        ),
        body: Column(
          children: [
            Expanded(
              child: ExpenseList(
                expenses: _registeredExpenses,
                onRemoveExpense: _removeExpense,
              ),
            ),
          ],
        ),
        floatingActionButton: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: isScrolled ? 90 : 50,
          height: 50,
          child: FloatingActionButton.extended(
            backgroundColor: const Color.fromARGB(255, 229, 232, 249),
            onPressed: _openAddExpenseOverlay,
            isExtended: isScrolled,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            label: const Text(
              'Add',
              style: TextStyle(
                color: Color.fromARGB(255, 50, 86, 239),
              ),
            ),
            icon: const Icon(
              Icons.add,
              color: Color.fromARGB(255, 50, 86, 239),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}

