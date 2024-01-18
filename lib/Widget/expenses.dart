import 'package:expenses_tracker/Model/expense.dart';
import 'package:expenses_tracker/Widget/Expense_list/expenses_list.dart';
import 'package:expenses_tracker/Widget/chart/chart.dart';
import 'package:expenses_tracker/Widget/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {

  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {

  final List<Expense> _registerExpenses = [
    Expense(
      title: 'Flutter Course', 
      amount: 19.99 , 
      date:DateTime.now(), 
      category: Category.work
      ),
    Expense(
        title: 'Movie',
        amount: 11.99,
        date: DateTime.now(),
        category: Category.leisure
        ),
  ];

  void _openAddExpenseOverlay(){
    showModalBottomSheet(
      isScrollControlled: true,
      context: context, 
      builder: (ctx)  => NewExpense( onAddExpense:_addExpenses )
    );
  }

  void _addExpenses (Expense expense){
    setState(() {
      _registerExpenses.add(expense);      
    });
  }

  void _removeExpense(Expense expense){
    final expenseIndex = _registerExpenses.indexOf(expense);
    setState(() {
      _registerExpenses.remove(expense); 
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
         duration: const Duration(seconds: 3) ,
         content: const Text ('Expense Deleted'),
         action: SnackBarAction(
          label: 'Undo',
          onPressed: (){
            setState(() {
              _registerExpenses.insert(expenseIndex, expense);
            });
         }),
         ));
  }
  
  @override
   Widget build(BuildContext context) {
    Widget mainContent = const Center( child: Text('NO EXPENSE FOUND , TRY ADDING SOME!'),);

    if(_registerExpenses.isNotEmpty){
       mainContent = ExpensesList(
        expenses:_registerExpenses ,
        onRemovedExpense: _removeExpense,);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('EXPENSE TRACKER'),
        actions: [
          IconButton(onPressed: _openAddExpenseOverlay , icon: const Icon(Icons.add))
        ]
        ),
      body: Column(
        children: [
           Chart(expenses: _registerExpenses),
          Expanded(child: mainContent ),
          //Chart(expenses: _registerExpenses),
      ]
    ),
    );
  }
}