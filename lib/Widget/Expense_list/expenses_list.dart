import 'package:expenses_tracker/Model/expense.dart';
import 'package:expenses_tracker/Widget/Expense_list/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList  extends StatelessWidget{
  const ExpensesList({super.key , required this.expenses, required this.onRemovedExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemovedExpense; 

  @override
  Widget build(BuildContext context) {
    return ListView.builder( 
      itemCount: expenses.length, 
      itemBuilder: (ctx,index) => Dismissible(
        key: ValueKey(expenses[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75) ,
          margin: Theme.of(context).cardTheme.margin ,
        ), 
        onDismissed: (direction) {
          onRemovedExpense(expenses[index]);
          },
        child: ExpensesItem(expenses[index]),
        ) ,
      );
  }
}