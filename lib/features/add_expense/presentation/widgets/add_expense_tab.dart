import 'package:flutter/material.dart';
import '../../../../core/utils/constants/colors.dart';

class AddExpenseTab extends StatefulWidget {
  final void Function(int) tabIndex;

  const AddExpenseTab({required this.tabIndex,super.key});

  @override
  State<AddExpenseTab> createState() => _AddExpenseTabState();
}

class _AddExpenseTabState extends State<AddExpenseTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Listen for tab changes
    _tabController.addListener(() {
      if (_tabController.indexIsChanging == false) {
        widget.tabIndex(_tabController.index);
      }
    });
  }


  @override
  Widget build(BuildContext context) {



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
                controller: _tabController,
                tabs: [
                  Tab(text: 'Income'),
                  Tab(text: 'Expense'),
                ],
              ),
            ),
          ),


          SizedBox(height: 10,),



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
}
