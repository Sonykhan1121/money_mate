import 'package:flutter/material.dart';
import 'package:money_mate/widgets/add_expense_tab.dart';
import 'package:money_mate/widgets/dottedBorder_box.dart';

import '../../utils/constants/colors.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Expense"),),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: DColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16)
                      ),


                      child: DottedBorderBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt_outlined,),
                            SizedBox(height: 5,),
                            Text('Take Photo',style: TextStyle(color: DColors.primary),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: DColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16)

                      ),
                      child: DottedBorderBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.receipt_long_outlined,),
                            SizedBox(height: 5,),
                            Text('Scan Bill',style: TextStyle(color: DColors.primary),),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10,),
              Text('Type'),
              SizedBox(height: 10,),
              AddExpenseTab(),
            ],
          ),
        ),
      )
    );
  }
}
