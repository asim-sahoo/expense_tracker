import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/widget/expense_list/expense_list.dart';
import 'package:expense_tracker/widget/new_expense.dart';


class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  bool isScrolled = true;
  bool isDarkMode = false; // Track dark mode state
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

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return NewExpense(onAddExpense: _addExpense, isDarkMode);
        },
        isScrollControlled: true,
        backgroundColor: isDarkMode ? const Color.fromARGB(255, 29, 29, 29) : Colors.white,
        useSafeArea: true);
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
      child: MaterialApp(
        theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                floating: true,
                snap: true,
                title: Text(
                  'ExpenseNest',
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.w900,
                    fontSize: 26,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: const Color.fromARGB(255, 50, 86, 239),
                actions: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isDarkMode = !isDarkMode; // Toggle dark mode
                      });
                    },
                    icon: Icon(
                      isDarkMode ? Icons.wb_sunny_rounded : Icons.nights_stay_rounded,
                    ),
                    color: Colors.white,
                  )
                ],
              )
            ],
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
          ),
          floatingActionButton: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: isScrolled ? 90 : 50,
            height: 50,
            child: FloatingActionButton.extended(
              backgroundColor: isDarkMode ? const Color.fromARGB(255, 69, 103, 255) : Colors.white,

              onPressed: _openAddExpenseOverlay,
              isExtended: isScrolled,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              label: Text(
                'Add',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : const Color.fromARGB(255, 50, 86, 239),
                ),
              ),
              icon: Icon(
                Icons.add,
                  color: isDarkMode ? Colors.white : const Color.fromARGB(255, 50, 86, 239),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.endFloat,
        ),
      ),
    );
  }
}

// void main() {
//   runApp(Expenses());
// }
