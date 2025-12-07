import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseTile extends StatelessWidget {
  final String title;
  final double amount;
  final DateTime date;
  final IconData icon;

  const ExpenseTile({
    super.key,
    required this.title,
    required this.amount,
    required this.date,
    required this.icon,
  });

  String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("\$$amount"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 22),
            SizedBox(width: 10),
            Text(formatDate(date), style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
