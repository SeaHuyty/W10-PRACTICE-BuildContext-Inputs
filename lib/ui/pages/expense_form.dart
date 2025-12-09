import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:assignment/model/expense.dart';
import 'package:intl/intl.dart';
import 'package:assignment/ui/widgets/app_button.dart';

class ExpenseForm extends StatefulWidget {
  final void Function(Expense expense) onCreate;
  const ExpenseForm({super.key, required this.onCreate});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final textController = TextEditingController();
  final amountController = TextEditingController();
  late String value = '';
  late ExpenseType category = ExpenseType.food;
  DateTime? selectedDate;

  String dateLabel() {
    final d = selectedDate;
    return d == null ? 'No date selected' : DateFormat('dd/MM/yyyy').format(d);
  }

  void onDatePick() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.utc(2020, 1, 1),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Invalid Input"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text("Okay"),
          ),
        ],
      ),
    );
  }

  void onCreate() {
    final titleText = textController.text;
    final amountText = amountController.text;

    if (titleText.isEmpty) {
      showErrorDialog("Title cannot be empty.");
      return;
    }

    if (amountText.isEmpty) {
      showErrorDialog("Amount cannot be empty.");
      return;
    }

    Expense expense = Expense(
      title: textController.text,
      amount: double.parse(amountController.text),
      date: selectedDate ?? DateTime.now(),
      category: category,
    );
    widget.onCreate(expense);
    Navigator.of(context).pop();
  }

  void closeForm() {
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    textController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          spacing: 20,
          children: [
            TextField(
              decoration: InputDecoration(label: Text("Title")),
              controller: textController,
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(label: Text("Amount")),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: DropdownButton<ExpenseType>(
                        value: category,
                        onChanged: (ExpenseType? newValue) {
                          setState(() {
                            category = newValue!;
                          });
                        },
                        items: ExpenseType.values.map((ExpenseType category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Text(
                              category.name.toUpperCase(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          );
                        }).toList(),
                        underline: SizedBox(),
                        isExpanded: true,
                        hint: Text(
                          "Filter",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.calendar_month),
                        onPressed: onDatePick,
                      ),
                      Text(dateLabel()),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 40,
              children: [
                AppButton(onPressed: closeForm, label: "Close"),
                AppButton(onPressed: onCreate, label: "Create"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}