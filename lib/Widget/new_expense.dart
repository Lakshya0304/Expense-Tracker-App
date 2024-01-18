import 'package:expenses_tracker/Model/expense.dart';

import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget{
  const NewExpense({super.key , required this.onAddExpense});

  final void Function(Expense expense) onAddExpense; 
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  } 
}

class _NewExpenseState extends State<NewExpense>{
  
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  Category? _selecteCategory ;
  DateTime? _selectedDate;

  void _datePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  

  void _submitExpenses() {

    final enteredAmount = double.tryParse(_amountController.text);
    final amountisInvalid = enteredAmount == null || enteredAmount <=0 ;

    if (
      _titleController.text.trim().isEmpty ||
       amountisInvalid ||
       _selectedDate == null ||
       _selecteCategory == null
      ) {
      showDialog(
        context: context, 
        builder: (ctx) => AlertDialog(
        title: const Text('Invalid input') , 
        content: const Text('Make sure you fill all the block porperly'),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(ctx);
          }, 
          child: const Text('Okay'))
        ],
        ),
       );
       return;
     }
     widget.onAddExpense(
      Expense(
        title: _titleController.text ,
        amount: enteredAmount ,
        date: _selectedDate! ,
        category: _selecteCategory! 
        ),
      );
    Navigator.pop(context);  
  }
 
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  /*
  var _enteredTitle = '';
  void _saveTitleInput (String inputValue){
    _enteredTitle = inputValue;
  }
  */



  @override
   Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.fromLTRB(15,50,15,15) ,
      child: Column(
        children:  [
          TextField(
            //onChanged: _saveTitleInput ,
            controller: _titleController,
            maxLength: 50,
            //keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              label: Text('Title')
              ),
          ),
          const SizedBox(height: 10,),
          
          Row(
            children: [
            Expanded (child: TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
              prefixText: 'Rs',
              label: Text('Amount')
            ),
           ),
          ),

            const SizedBox(width: 15,),

            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(_selectedDate==null ? 'No Date Selected' : formatter.format(_selectedDate!)),
                  IconButton(
                    onPressed: _datePicker, 
                    icon: const Icon(Icons.calendar_month)
                  )
                ],
              )
            
            )
            ],
          ),
          
          const SizedBox(
            height: 10,
          ),
 
          Row(
            children: [
              DropdownButton(
                value: _selecteCategory,
                items: Category.values.map( (category)  => DropdownMenuItem(
                  value : category,
                  child: Text(category.name.toUpperCase()), ) ,
                ).toList(),
                onChanged: (value){
                   setState(() {
                     _selecteCategory =  value;
                   });
                }   
              ),

              const Spacer(),

              TextButton(
                onPressed:  (){
                  Navigator.pop(context);
                }, 
                child: const Text('Cancel')
                ),

              const  SizedBox(width: 5,),

              ElevatedButton(
                onPressed: _submitExpenses, 
                child: const Text('Save Expense')),

               
            ],
          )
        ],
      ),
      );
   }
}