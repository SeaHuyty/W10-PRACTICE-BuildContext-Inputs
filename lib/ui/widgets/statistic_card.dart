import 'package:flutter/material.dart';
import 'package:assignment/data/expense_data.dart';
import 'package:assignment/model/expense.dart';

class StatisticCard extends StatelessWidget {
  const StatisticCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: ExpenseType.values.map((category) {
          final total = expenseList.totalsByCategory[category]!;
          return Column(
            children: [
              Text(
                "\$${total.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Icon(Expense.iconFor(category), size: 26),
            ],
          );
        }).toList(),
      ),
    );
  }
}