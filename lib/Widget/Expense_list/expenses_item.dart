import 'package:expenses_tracker/Model/expense.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';

class ExpensesItem extends StatelessWidget{
  const ExpensesItem(this.expense , {super.key});

  final Expense expense;

  @override
  Widget build (BuildContext context){
    return  Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Text(expense.title , style: Theme.of(context).textTheme.titleLarge ),
            const SizedBox(height: 5,),
            Row(
              children: [
                Text( 'Rs${expense.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(width: 7,),
                    Text(expense.FormattedDate)
                  ],
                )
              ],
            )
          ],
        ) ,
      ),
    );
  }
}