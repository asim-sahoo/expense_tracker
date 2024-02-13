import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat('dd MMM, yyyy');

const uuid = Uuid();

enum Category {
  food,
  travel,
  work,
  shopping,
  medical,
  miscellaneous,
}

enum CategoryPay {
  cash,
  card,
}

const categoryPayIcons = {
  CategoryPay.cash: Icons.money,
  CategoryPay.card: Icons.credit_card,
};

const categoryPayIconsColors = {
  CategoryPay.cash: Color.fromARGB(255, 10, 219, 69),
  CategoryPay.card: Color.fromARGB(255, 0, 179, 255),
};

const categoryIcons = {
  Category.food: Icons.fastfood,
  Category.travel: Icons.flight,
  Category.work: Icons.work,
  Category.shopping: Icons.shopping_cart,
  Category.medical: Icons.local_hospital,
  Category.miscellaneous: Icons.category,
};

const categoryIconColors = {
  Category.food: Color.fromARGB(255, 250, 153, 153),
  Category.travel: Color.fromARGB(255, 139, 255, 139),
  Category.work: Color.fromARGB(255, 158, 158, 255),
  Category.shopping: Color.fromARGB(255, 255, 136, 255),
  Category.medical: Color.fromARGB(255, 253, 197, 13),
  Category.miscellaneous: Color.fromARGB(255, 37, 255, 255),
};

const categoryNames = {
  Category.food: 'Food',
  Category.travel: 'Travel',
  Category.work: 'Work',
  Category.shopping: 'Shopping',
  Category.medical: 'Medical',
  Category.miscellaneous: 'Miscellaneous',
};

const categoryContainerColors = {
  Category.food: Color.fromARGB(255, 255, 216, 216),
  Category.travel: Color.fromARGB(255, 221, 255, 221),
  Category.work: Color.fromARGB(255, 230, 230, 255),
  Category.shopping: Color.fromARGB(255, 255, 227, 255),
  Category.medical: Color.fromARGB(255, 255, 241, 194),
  Category.miscellaneous: Color.fromARGB(255, 218, 255, 255),
};


class ExpenseModel {
  ExpenseModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    required this.categoryPay,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
  final CategoryPay categoryPay;

  get formattedDate {
    return formatter.format(date);
  }
}
