import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../transactions/data/models/transaction_type.dart';
import '../../../transactions/data/models/transaction_model.dart';
import '../../data/services/transaction_details_pdf_service.dart';
import 'package:money_mate/core/utils/extensions/provider_extension.dart';
import '../../../transactions/presentation/viewmodels/transactions_provider.dart';

class TransactionDetails extends StatefulWidget {
  final int indexOfTransactions;

  const TransactionDetails({super.key, required this.indexOfTransactions});

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  final PageController _pageController = PageController();
  int _currentImageIndex = 0;

  // ─── Edit Mode State ───────────────────────────────────────────────────────
  bool _isEditing = false;

  final _amountController = TextEditingController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  // final _notesController       = TextEditingController();
  final _locationController = TextEditingController();

  DateTime? _selectedDate;
  String? _selectedCategoryId;
  String? _selectedPaymentMethod;
  TransactionType? _selectedType;
  List<String> _editTags = [];
  List<String> _editImageUrls = []; // existing kept images
  List<XFile> _newImages = []; // newly picked images

  final _tagController = TextEditingController();

  final List<String> _paymentMethods = ['Cash', 'Card', 'Bank Transfer', 'Mobile Payment'];

  @override
  void dispose() {
    _pageController.dispose();
    _amountController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    // _notesController.dispose();
    _locationController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  // ─── Init edit fields from transaction ────────────────────────────────────
  void _enterEditMode(TransactionModel t) {
    _amountController.text = t.amount.toStringAsFixed(0);
    _titleController.text = t.title;
    _descriptionController.text = t.description ?? '';
    // _notesController.text       = t.notes       ?? '';
    _locationController.text = t.location ?? '';
    _selectedDate = t.customDate;
    _selectedCategoryId = t.categoryId;
    _selectedPaymentMethod = t.paymentMethod;
    _selectedType = t.type;
    _editTags = List.from(t.tags ?? []);
    _editImageUrls = List.from(t.imageUrls ?? []);
    _newImages = [];
    setState(() => _isEditing = true);
  }

  void _cancelEdit() {
    setState(() => _isEditing = false);
  }

  // ─── Save ──────────────────────────────────────────────────────────────────
  Future<void> _saveEdit(TransactionsProvider tProvider, TransactionModel original) async {
    // Save new picked images to app directory & collect paths
    final List<String> newPaths = [];
    for (final xFile in _newImages) {
      newPaths.add(xFile.path);
    }

    final updated = original.copyWith(
      amount: double.tryParse(_amountController.text) ?? original.amount,
      title: _titleController.text,
      type: _selectedType,
      categoryId: _selectedCategoryId,
      customDate: _selectedDate,
      description: _descriptionController.text.trim().isEmpty ? null : _descriptionController.text.trim(),
      // notes:         _notesController.text.trim().isEmpty       ? null : _notesController.text.trim(),
      location: _locationController.text.trim().isEmpty ? null : _locationController.text.trim(),
      paymentMethod: _selectedPaymentMethod,
      tags: _editTags.isEmpty ? null : _editTags,
      imageUrl: [..._editImageUrls, ...newPaths],
    );

    await tProvider.updateTransaction(updated);
    setState(() => _isEditing = false);
  }

  // ─── Pick Images ───────────────────────────────────────────────────────────
  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final picked = await picker.pickMultiImage();
    if (picked.isNotEmpty) {
      setState(() => _newImages.addAll(picked));
    }
  }

  // ─── Date Picker ──────────────────────────────────────────────────────────
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder:
          (context, child) => Theme(
            data: Theme.of(context).copyWith(colorScheme: ColorScheme.light(primary: DColors.primary)),
            child: child!,
          ),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  String _formatDate(DateTime date) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';
    return '${date.day} ${months[date.month - 1]}, ${date.year} - $hour:$minute $period';
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

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionsProvider>(
      builder: (context, tProvider, child) {
        final transaction = tProvider.allTransactions.firstWhere((t) => t.id == widget.indexOfTransactions);
        final isIncome = (_isEditing ? _selectedType : transaction.type) == TransactionType.income;
        final color = isIncome ? const Color(0xFF00C48C) : const Color(0xFFFF6B6B);
        final category = context.addExpenseProvider.getCategoryById(
          _isEditing ? (_selectedCategoryId ?? transaction.categoryId) : transaction.categoryId,
        );
        final categoryName = category.name;
        final categoryIcon = category.icon;
        final hasImages = transaction.imageUrls != null && transaction.imageUrls!.isNotEmpty;

        return Scaffold(
          backgroundColor: Colors.grey.shade50,
          appBar: AppBar(
            title: Row(
              children: [
                Text(categoryIcon, style: const TextStyle(fontSize: 20)),
                const SizedBox(width: 8),
                Text(categoryName, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            actions: [
              if (_isEditing)
                TextButton(onPressed: _cancelEdit, child: const Text('Cancel', style: TextStyle(color: Colors.red)))
              else
                IconButton(icon: const Icon(Icons.edit_outlined), onPressed: () => _enterEditMode(transaction)),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // ── Amount Hero Card ─────────────────────────────────────
                _SectionCard(
                  child:
                      _isEditing
                          ? _buildAmountEdit(color, isIncome)
                          : _buildAmountView(transaction, color, isIncome, categoryIcon, categoryName),
                ),

                const SizedBox(height: 16),

                // ── Image Section ────────────────────────────────────────
                if (_isEditing) _buildImageEdit() else if (hasImages) _buildImageView(transaction),

                if (hasImages || _isEditing) const SizedBox(height: 16),

                // ── Transaction Info ─────────────────────────────────────
                _SectionCard(
                  child:
                      _isEditing
                          ? _buildInfoEdit(context, transaction)
                          : _buildInfoView(transaction, color, isIncome, categoryName),
                ),

                // ── Description ──────────────────────────────────────────
                if (_isEditing || (transaction.description != null && transaction.description!.isNotEmpty)) ...[
                  const SizedBox(height: 16),
                  _SectionCard(child: _isEditing ? _buildDescriptionEdit() : _buildDescriptionView(transaction)),
                ],

                // // ── Notes ────────────────────────────────────────────────
                // if (_isEditing || (transaction.notes != null && transaction.notes!.isNotEmpty)) ...[
                //   const SizedBox(height: 16),
                //   _SectionCard(child: _isEditing ? _buildNotesEdit() : _buildNotesView(transaction)),
                // ],

                // ── Tags ─────────────────────────────────────────────────
                if (_isEditing || (transaction.tags != null && transaction.tags!.isNotEmpty)) ...[
                  const SizedBox(height: 16),
                  _SectionCard(child: _isEditing ? _buildTagsEdit() : _buildTagsView(transaction)),
                ],

                const SizedBox(height: 20),

                // ── Action Buttons ───────────────────────────────────────
                _buildActionButtons(context, tProvider, transaction, category),

                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  //  VIEW WIDGETS
  // ══════════════════════════════════════════════════════════════════════════

  Widget _buildAmountView(TransactionModel t, Color color, bool isIncome, String icon, String name) {
    return Column(
      children: [
        Text(icon, style: const TextStyle(fontSize: 48)),
        const SizedBox(height: 8),
        Text(name, style: TextStyle(fontSize: 16, color: Colors.grey.shade500, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Text(
          '${isIncome ? '+' : '-'} ৳${t.amount.toStringAsFixed(0)}',
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: color),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
          child: Text(isIncome ? 'Income' : 'Expense', style: TextStyle(color: color, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }

  Widget _buildImageView(TransactionModel t) {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Attachments', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              Text(
                '${_currentImageIndex + 1} / ${t.imageUrls!.length}',
                style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: 200,
              child: PageView.builder(
                controller: _pageController,
                itemCount: t.imageUrls!.length,
                onPageChanged: (i) => setState(() => _currentImageIndex = i),
                itemBuilder:
                    (context, i) => GestureDetector(
                      onTap: () => _openFullImage(context, t.imageUrls!, i),
                      child: Image.file(
                        File(t.imageUrls![i]),
                        fit: BoxFit.cover,
                        errorBuilder:
                            (_, __, ___) => Container(
                              color: DColors.primary.withValues(alpha: 0.1),
                              child: const Center(child: Icon(Icons.broken_image_outlined, size: 48)),
                            ),
                      ),
                    ),
              ),
            ),
          ),
          if (t.imageUrls!.length > 1) ...[
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                t.imageUrls!.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: _currentImageIndex == i ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentImageIndex == i ? DColors.primary : DColors.primary.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ],
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () => _openFullImage(context, t.imageUrls!, _currentImageIndex),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(color: DColors.grey.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.open_in_full_rounded, size: 16, color: DColors.primary),
                  const SizedBox(width: 6),
                  Text('View Full Image', style: TextStyle(color: DColors.primary, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoView(TransactionModel t, Color color, bool isIncome, String categoryName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Transaction Information', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        const SizedBox(height: 10),
        const Divider(),
        _InfoRow(label: 'Title', value: t.title), // 👈 just a simple InfoRow
        const Divider(),
        _InfoRow(label: 'Category', value: categoryName, isChip: true),
        const Divider(),
        _InfoRow(
          label: 'Amount',
          value: '${isIncome ? '+' : '-'} ৳${t.amount.toStringAsFixed(0)}',
          valueColor: color,
          valueBold: true,
        ),
        const Divider(),
        _InfoRow(label: 'Date', value: _formatDate(t.customDate)),
        if (t.paymentMethod != null) ...[
          const Divider(),
          _InfoRow(label: 'Payment Method', value: t.paymentMethod!, icon: _paymentIcon(t.paymentMethod)),
        ],
        if (t.location != null) ...[
          const Divider(),
          _InfoRow(label: 'Location', value: t.location!, icon: Icons.location_on_outlined),
        ],
      ],
    );
  }

  Widget _buildDescriptionView(TransactionModel t) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        const SizedBox(height: 10),
        const Divider(),
        const SizedBox(height: 10),
        Text(t.description!, style: TextStyle(fontSize: 14, color: Colors.grey.shade700, height: 1.6)),
      ],
    );
  }


  Widget _buildTagsView(TransactionModel t) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Tags', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        const SizedBox(height: 10),
        const Divider(),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              t.tags!
                  .map(
                    (tag) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: DColors.primary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.local_offer_rounded, size: 12, color: DColors.fYellow),
                          const SizedBox(width: 5),
                          Text('#$tag', style: TextStyle(fontSize: 12, color: DColors.primary)),
                        ],
                      ),
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  //  EDIT WIDGETS
  // ══════════════════════════════════════════════════════════════════════════

  Widget _buildAmountEdit(Color color, bool isIncome) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Amount & Type', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        const SizedBox(height: 12),

        // Type toggle
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _selectedType = TransactionType.income),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: _selectedType == TransactionType.income ? const Color(0xFF00C48C) : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Income',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: _selectedType == TransactionType.income ? Colors.white : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _selectedType = TransactionType.expense),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: _selectedType == TransactionType.expense ? const Color(0xFFFF6B6B) : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Expense',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: _selectedType == TransactionType.expense ? Colors.white : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Amount field
        TextFormField(
          controller: _amountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
          decoration: InputDecoration(
            prefixText: '৳ ',
            prefixStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
            hintText: '0',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: color, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageEdit() {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Attachments', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              TextButton.icon(
                onPressed: _pickImages,
                icon: Icon(Icons.add_photo_alternate_outlined, color: DColors.primary, size: 18),
                label: Text('Add', style: TextStyle(color: DColors.primary)),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Existing images
          if (_editImageUrls.isNotEmpty) ...[
            const Text('Existing', style: TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  _editImageUrls.asMap().entries.map((entry) {
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(File(entry.value), width: 80, height: 80, fit: BoxFit.cover),
                        ),
                        Positioned(
                          top: 2,
                          right: 2,
                          child: GestureDetector(
                            onTap: () => setState(() => _editImageUrls.removeAt(entry.key)),
                            child: Container(
                              decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                              child: const Icon(Icons.close, color: Colors.white, size: 16),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
            ),
          ],

          // New images
          if (_newImages.isNotEmpty) ...[
            const SizedBox(height: 12),
            const Text('New', style: TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  _newImages.asMap().entries.map((entry) {
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(File(entry.value.path), width: 80, height: 80, fit: BoxFit.cover),
                        ),
                        Positioned(
                          top: 2,
                          right: 2,
                          child: GestureDetector(
                            onTap: () => setState(() => _newImages.removeAt(entry.key)),
                            child: Container(
                              decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                              child: const Icon(Icons.close, color: Colors.white, size: 16),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
            ),
          ],

          if (_editImageUrls.isEmpty && _newImages.isEmpty)
            GestureDetector(
              onTap: _pickImages,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(
                  color: DColors.primary.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: DColors.primary.withValues(alpha: 0.2), width: 1.5),
                ),
                child: Column(
                  children: [
                    Icon(Icons.add_photo_alternate_outlined, color: DColors.primary, size: 32),
                    const SizedBox(height: 6),
                    Text('Tap to add images', style: TextStyle(color: DColors.primary)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoEdit(BuildContext context, TransactionModel t) {
    final categories = context.addExpenseProvider.demoCategories;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Transaction Information', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        const SizedBox(height: 16),
        // Title
        const Text('Title', style: TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 6),
        TextFormField(
          controller: _titleController,
          decoration: InputDecoration(
            hintText: 'Enter title...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 14),

        // Category picker
        const Text('Category', style: TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          initialValue: _selectedCategoryId,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
          items:
              categories
                  .map(
                    (cat) => DropdownMenuItem(
                      value: cat.id,
                      child: Row(
                        children: [
                          Text(cat.icon, style: const TextStyle(fontSize: 18)),
                          const SizedBox(width: 8),
                          Text(cat.name),
                        ],
                      ),
                    ),
                  )
                  .toList(),
          onChanged: (val) => setState(() => _selectedCategoryId = val),
        ),

        const SizedBox(height: 14),

        // Date picker
        const Text('Date', style: TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: _pickDate,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today_outlined, size: 18, color: DColors.primary),
                const SizedBox(width: 10),
                Text(_selectedDate != null ? _formatDate(_selectedDate!) : 'Select date'),
              ],
            ),
          ),
        ),

        const SizedBox(height: 14),

        // Payment method
        const Text('Payment Method', style: TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          initialValue: _selectedPaymentMethod,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
          hint: const Text('Select payment method'),
          items:
              _paymentMethods
                  .map(
                    (m) => DropdownMenuItem(
                      value: m,
                      child: Row(
                        children: [
                          Icon(_paymentIcon(m), size: 18, color: Colors.grey),
                          const SizedBox(width: 8),
                          Text(m),
                        ],
                      ),
                    ),
                  )
                  .toList(),
          onChanged: (val) => setState(() => _selectedPaymentMethod = val),
        ),

        const SizedBox(height: 14),

        // Location
        const Text('Location', style: TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 6),
        TextFormField(
          controller: _locationController,
          decoration: InputDecoration(
            hintText: 'e.g. Dhaka, Bangladesh',
            prefixIcon: Icon(Icons.location_on_outlined, color: DColors.primary),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionEdit() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        const SizedBox(height: 12),
        TextFormField(
          controller: _descriptionController,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'Add a description...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }

  // Widget _buildNotesEdit() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const Text('Notes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
  //       const SizedBox(height: 12),
  //       TextFormField(
  //         controller: _notesController,
  //         maxLines: 3,
  //         decoration: InputDecoration(
  //           hintText: 'Add a note...',
  //           prefixIcon: const Icon(Icons.sticky_note_2_outlined, color: Colors.amber),
  //           border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildTagsEdit() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Tags', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        const SizedBox(height: 12),

        // Tag input
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _tagController,
                decoration: InputDecoration(
                  hintText: 'Add a tag...',
                  prefixText: '# ',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onFieldSubmitted: (val) {
                  if (val.trim().isNotEmpty) {
                    setState(() {
                      _editTags.add(val.trim());
                      _tagController.clear();
                    });
                  }
                },
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                if (_tagController.text.trim().isNotEmpty) {
                  setState(() {
                    _editTags.add(_tagController.text.trim());
                    _tagController.clear();
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: DColors.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              ),
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ],
        ),

        if (_editTags.isNotEmpty) ...[
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                _editTags
                    .asMap()
                    .entries
                    .map(
                      (entry) => Chip(
                        label: Text('#${entry.value}', style: TextStyle(color: DColors.primary, fontSize: 12)),
                        backgroundColor: DColors.primary.withValues(alpha: 0.08),
                        deleteIcon: Icon(Icons.close, size: 14, color: DColors.primary),
                        onDeleted: () => setState(() => _editTags.removeAt(entry.key)),
                        shape: const StadiumBorder(),
                        side: BorderSide.none,
                      ),
                    )
                    .toList(),
          ),
        ],
      ],
    );
  }

  // ── Action Buttons ─────────────────────────────────────────────────────────
  Widget _buildActionButtons(
    BuildContext context,
    TransactionsProvider tProvider,
    TransactionModel transaction,
    dynamic category,
  ) {
    if (_isEditing) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () => _saveEdit(tProvider, transaction),
          icon: const Icon(Icons.check, color: Colors.white),
          label: const Text('Save Changes', style: TextStyle(color: Colors.white, fontSize: 16)),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: DColors.primary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      );
    }

    return Row(
      children: [
        OutlinedButton.icon(
          onPressed: () => _enterEditMode(transaction),
          icon: Icon(Icons.edit_outlined, size: 16, color: DColors.primary),
          label: Text('Edit', style: TextStyle(color: DColors.primary)),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            side: BorderSide(color: DColors.primary, width: 1.5),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _confirmDelete(context, tProvider, transaction),
            icon: Icon(Icons.delete_outline, size: 16, color: DColors.error),
            label: Text('Delete', style: TextStyle(color: DColors.error)),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: BorderSide(color: DColors.error, width: 1.5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () async {
              await TransactionDetailPdfService.generateAndShare(
                transaction: transaction,
                getCategoryName: (id) => context.addExpenseProvider.getCategoryById(id).name,
                categoryIcon: category.icon,
              );
            },
            icon: const Icon(Icons.share_outlined, size: 16, color: Colors.white),
            label: const Text('Share', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: DColors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
      ],
    );
  }

  // ── Helpers ────────────────────────────────────────────────────────────────
  void _openFullImage(BuildContext context, List<String> urls, int initialIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => _FullImageViewer(urls: urls, initialIndex: initialIndex)),
    );
  }

  void _confirmDelete(BuildContext context, TransactionsProvider tProvider, TransactionModel transaction) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text('Delete Transaction'),
            content: const Text('Are you sure you want to delete this transaction? This cannot be undone.'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                  Navigator.pop(context);

                  await tProvider.deleteTransaction(transaction.id);
                },
                style: ElevatedButton.styleFrom(backgroundColor: DColors.error),
                child: const Text('Delete', style: TextStyle(color: Colors.white)),
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
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 12, offset: const Offset(0, 4))],
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
          Text(label, style: TextStyle(fontSize: 13, color: Colors.grey.shade500)),
          if (isChip)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: DColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(value, style: TextStyle(fontSize: 12, color: DColors.primary)),
            )
          else
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[Icon(icon, size: 14, color: Colors.grey.shade400), const SizedBox(width: 4)],
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    color: valueColor ?? Colors.grey.shade800,
                    fontWeight: valueBold ? FontWeight.bold : FontWeight.w500,
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
        title: Text('${_current + 1} / ${widget.urls.length}', style: const TextStyle(color: Colors.white)),
      ),
      body: PageView.builder(
        controller: _controller,
        itemCount: widget.urls.length,
        onPageChanged: (i) => setState(() => _current = i),
        itemBuilder:
            (context, i) => InteractiveViewer(
              child: Center(
                child: Image.file(
                  File(widget.urls[i]),
                  fit: BoxFit.contain,
                  errorBuilder:
                      (_, __, ___) => const Icon(Icons.broken_image_outlined, color: Colors.white54, size: 64),
                ),
              ),
            ),
      ),
    );
  }
}
