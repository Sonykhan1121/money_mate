import 'package:flutter/material.dart';
import 'package:money_mate/widgets/add_expense_tab.dart';
import 'package:money_mate/widgets/dottedBorder_box.dart';
import 'package:provider/provider.dart';

import '../../models/catergory.dart';
import '../../providers/transactions_provider.dart';
import '../../utils/constants/colors.dart';
import '../../widgets/datePickerfield.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> with SingleTickerProviderStateMixin {
  final TextEditingController amountTextController = TextEditingController();
  final TextEditingController descriptionTextController = TextEditingController();
  final _fromKey = GlobalKey<FormState>();
  CategoryModel? _selectedValue;
  int _selectedIndex = 0;




  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionsProvider>(builder: (context,tProvider,child){
      return Scaffold(
        appBar: AppBar(title: Text("Add Expense"),),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
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
                AddExpenseTab(tabIndex: (index){

                  _selectedIndex = index;

                },),
                Form(
                  key: _fromKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Text('Amount'),
                      SizedBox(height: 10,),
                      TextFormField(
                        controller: amountTextController,
                        decoration:  InputDecoration(
                          hintText: 'Enter amount',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter amount';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10,),
                      Text('Category'),
                      SizedBox(height: 10,),
                      DropdownButtonFormField<CategoryModel>(
                        decoration: InputDecoration(
                          hintText: 'Select an option',
                        ),
                        value: _selectedValue,

                        items: tProvider.demoCategories
                            .map((option) => DropdownMenuItem(
                          value: option,
                          child: Text(option.name),
                        ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select an option';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10,),
                      Text('Description'),
                      SizedBox(height: 10,),

                      TextFormField(
                        controller: descriptionTextController,
                        decoration:  InputDecoration(
                          hintText: 'Enter description',
                        ),
                        maxLines: 4,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter description';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10,),
                      Text('Date'),
                      SizedBox(height: 10,),
                      DatePickerField(),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),


          child: ElevatedButton(
              onPressed: () {
                if (_fromKey.currentState!.validate()) {
                  if(_selectedIndex==0)
                  {

                  }
                  else
                  {

                  }

                }
                else
                {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill all the fields')));
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                backgroundColor: DColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text('Submit',style: TextStyle(fontSize: 14,color: DColors.fWhite,fontWeight: FontWeight.bold),)),
        ),
      );
    });
  }
}
