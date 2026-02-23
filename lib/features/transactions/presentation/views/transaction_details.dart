import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../transactions/data/models/transactionModel.dart';
import '../../../transactions/data/models/transactionType.dart';
import '../../../transactions/presentation/viewmodels/transactions_provider.dart';
import 'package:money_mate/core/utils/extensions/provider_extension.dart';

class TransactionDetails extends StatefulWidget {
  final int indexOfTransactions;
  const TransactionDetails({super.key, required this.indexOfTransactions});

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  final PageController _pageController = PageController();
  int _currentImageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan','Feb','Mar','Apr','May','Jun',
      'Jul','Aug','Sep','Oct','Nov','Dec'
    ];
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';
    return '${date.day} ${months[date.month - 1]}, ${date.year} - $hour:$minute $period';
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

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionsProvider>(
      builder: (context, tProvider, child) {
        print('index of : ${widget.indexOfTransactions}');
        final transaction = tProvider.allTransactions.firstWhere((t)=>t.id==widget.indexOfTransactions);
        final isIncome = transaction.type == TransactionType.income;
        final color = isIncome ? const Color(0xFF00C48C) : const Color(0xFFFF6B6B);
        final category = context.addExpenseProvider.getCategoryById(transaction.categoryId);
        final categoryName = category.name;
        final categoryIcon = category.icon;
        final hasImages = transaction.imageUrls != null &&
            transaction.imageUrls!.isNotEmpty;

        return Scaffold(
          backgroundColor: Colors.grey.shade50,
          appBar: AppBar(
            title: Row(
              children: [
                Text(categoryIcon, style: const TextStyle(fontSize: 20)),
                const SizedBox(width: 8),
                Text(categoryName,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: () {},
              ),
            ],
          ),

          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [

                // ── Amount Hero Card ───────────────────────────────────
                _SectionCard(
                  child: Column(
                    children: [
                      Text(categoryIcon, style: const TextStyle(fontSize: 48)),
                      const SizedBox(height: 8),
                      Text(
                        categoryName,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${isIncome ? '+' : '-'} ৳${transaction.amount.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          isIncome ? 'Income' : 'Expense',
                          style: TextStyle(
                              color: color, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // ── Image Slider ───────────────────────────────────────
                if (hasImages) ...[
                  _SectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Attachments',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15)),
                            Text(
                              '${_currentImageIndex + 1} / ${transaction.imageUrls!.length}',
                              style: TextStyle(
                                  color: Colors.grey.shade400, fontSize: 12),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Slider
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            height: 200,
                            child: PageView.builder(
                              controller: _pageController,
                              itemCount: transaction.imageUrls!.length,
                              onPageChanged: (i) =>
                                  setState(() => _currentImageIndex = i),
                              itemBuilder: (context, i) {
                                return GestureDetector(
                                  onTap: () => _openFullImage(
                                      context, transaction.imageUrls!, i),
                                  child: Image.file(
                                    File(transaction.imageUrls![i]),
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      color: DColors.primary.withOpacity(0.1),
                                      child: const Center(
                                        child: Icon(
                                            Icons.broken_image_outlined,
                                            size: 48),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        // Dot indicators
                        if (transaction.imageUrls!.length > 1) ...[
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              transaction.imageUrls!.length,
                                  (i) => AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin:
                                const EdgeInsets.symmetric(horizontal: 3),
                                width: _currentImageIndex == i ? 20 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: _currentImageIndex == i
                                      ? DColors.primary
                                      : DColors.primary.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
                        ],

                        const SizedBox(height: 10),

                        // View full button
                        GestureDetector(
                          onTap: () => _openFullImage(
                              context, transaction.imageUrls!, _currentImageIndex),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: DColors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.open_in_full_rounded,
                                    size: 16, color: DColors.primary),
                                const SizedBox(width: 6),
                                Text(
                                  'View Full Image',
                                  style: TextStyle(
                                      color: DColors.primary,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // ── Transaction Info ───────────────────────────────────
                _SectionCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Transaction Information',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                      const SizedBox(height: 10),
                      const Divider(),
                      _InfoRow(label: 'Category', value: categoryName, isChip: true),
                      const Divider(),
                      _InfoRow(
                        label: 'Amount',
                        value:
                        '${isIncome ? '+' : '-'} ৳${transaction.amount.toStringAsFixed(0)}',
                        valueColor: color,
                        valueBold: true,
                      ),
                      const Divider(),
                      _InfoRow(
                          label: 'Date',
                          value: _formatDate(transaction.customDate)),
                      if (transaction.paymentMethod != null) ...[
                        const Divider(),
                        _InfoRow(
                          label: 'Payment Method',
                          value: transaction.paymentMethod!,
                          icon: _paymentIcon(transaction.paymentMethod),
                        ),
                      ],
                      if (transaction.location != null) ...[
                        const Divider(),
                        _InfoRow(
                          label: 'Location',
                          value: transaction.location!,
                          icon: Icons.location_on_outlined,
                        ),
                      ],
                    ],
                  ),
                ),

                // ── Description ────────────────────────────────────────
                if (transaction.description != null &&
                    transaction.description!.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  _SectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Description',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),
                        Text(
                          transaction.description!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                // ── Notes ──────────────────────────────────────────────
                if (transaction.notes != null &&
                    transaction.notes!.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  _SectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Notes',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.amber.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Colors.amber.withOpacity(0.3)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.sticky_note_2_outlined,
                                  size: 16, color: Colors.amber),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  transaction.notes!,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade700,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                // ── Tags ───────────────────────────────────────────────
                if (transaction.tags != null &&
                    transaction.tags!.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  _SectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Tags',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: transaction.tags!.map((tag) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: DColors.primary.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.local_offer_rounded,
                                      size: 12, color: DColors.fYellow),
                                  const SizedBox(width: 5),
                                  Text('#$tag',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: DColors.primary)),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 20),

                // ── Action Buttons ─────────────────────────────────────
                Row(
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.edit_outlined,
                          size: 16, color: DColors.primary),
                      label: Text('Edit',
                          style: TextStyle(color: DColors.primary)),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 20),
                        side: BorderSide(color: DColors.primary, width: 1.5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () =>
                            _confirmDelete(context, tProvider, transaction),
                        icon: Icon(Icons.delete_outline,
                            size: 16, color: DColors.error),
                        label: Text('Delete',
                            style: TextStyle(color: DColors.error)),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: BorderSide(color: DColors.error, width: 1.5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.share_outlined,
                            size: 16, color: Colors.white),
                        label: const Text('Share',
                            style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: DColors.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openFullImage(
      BuildContext context, List<String> urls, int initialIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            _FullImageViewer(urls: urls, initialIndex: initialIndex),
      ),
    );
  }

  void _confirmDelete(
      BuildContext context,
      TransactionsProvider tProvider,
      TransactionModel transaction,
      ) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Delete Transaction'),
        content: const Text(
            'Are you sure you want to delete this transaction? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              await tProvider.deleteTransaction(transaction.id);
              if (context.mounted) {
                Navigator.pop(context); // close dialog
                Navigator.pop(context); // go back
              }
            },
            style:
            ElevatedButton.styleFrom(backgroundColor: DColors.error),
            child: const Text('Delete',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

// ── Reusable Section Card ──────────────────────────────────────────────────────
class _SectionCard extends StatelessWidget {
  final Widget child;
  const _SectionCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
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
      child: child,
    );
  }
}

// ── Reusable Info Row ──────────────────────────────────────────────────────────
class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool valueBold;
  final bool isChip;
  final IconData? icon;

  const _InfoRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.valueBold = false,
    this.isChip = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style:
              TextStyle(fontSize: 13, color: Colors.grey.shade500)),
          if (isChip)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: DColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(value,
                  style:
                  TextStyle(fontSize: 12, color: DColors.primary)),
            )
          else
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 14, color: Colors.grey.shade400),
                  const SizedBox(width: 4),
                ],
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    color: valueColor ?? Colors.grey.shade800,
                    fontWeight:
                    valueBold ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

// ── Full Image Viewer ──────────────────────────────────────────────────────────
class _FullImageViewer extends StatefulWidget {
  final List<String> urls;
  final int initialIndex;
  const _FullImageViewer({required this.urls, required this.initialIndex});

  @override
  State<_FullImageViewer> createState() => _FullImageViewerState();
}

class _FullImageViewerState extends State<_FullImageViewer> {
  late final PageController _controller;
  late int _current;

  @override
  void initState() {
    super.initState();
    _current = widget.initialIndex;
    _controller = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          '${_current + 1} / ${widget.urls.length}',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: PageView.builder(
        controller: _controller,
        itemCount: widget.urls.length,
        onPageChanged: (i) => setState(() => _current = i),
        itemBuilder: (context, i) {
          return InteractiveViewer(
            child: Center(
              child: Image.file(
                File(widget.urls[i]),
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.broken_image_outlined,
                  color: Colors.white54,
                  size: 64,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}