import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/transactionType.dart';
import '../../providers/transactions_provider.dart';
import '../../utils/constants/colors.dart';

class RecentTransactions extends StatefulWidget {
  const RecentTransactions({super.key});

  @override
  State<RecentTransactions> createState() => _RecentTransactionsState();
}

class _RecentTransactionsState extends State<RecentTransactions> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionsProvider>(builder: (context, tProvider, child) {
      final transactions = tProvider.mockTransactions;

// Take only the last 10 items (or fewer if list has less)
      final recentTransactions = transactions.length > 10
          ? transactions.sublist(transactions.length - 10)
          : transactions;
      return  Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: DColors.fBlack.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Transactions',
              style: TextStyle(
                color: DColors.fBlack,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 10,),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final transaction = recentTransactions[index];
                return ListTile(
                  leading: Icon(
                    transaction.type == TransactionType.income
                        ? Icons.arrow_upward
                        : Icons.arrow_downward,
                    color: transaction.type == TransactionType.income
                        ? Colors.green
                        : Colors.red,
                  ),
                  title: Text(transaction.title),
                  subtitle: Text(
                    '${transaction.date.day}/${transaction.date.month}/${transaction.date.year} - ${transaction.categoryId}',
                  ),
                  trailing: Text(
                    '${transaction.type == TransactionType.expense ? '-' : ''}\$${transaction.amount.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: transaction.type == TransactionType.income
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(
                color: DColors.fBlack.withOpacity(0.1),
                height: 1,
                thickness: 0.5,
                indent: 16,
                endIndent: 16,
              ),
              itemCount: recentTransactions.length,
            )

          ],
        ),
      );
  });
}
}