import 'package:assignment/model/expense.dart';

ExpenseList expenseList = ExpenseList(
  expenseItem: [
    Expense(
      title: "Lunch",
      amount: 15.99,
      date: DateTime.now(),
      category: ExpenseType.food,
    ),
    Expense(
      title: "Taxi",
      amount: 25.50,
      date: DateTime.now(),
      category: ExpenseType.travel,
    ),
    Expense(
      title: "Movie",
      amount: 19.9,
      date: DateTime.now(),
      category: ExpenseType.leisure,
    ),
    Expense(
      title: "Office Supplies",
      amount: 45.00,
      date: DateTime.now(),
      category: ExpenseType.work,
    ),
  ],
);
