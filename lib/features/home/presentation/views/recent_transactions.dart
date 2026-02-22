import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:money_mate/core/utils/extensions/provider_extension.dart';
import 'package:money_mate/features/add_expense/data/models/category.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../transactions/data/models/transactionModel.dart';
import '../../../transactions/data/models/transactionType.dart';
import '../../../transactions/presentation/viewmodels/transactions_provider.dart';

class RecentTransactions extends StatelessWidget {
  const RecentTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionsProvider>(
      builder: (context, tProvider, child) {
        final recentTransactions =
        tProvider.allTransactions.reversed.take(10).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Header ─────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Transactions',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  if (recentTransactions.isNotEmpty)
                    InkWell(
                      onTap: (){
                        // go to second index of my navigator
                        context.navigationProvider.setCurrentIndex(2);
                      },
                      child: Text(
                        'See all',
                        style: TextStyle(
                          color: DColors.primary,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
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
                    Icon(Icons.receipt_long_outlined,
                        size: 48, color: Colors.grey.shade300),
                    const SizedBox(height: 12),
                    Text(
                      'No transactions yet',
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
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
                return TransactionTile(
                  transaction: entry.value,
                  index: entry.key,
                );
              }),
          ],
        );
      },
    );
  }
}

// ─── Transaction Tile ──────────────────────────────────────────────────────────
class TransactionTile extends StatelessWidget {
  final TransactionModel transaction;
  final int index;

  const TransactionTile({
    super.key,
    required this.transaction,
    this.index = 0,
  });

  // Map categoryId to icon — customize as needed
  IconData _categoryIcon(String categoryId) {
    switch (categoryId) {
      case '1': return Icons.fastfood_outlined;
      case '2': return Icons.directions_car_outlined;
      case '3': return Icons.shopping_bag_outlined;
      case '4': return Icons.medical_services_outlined;
      case '5': return Icons.school_outlined;
      case '6': return Icons.home_outlined;
      case '7': return Icons.flight_outlined;
      case '8': return Icons.sports_esports_outlined;
      default:  return Icons.category_outlined;
    }
  }

  IconData _paymentIcon(String? method) {
    switch (method) {
      case 'Cash':           return Icons.payments_outlined;
      case 'Card':           return Icons.credit_card_outlined;
      case 'Bank Transfer':  return Icons.account_balance_outlined;
      case 'Mobile Payment': return Icons.phone_android_outlined;
      default:               return Icons.attach_money_outlined;
    }
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan','Feb','Mar','Apr','May','Jun',
      'Jul','Aug','Sep','Oct','Nov','Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.type == TransactionType.income;
    final color = isIncome ? const Color(0xFF00C48C) : const Color(0xFFFF6B6B);
    final bgColor = isIncome
        ? const Color(0xFF00C48C).withOpacity(0.08)
        : const Color(0xFFFF6B6B).withOpacity(0.08);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 300 + (index * 60)),
      curve: Curves.easeOut,
      builder: (context, value, child) => Opacity(
        opacity: value,
        child: Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: child,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {}, // hook up detail navigation here
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [

                  // ── Category Icon ──────────────────────────────────────
                  FutureBuilder<String>(
                    future: getCategoryIcon(context, transaction.categoryId),
                    builder: (context, snapshot) {
                      return Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: snapshot.hasData
                              ? Text(
                            snapshot.data!,
                            style: const TextStyle(
                              fontSize: 22,        // emoji size
                              height: 1.0,         // prevents vertical offset
                            ),
                          )
                              : Icon(Icons.category_outlined, color: color, size: 22),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 14),

                  // ── Title + Meta ───────────────────────────────────────
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Title ────────────────────────────────────────────
                        FutureBuilder<String>(
                          future: getCategoryName(context,transaction.categoryId),
                          builder: (context, snapshot) {
                            return Text(
                              snapshot.data ??"...",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Color(0xFF1A1A2E),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            );
                          },
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            // Date
                            Icon(Icons.calendar_today_outlined,
                                size: 11, color: Colors.grey.shade400),
                            const SizedBox(width: 3),
                            Text(
                              _formatDate(transaction.customDate),
                              style: TextStyle(
                                  color: Colors.grey.shade500, fontSize: 11),
                            ),

                            // Payment method
                            if (transaction.paymentMethod != null) ...[
                              const SizedBox(width: 8),
                              Container(
                                width: 3,
                                height: 3,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade400,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                _paymentIcon(transaction.paymentMethod),
                                size: 11,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                transaction.paymentMethod!,
                                style: TextStyle(
                                    color: Colors.grey.shade500, fontSize: 11),
                              ),
                            ],
                          ],
                        ),

                        // Tags row
                        if (transaction.tags != null &&
                            transaction.tags!.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          SizedBox(
                            height: 20,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: transaction.tags!.length,
                              separatorBuilder: (_, __) =>
                              const SizedBox(width: 4),
                              itemBuilder: (_, i) => Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 2),
                                decoration: BoxDecoration(
                                  color: DColors.primary.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '#${transaction.tags![i]}',
                                  style: TextStyle(
                                    color: DColors.primary,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),

                  // ── Amount + Type Badge ────────────────────────────────
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${isIncome ? '+' : '-'} ৳${transaction.amount.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: color,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          isIncome ? 'Income' : 'Expense',
                          style: TextStyle(
                            color: color,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<String> getCategoryName(BuildContext context,String categoryId) async {
    final CategoryModel category = context.addExpenseProvider.getCategoryById(categoryId);
    return category.name;

  }
  Future<String> getCategoryIcon(BuildContext context,String categoryId) async {
    final CategoryModel category = context.addExpenseProvider.getCategoryById(categoryId);
    return category.icon;

  }
}