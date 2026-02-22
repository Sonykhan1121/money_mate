import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money_mate/core/routing/route_names.dart';
import 'package:money_mate/features/home/presentation/widgets/income_card.dart';
import 'package:money_mate/features/home/presentation/widgets/total_balance_card.dart';
import 'package:provider/provider.dart';
import '../../../../core/local/localData.dart';
import '../viewmodels/home_provider.dart';
import '../widgets/expenses_card.dart';
import '../widgets/mini_bar_chart.dart';
import '../../../../core/utils/constants/icons.dart';
import '../../../../core/utils/constants/colors.dart';
import 'package:money_mate/core/utils/extensions/provider_extension.dart';
import 'package:money_mate/features/home/presentation/views/recent_transactions.dart';

import '../widgets/show_greeting.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
   return Consumer<HomeProvider>(builder: (_,homeProvider,_){
     return SafeArea(
       child: Scaffold(
         body: SingleChildScrollView(
           child: Column(
             children: [
               Stack(
                 children: [
                   // Gradient background with curve
                   Container(
                     height: MediaQuery.of(context).size.height * 0.135,
                     decoration: const BoxDecoration(
                       gradient: LinearGradient(
                         begin: Alignment.topLeft,
                         end: Alignment.bottomRight,
                         colors: [DColors.primary, DColors.primarySecondary],
                       ),
                     ),
                   ),
                   // Content on top of gradient
                   Padding(
                     padding: const EdgeInsets.all(20.0),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         // Greeting
                         Row(
                           children: [
                             ShowGreeting(),
                             Spacer(),
                             InkWell(
                               onTap: () {
                                 context.push(RouteNames.profile);
                               },
                               child: CircleAvatar(radius: 15, child: Icon(Icons.account_circle_outlined)),
                             ),
                           ],
                         ),
                         const SizedBox(height: 4),
                         // Name with wave emoji
                         Row(
                           children: [
                             Text(
                               LocalData.name,
                               style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
                             ),
                             Text('👋', style: TextStyle(fontSize: 20)),
                           ],
                         ),
                         const SizedBox(height: 10),
                         // Balance Card
                         TotalBalanceCard(),

                         SizedBox(height: 10),
                         Row(
                           children: [
                             IncomeCard(),
                             // Expenses Card
                             ExpensesCard(),
                           ],
                         ),
                       ],
                     ),
                   ),
                 ],
               ),

               // Rest of your content goes here
               Padding(padding: const EdgeInsets.all(20), child: MiniBarChart(data: [5, 8, 20, 5, 30, 8, 20,28,78])),

               Padding(padding: const EdgeInsets.all(20), child: RecentTransactions()),
             ],
           ),
         ),
         floatingActionButton: FloatingActionButton(
           onPressed: () {
             context.navigationProvider.setCurrentIndex(1);
           },
           child: Icon(Icons.add),
         ),
       ),
     );
   });
  }
}
