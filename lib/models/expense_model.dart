import 'package:flutter/material.dart';
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
  Category.travel: Color.fromARGB(255, 154, 255, 154),
  Category.work: Color.fromARGB(255, 158, 158, 255),
  Category.shopping: Color.fromARGB(255, 255, 156, 255),
  Category.medical: Color.fromARGB(255, 253, 197, 13),
  Category.miscellaneous: Color.fromARGB(255, 157, 255, 255),
};

const categoryContainerColors = {
  Category.food: Color.fromARGB(255, 255, 216, 216),
  Category.travel: Color.fromARGB(255, 204, 255, 204),
  Category.work: Color.fromARGB(255, 219, 219, 255),
  Category.shopping: Color.fromARGB(255, 255, 221, 255),
  Category.medical: Color.fromARGB(255, 255, 241, 194),
  Category.miscellaneous: Color.fromARGB(255, 204, 255, 255),
};


class ExpenseModel {
  ExpenseModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  get formattedDate {
    return formatter.format(date);
  }
}
