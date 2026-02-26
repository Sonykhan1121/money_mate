import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../transactions/data/models/transaction_type.dart';
import '../../../transactions/data/models/transaction_model.dart';
import 'package:money_mate/core/utils/extensions/provider_extension.dart';

class TransactionTile extends StatefulWidget {
  final TransactionModel transaction;
  final int index;

  const TransactionTile({super.key, required this.transaction, this.index = 0});

  @override
  State<TransactionTile> createState() => _TransactionTileState();
}

class _TransactionTileState extends State<TransactionTile> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 400 + (widget.index * 80)));

    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.3), // starts 30% below
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    // Delay each tile slightly so they cascade one after another
    Future.delayed(Duration(milliseconds: widget.index * 60), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isIncome = widget.transaction.type == TransactionType.income;
    final color = isIncome ? const Color(0xFF00C48C) : const Color(0xFFFF6B6B);
    final bgColor = isIncome ? const Color(0xFF00C48C).withValues(alpha: 0.08) : const Color(0xFFFF6B6B).withValues(alpha: 0.08);

    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _slide,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 12, offset: const Offset(0, 4))],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                context.push(RouteNames.transaction(widget.transaction.id));
              },
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    // ── Category Icon ──────────────────────────────────────
                    // ── Category Icon ──────────────────────────────────────
                    FutureBuilder<List<dynamic>>(
                      future: Future.wait([
                        getCategoryIcon(context, widget.transaction.categoryId),
                        getFirstImagePath(context, id: widget.transaction.id),
                      ]),
                      builder: (context, snapshot) {
                        final String? imagePath = snapshot.data?[1] as String?;
                        final String? icon      = snapshot.data?[0] as String?;

                        return Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: bgColor,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: imagePath != null
                            // ── Has image → show it ──────────────────
                                ? Image.file(
                              File(imagePath),
                              fit: BoxFit.cover,
                              width: 50,
                              height: 50,
                            )
                            // ── No image → show category emoji ───────
                                : Center(
                              child: icon != null
                                  ? Text(icon, style: const TextStyle(fontSize: 22, height: 1.0))
                                  : Icon(Icons.category_outlined, color: color, size: 22),
                            ),
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
                      Row(
                        children: [
                          Text(
                            widget.transaction.title.isEmpty ? 'No title' : widget.transaction.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Color(0xFF1A1A2E),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(width: 10,),
                          FutureBuilder<String>(
                            future: getCategoryName(context, widget.transaction.categoryId),
                            builder: (context, snapshot) {
                              return Text(
                                "(${snapshot.data})",
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
                        ],
                      ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.calendar_today_outlined, size: 11, color: Colors.grey.shade400),
                              const SizedBox(width: 3),
                              Text(
                                _formatDate(widget.transaction.customDate),
                                style: TextStyle(color: Colors.grey.shade500, fontSize: 11),
                              ),
                              if (widget.transaction.paymentMethod != null)
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      _paymentIcon(widget.transaction.paymentMethod),
                                      size: 11,
                                      color: Colors.grey.shade400,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      widget.transaction.paymentMethod!,
                                      style: TextStyle(color: Colors.grey.shade500, fontSize: 11),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                          if (widget.transaction.tags != null && widget.transaction.tags!.isNotEmpty) ...[
                            const SizedBox(height: 6),
                            SizedBox(
                              height: 20,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.transaction.tags!.length,
                                separatorBuilder: (_, __) => const SizedBox(width: 4),
                                itemBuilder:
                                    (_, i) => Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: DColors.primary.withValues(alpha: 0.08),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '#${widget.transaction.tags![i]}',
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
                          '${isIncome ? '+' : '-'} ৳${widget.transaction.amount.toStringAsFixed(0)}',
                          style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 15),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            isIncome ? 'Income' : 'Expense',
                            style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w600),
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
      ),
    );
  }

  IconData _paymentIcon(String? method) {
    switch (method) {
      case 'Cash':
        return Icons.payments_outlined;
      case 'Card':
        return Icons.credit_card_outlined;
      case 'Bank Transfer':
        return Icons.account_balance_outlined;
      case 'Mobile Payment':
        return Icons.phone_android_outlined;
      default:
        return Icons.attach_money_outlined;
    }
  }

  String _formatDate(DateTime date) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  Future<String> getCategoryName(BuildContext context, String categoryId) async {
    return context.addExpenseProvider.getCategoryById(categoryId).name;
  }

  Future<String?> getFirstImagePath(BuildContext context, {required int id}) async {
    String? test = await context.transactionProvider.getTransactionFirstImagePathIfExist(id);
    debugPrint('id1 : $id and imageUrl : $test');
    //if not null then validate the string
    if (test != null) {
      if (test.isEmpty) {
        return null;
      }
      else {
        test = Uri.parse(test).toFilePath();
        debugPrint('id2 : $id and imageUrl : $test');
        return test;
      }
    }
    return test;
  }

  Future<String> getCategoryIcon(BuildContext context, String categoryId) async {
    return context.addExpenseProvider.getCategoryById(categoryId).icon;
  }
}
