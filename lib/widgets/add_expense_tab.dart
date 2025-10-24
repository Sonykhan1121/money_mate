import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:money_mate/models/catergory.dart';
import 'package:money_mate/providers/transactions_provider.dart';
import 'package:money_mate/widgets/datePickerfield.dart';
import 'package:provider/provider.dart';
import '../utils/constants/colors.dart';

class AddExpenseTab extends StatefulWidget {
  const AddExpenseTab({super.key});

  @override
  State<AddExpenseTab> createState() => _AddExpenseTabState();
}

class _AddExpenseTabState extends State<AddExpenseTab> {
  final TextEditingController amountTextController = TextEditingController();
  final TextEditingController descriptionTextController = TextEditingController();
  final _fromKey = GlobalKey<FormState>();
  CategoryModel? _selectedValue;

  @override
  Widget build(BuildContext context) {


    return Consumer<TransactionsProvider>(
      builder: (context, tProvider, child) {
        return DefaultTabController(
          length: 2,
          child: Column(

            children: [
              // Tab bar container
              ClipRRect(
                borderRadius:  BorderRadius.circular(16),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: DColors.primary.withOpacity(0.1),
                  ),
                  child:  TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      color: DColors.primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: DColors.grey,
                    tabs: [
                      Tab(text: 'Income'),
                      Tab(text: 'Expense'),
                    ],
                  ),
                ),
              ),

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

              // Tab bar view
              // TabBarView(
              //   children: [
              //     Center(child: Text('Income Page')),
              //     Center(child: Text('Expense Page')),
              //   ],
              // ),
            ],
          ),
        );
      }
    );
  }
}
