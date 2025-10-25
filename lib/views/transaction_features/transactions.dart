import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_mate/providers/transactions_provider.dart';
import 'package:provider/provider.dart';

import '../../models/transaction.dart';
import '../../models/transactionType.dart';
import '../../utils/constants/colors.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  final _scrollController = ScrollController();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionsProvider>(
      builder: (BuildContext context, TransactionsProvider tProvider, Widget? child) {

        final Map<String, List<Transaction>> grouped = tProvider.listToMap(tProvider.mockTransactions);


        return SafeArea(
          child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Search transaction...',
                              prefixIcon: Icon(Icons.search),
                              suffixIcon: IconButton(onPressed: (){

                              }, icon: Icon(Icons.clear),),
                            ),

                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: tProvider.filters.map((filter) {
                          bool isSelected = tProvider.selectedFilter == filter;
                          return InkWell(
                            onTap: () {
                              tProvider.setFilter(filter);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),

                                  border: Border.all(
                                    color:DColors.grey.withOpacity(0.5),
                                    width: 1,
                                  ),
                                ),
                                child: Chip(

                                  label: Text(filter,style: TextStyle(color: isSelected?Colors.white:DColors.grey),),
                                  backgroundColor: isSelected ? DColors.primary : Colors.transparent,


                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    SizedBox(height: 10,),
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: grouped.keys.length,
                    itemBuilder: (context, index) {
                      final dateKey = grouped.keys.elementAt(index);
                      final items = grouped[dateKey]!;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Date header
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            child: Text(
                              dateKey,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          // Transactions under date
                          ...items.map((t) => Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 4, vertical: 2),
                            child: ListTile(
                              title: Text(t.title),
                              subtitle: Text(
                                  DateFormat('hh:mm a').format(t.date)),
                              trailing: Text(
                                '৳${t.amount.toStringAsFixed(2)}',
                                style: TextStyle(
                                    color: t.type ==
                                        TransactionType.income
                                        ? Colors.green
                                        : Colors.red),
                              ),
                            ),
                          )),
                        ],
                      );
                    },
                  ),
                ),
                  ],
                ),
              )
          ),
        );

      },

    );
  }

}
