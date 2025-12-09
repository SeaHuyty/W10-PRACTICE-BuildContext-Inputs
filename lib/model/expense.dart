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

  static IconData iconFor(ExpenseType category) {
    switch (category) {
      case ExpenseType.leisure:
        return Icons.movie;
      case ExpenseType.work:
        return Icons.work;
      case ExpenseType.travel:
        return Icons.flight;
      case ExpenseType.food:
        return Icons.fastfood;
    }
  }
}

class ExpenseList {
  final List<Expense> expenseItem;

  ExpenseList({required this.expenseItem});

  Map<ExpenseType, double> get totalsByCategory {
    final totals = {for (var type in ExpenseType.values) type: 0.0};

    for (var expense in expenseItem) {
      totals[expense.category] = totals[expense.category]! + expense.amount;
    }

    return totals;
  }
}