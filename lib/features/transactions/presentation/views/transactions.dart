import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/transaction_model.dart';
import '../../../../core/utils/constants/colors.dart';
import 'package:money_mate/core/routing/route_names.dart';
import '../../../home/presentation/widgets/transaction_tile.dart';
import 'package:money_mate/features/transactions/presentation/viewmodels/transactions_provider.dart';


class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionsProvider>(
      builder: (BuildContext context, TransactionsProvider tProvider, Widget? child) {

        final Map<String, List<TransactionModel>> grouped = tProvider.listToMap(context,tProvider.allTransactions);


        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text('All Transactions'),
            ),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    // SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _searchController,
                            onChanged: (value)=>tProvider.setSearchQuery(value),
                            decoration: InputDecoration(
                              hintText: 'Search transaction...',
                              prefixIcon: Icon(Icons.search),
                              suffixIcon: IconButton(onPressed: (){
                                _searchController.clear();
                                    tProvider.clearSearch();
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
                        mainAxisSize: MainAxisSize.min,
                        children: tProvider.filters.map((filter) {
                          bool isSelected = tProvider.selectedFilter == filter;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: InkWell(
                              onTap: () async {
                                tProvider.setFilter(filter);
                                if (filter == 'Custom') {
                                  final picked = await showDateRangePicker(
                                    context: context,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime.now(),
                                    initialDateRange: tProvider.customFrom != null && tProvider.customTo != null
                                        ? DateTimeRange(start: tProvider.customFrom!, end: tProvider.customTo!)
                                        : null,
                                    builder: (context, child) => Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.light(
                                          primary: DColors.primary,
                                          onPrimary: Colors.white,
                                          surface: Colors.white,
                                        ),
                                      ),
                                      child: child!,
                                    ),
                                  );
                                  if (picked != null) {
                                    tProvider.setCustomRange(picked.start, picked.end);
                                  } else {
                                    // User dismissed — revert to no filter
                                    tProvider.setFilter('');
                                  }
                                }
                              },
                              child: Chip(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                label: Text(
                                  // Show date range on chip when custom is active
                                  isSelected && filter == 'Custom' && tProvider.customFrom != null
                                      ? '${DateFormat('d MMM').format(tProvider.customFrom!)} - ${DateFormat('d MMM').format(tProvider.customTo!)}'
                                      : filter,
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : DColors.grey,
                                  ),
                                ),
                                backgroundColor: isSelected ? DColors.primary : Colors.transparent,
                                shape: StadiumBorder(
                                  side: BorderSide(
                                    color: DColors.grey.withValues(alpha: 0.3),
                                    width: 1,
                                  ),
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
                                vertical: 10.0, horizontal: 4.0),
                            child: Text(
                              dateKey,
                              style: TextStyle(
                                color: DColors.grey.withValues(alpha: 0.5),
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          // Transactions under date
                          ...items.map((t) => Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 4, vertical: 2),
                            child: InkWell(
                              onTap: () {
                                context.push(RouteNames.transaction(t.id));
                              },
                              child: TransactionTile(transaction: t),
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
