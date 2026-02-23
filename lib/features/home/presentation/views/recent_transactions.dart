import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/transaction_tile.dart';
import '../../../../core/utils/constants/colors.dart';
import 'package:money_mate/core/utils/extensions/provider_extension.dart';
import '../../../transactions/presentation/viewmodels/transactions_provider.dart';

class RecentTransactions extends StatelessWidget {
  final DateTime selectedMonth;
  const RecentTransactions({super.key,required this.selectedMonth});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionsProvider>(
      builder: (context, tProvider, child) {
        final recentTransactions = tProvider.getTransactionsByMonth(selectedMonth).reversed.take(10).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Header ─────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
              child: Row(
                children: [
                  const Text('Recent Transactions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),

                  if (recentTransactions.isNotEmpty)
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          context.navigationProvider.setCurrentIndex(2);
                        },
                        child: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'See all...',
                            style: TextStyle(color: DColors.primary, fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // ─── Empty State ─────────────────────────────────────────────
            if (recentTransactions.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 40),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    Icon(Icons.receipt_long_outlined, size: 48, color: Colors.grey.shade300),
                    const SizedBox(height: 12),
                    Text(
                      'No transactions yet',
                      style: TextStyle(color: Colors.grey.shade400, fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Your recent activity will appear here',
                      style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                    ),
                  ],
                ),
              )
            else
              // ─── Transaction List ──────────────────────────────────────
              ...recentTransactions.asMap().entries.map((entry) {
                return TransactionTile(transaction: entry.value, index: entry.key);
              }),
          ],
        );
      },
    );
  }
}

