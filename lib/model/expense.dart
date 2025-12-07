import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

enum ExpenseType { food, travel, leisure, work }

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final ExpenseType category;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  IconData get icon {
    switch (category) {
      case ExpenseType.food:
        return Icons.fastfood;
      case ExpenseType.travel:
        return Icons.flight;
      case ExpenseType.leisure:
        return Icons.movie;
      case ExpenseType.work:
        return Icons.work;
    }
  }
}

class ExpenseList {
  final List<Expense> expenseItem;

  ExpenseList({required this.expenseItem});

  void add(InputDecoration inputDecoration) {}
}
