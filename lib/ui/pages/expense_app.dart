import 'package:flutter/material.dart';
import 'package:assignment/data/expense_data.dart';
import 'package:assignment/model/expense.dart';
import 'package:assignment/ui/pages/expense_form.dart';
import 'package:assignment/ui/widgets/expense_tile.dart';

class ExpenseApp extends StatefulWidget {
  const ExpenseApp({super.key});

  @override
  State<ExpenseApp> createState() => _ExpenseAppState();
}

class _ExpenseAppState extends State<ExpenseApp> {
  ExpenseType? selectedFilter;

  @override
  void initState() {
    super.initState();
  }

  void onAddExpense() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ExpenseForm(
          onCreate: (expense) {
            setState(() {
              expenseList.expenseItem.add(expense);
            });
          },
        );
      },
    );
  }

  void removeFilter() {
    setState(() {
      selectedFilter = null;
    });
  }

  List<Expense> getFilteredExpenses() {
    if (selectedFilter == null) {
      return expenseList.expenseItem;
    }

    return expenseList.expenseItem
        .where((expense) => expense.category == selectedFilter)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredExpenses = getFilteredExpenses();

    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Navid Expense App",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: onAddExpense,
              icon: Icon(Icons.add, size: 22),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: DropdownButton<ExpenseType>(
                        value: selectedFilter,
                        onChanged: (ExpenseType? newValue) {
                          setState(() {
                            selectedFilter = newValue;
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
                if (selectedFilter != null) ...[
                  SizedBox(width: 12),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: Icon(Icons.close, color: Colors.redAccent),
                      tooltip: 'Remove filter',
                      onPressed: removeFilter,
                    ),
                  ),
                ],
              ],
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: filteredExpenses.length,
                itemBuilder: (context, index) {
                  final items = filteredExpenses[index];
                  return Dismissible(
                    key: Key(items.id),
                    direction: DismissDirection.horizontal,
                    onDismissed: (direction) {
                      setState(() {
                        expenseList.expenseItem.removeAt(index);
                      });
                    },
                    child: Column(
                      children: [
                        ExpenseTile(
                          title: items.title,
                          amount: items.amount,
                          date: items.date,
                          icon: items.icon,
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
