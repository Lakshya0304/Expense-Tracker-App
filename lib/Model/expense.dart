//import 'package:flutter/foundation.dart';
import 'package:expenses_tracker/Widget/expenses.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight,
  Category.leisure: Icons.movie,
  Category.work: Icons.work
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  get FormattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expense});

  ExpenseBucket.forCategory(List<Expense> allExpense, this.category)
      : expense = allExpense
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expense;

  double get TotalExpense {
    double sum = 0;

    for (final expenses in expense) {
      sum += expenses.amount;
    }
    return sum;
  }
}
