import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../core/services/transaction_excel_service.dart';
import '../widgets/show_greeting.dart';
import '../widgets/expenses_card.dart';
import 'package:provider/provider.dart';
import '../widgets/month_selector.dart';
import '../widgets/mini_bar_chart.dart';
import 'package:go_router/go_router.dart';
import '../viewmodels/home_provider.dart';
import '../../../../core/local/localData.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../data/services/transaction_pdf_service.dart';
import 'package:money_mate/core/routing/route_names.dart';
import 'package:money_mate/core/utils/extensions/provider_extension.dart';
import 'package:money_mate/features/home/presentation/widgets/income_card.dart';
import '../../../transactions/presentation/viewmodels/transactions_provider.dart';
import 'package:money_mate/features/profile/presentation/widgets/avatar_result.dart';
import 'package:money_mate/features/home/presentation/views/recent_transactions.dart';
import 'package:money_mate/features/home/presentation/widgets/total_balance_card.dart';
import 'package:money_mate/features/profile/presentation/view_model/profile_provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer3<HomeProvider, TransactionsProvider, ProfileProvider>(
        builder: (_, homeProvider, tProvider, pProvider, _) {
          final month = homeProvider.selectedMonth;
          final totalIncome = tProvider.getTotalIncomeByMonth(month);
          final totalExpenses = tProvider.getTotalExpensesByMonth(month);
          final totalBalance = tProvider.getTotalBalanceByMonth(month);
          String name = pProvider.profile != null ? pProvider.profile!.name! : LocalData.name;

          return SafeArea(
            child: Scaffold(
              body: Column(
                children: [

                  // ── FROZEN TOP SECTION ───────────────────────────────────────────
                  Stack(
                    children: [
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
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ShowGreeting(),
                                const Spacer(),
                                IconButton(
                                  icon: const Icon(Icons.download, color: Colors.white),
                                  onPressed: () => _showDownloadDialog(context, tProvider: tProvider),
                                ),
                                InkWell(
                                  onTap: () => context.push(RouteNames.profile),
                                  child: getProfileWidget(pProvider),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text(name, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600)),
                                const Text('👋', style: TextStyle(fontSize: 20)),
                              ],
                            ),
                            const SizedBox(height: 10),
                            TotalBalanceCard(totalBalance: totalBalance),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                IncomeCard(totalIncome: totalIncome),
                                ExpensesCard(totalExpenses: totalExpenses),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // ── FROZEN MONTH SELECTOR ────────────────────────────────────────
                  MonthSelector(
                    selectedMonth: homeProvider.selectedMonth,
                    onChanged: homeProvider.setSelectedMonth,
                  ),

                  // ── SCROLLABLE CONTENT ───────────────────────────────────────────
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: MiniBarChart(selectedMonth: homeProvider.selectedMonth),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: RecentTransactions(selectedMonth: homeProvider.selectedMonth),
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () => context.navigationProvider.setCurrentIndex(1),
                child: const Icon(Icons.add),
              ),
            ),
          );
        });
  }

  Widget getProfileWidget(ProfileProvider pProvider) {
    if (pProvider.profile != null && pProvider.profile!.imagePath != null) {
      if (pProvider.profile!.avatarType == AvatarType.asset) {
        return CircleAvatar(radius: 20, backgroundImage: AssetImage(pProvider.profile!.imagePath!));
      } else {
        return CircleAvatar(radius: 20, backgroundImage: FileImage(File(pProvider.profile!.imagePath!)));
      }
    }
    return CircleAvatar(radius: 20, child: Icon(Icons.account_circle_outlined));
  }

  void _showDownloadDialog(BuildContext context, {required TransactionsProvider tProvider}) {
    showDialog(
      context: context,
      builder: (_) =>
          AlertDialog(
            title: Text('Export Transactions'),
            content: Text('Choose a format to download your transactions.'),
            actions: [
              TextButton.icon(
                icon: Icon(Icons.picture_as_pdf, color: Colors.red),
                label: Text('PDF'),
                onPressed: () async {
                  Navigator.pop(context);

                  await TransactionPdfService.generateAndShare(
                    transactions: tProvider.allTransactions,
                    getCategoryName: (id) =>
                    context.addExpenseProvider
                        .getCategoryById(id)
                        .name,
                  );
                },
              ),
              TextButton.icon(
                icon: Icon(Icons.table_chart, color: Colors.green),
                label: Text('Excel'),
                onPressed: () async {
                  Navigator.pop(context);
                  // call your new Excel service
                  await TransactionExcelService.generateAndShare(
                      transactions: tProvider.allTransactions,
                      getCategoryName: (id)=> context.addExpenseProvider.getCategoryById(id).name);
                },
              ),
            ],
          ),
    );
  }
}
