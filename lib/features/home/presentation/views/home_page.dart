import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_mate/features/profile/presentation/view_model/profile_provider.dart';
import 'package:money_mate/features/profile/presentation/widgets/avatar_result.dart';

import '../../data/services/transaction_pdf_service.dart';
import '../widgets/expenses_card.dart';
import '../widgets/month_selector.dart';
import '../widgets/show_greeting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/mini_bar_chart.dart';
import 'package:go_router/go_router.dart';
import '../viewmodels/home_provider.dart';
import '../../../../core/local/localData.dart';
import '../../../../core/utils/constants/colors.dart';
import 'package:money_mate/core/routing/route_names.dart';
import 'package:money_mate/core/utils/extensions/provider_extension.dart';
import 'package:money_mate/features/home/presentation/widgets/income_card.dart';
import '../../../transactions/presentation/viewmodels/transactions_provider.dart';
import 'package:money_mate/features/home/presentation/views/recent_transactions.dart';
import 'package:money_mate/features/home/presentation/widgets/total_balance_card.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
   return Consumer3<HomeProvider,TransactionsProvider,ProfileProvider>(builder: (_,homeProvider,tProvider,pProvider,_){
     final month = homeProvider.selectedMonth;
     final totalIncome   = tProvider.getTotalIncomeByMonth(month);
     final totalExpenses = tProvider.getTotalExpensesByMonth(month);
     final totalBalance  = tProvider.getTotalBalanceByMonth(month);
     String name = pProvider.profile!=null?pProvider.profile!.name!: LocalData.name;

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
                               child: getProfileWidget(pProvider),
                             ),
                           ],
                         ),
                         const SizedBox(height: 4),
                         // Name with wave emoji
                         Row(
                           children: [
                             Text(
                               name,
                               style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
                             ),
                             Text('👋', style: TextStyle(fontSize: 20)),
                           ],
                         ),
                         const SizedBox(height: 10),
                         // Balance Card
                         TotalBalanceCard(totalBalance: totalBalance,),

                         SizedBox(height: 10),
                         Row(
                           children: [
                             IncomeCard(totalIncome: totalIncome,),
                             // Expenses Card
                             ExpensesCard(totalExpenses: totalExpenses,),
                           ],
                         ),
                       ],
                     ),
                   ),
                 ],
               ),
               InkWell(
                 onTap: () async {
                   await TransactionPdfService.generateAndShare(
                     transactions: tProvider.allTransactions,
                     getCategoryName: (id) => context.addExpenseProvider.getCategoryById(id).name,
                   );
                 },
                 child: Container(
                   child: Text('pdf'),
                 ),
               ),

               MonthSelector(
                 selectedMonth: homeProvider.selectedMonth,
                 onChanged: homeProvider.setSelectedMonth,
               ),

               // Rest of your content goes here
               Padding(padding: const EdgeInsets.all(20), child: MiniBarChart(selectedMonth: homeProvider.selectedMonth,)),

               Padding(padding: const EdgeInsets.all(20), child: RecentTransactions(selectedMonth: homeProvider.selectedMonth,)),
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

  Widget getProfileWidget(ProfileProvider pProvider) {
    if(pProvider.profile!=null&&pProvider.profile!.imagePath!=null)
      {
        if(pProvider.profile!.avatarType==AvatarType.asset)
          {
            return CircleAvatar(radius: 20, backgroundImage: AssetImage(pProvider.profile!.imagePath!));

          }else
            {

        return CircleAvatar(radius: 20, backgroundImage: FileImage(File(pProvider.profile!.imagePath!)));
            }
      }
    return CircleAvatar(radius: 20, child: Icon(Icons.account_circle_outlined));
  }
}
