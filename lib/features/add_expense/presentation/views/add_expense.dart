import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../data/models/category.dart';
import '../widgets/datePickerfield.dart';
import '../widgets/add_expense_tab.dart';
import 'package:file_picker/file_picker.dart';
import '../widgets/category_dropdown_item.dart';
import 'package:image_picker/image_picker.dart';
import '../viewmodels/add_expense_provider.dart';
import '../../../../core/utils/constants/colors.dart';
import 'package:money_mate/shared_widgets/dsnackbar.dart';
import '../../../../shared_widgets/dottedBorder_box.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_mate/shared_widgets/custom_app_bar.dart';
import '../../../transactions/data/models/transactionType.dart';
import 'package:money_mate/core/utils/extensions/provider_extension.dart';
import 'package:money_mate/features/transactions/data/models/transactionModel.dart';
import 'package:money_mate/features/add_expense/presentation/views/image_grid_viewer.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> with SingleTickerProviderStateMixin {
  // ─── Controllers ────────────────────────────────────────────────────────────
  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController amountTextController = TextEditingController();
  final TextEditingController descriptionTextController = TextEditingController();
  final TextEditingController tagInputController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final _fromKey = GlobalKey<FormState>();

  // ─── State ──────────────────────────────────────────────────────────────────
  CategoryModel? _selectedValue;
  DateTime? _selectedDate;
  int _selectedIndex = 0;
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  // ─── Payment Method ──────────────────────────────────────────────────────────
  String? _selectedPaymentMethod;
  final List<String> _paymentMethods = [
    'Cash',
    'Card',
    'Bank Transfer',
    'Mobile Payment',
    'Other',
  ];

  // ─── Tags ────────────────────────────────────────────────────────────────────
  final List<String> _tags = [];



  @override
  void dispose() {
    titleTextController.dispose();
    amountTextController.dispose();
    descriptionTextController.dispose();
    tagInputController.dispose();
    dateController.dispose();
    super.dispose();
  }

  // ─── Tag Helpers ─────────────────────────────────────────────────────────────
  void _addTag(String tag) {
    final trimmed = tag.trim();
    if (trimmed.isNotEmpty && !_tags.contains(trimmed)) {
      setState(() {
        _tags.add(trimmed);
        tagInputController.clear();
      });
    }
  }

  void _removeTag(String tag) => setState(() => _tags.remove(tag));



  @override
  Widget build(BuildContext context) {
    return Consumer<AddExpenseProvider>(
      builder: (context, addExpenseProvider, child) {
        return Scaffold(
          appBar: CustomAppBar(title: "Add Expense / Income"),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // ─── Image Pickers ───────────────────────────────────────
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => _showFileSourceOptions(context, addExpenseProvider),
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: DColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: DottedBorderBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.image_outlined),
                                  const SizedBox(height: 5),
                                  Text('Pick Image', style: TextStyle(color: DColors.primary)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            if (addExpenseProvider.isScanning) {
                              DSnackbar.showInfo(context, "Scanning in progress");
                              return;
                            }
                            await addExpenseProvider.scanDocumentAsImages(page: 4);
                          },
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: DColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: DottedBorderBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.receipt_long_outlined),
                                  const SizedBox(height: 5),
                                  Text('Scan Bill', style: TextStyle(color: DColors.primary)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  const ImageGridViewer(),
                  const SizedBox(height: 10),

                  // ─── Type Tab ────────────────────────────────────────────
                  const Text('Type'),
                  const SizedBox(height: 10),
                  AddExpenseTab(
                    tabIndex: (index) {
                      setState(() {
                        _selectedIndex = index;
                        _selectedValue = null;
                      });
                    },
                  ),
                  const SizedBox(height: 10),

                  // ─── Form ────────────────────────────────────────────────
                  Form(
                    key: _fromKey,
                    autovalidateMode: _autovalidateMode,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // // ── Title ────────────────────────────────────────
                        // const Text('Title'),
                        // const SizedBox(height: 10),
                        // TextFormField(
                        //   controller: titleTextController,
                        //   decoration: const InputDecoration(hintText: 'Enter title'),
                        //   validator: (v) =>
                        //   (v == null || v.trim().isEmpty) ? 'Please enter a title' : null,
                        // ),
                        // const SizedBox(height: 10),

                        // ── Category ─────────────────────────────────────
                        const Text('Category'),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<CategoryModel>(
                          decoration: const InputDecoration(hintText: 'Select a category'),
                          value: _selectedValue,
                          selectedItemBuilder: (context) => _filteredCategories(addExpenseProvider)
                              .map((cat) => CategorySelectedItem(category: cat))
                              .toList(),
                          items: _filteredCategories(addExpenseProvider)
                              .map((cat) => DropdownMenuItem(
                            value: cat,
                            child: CategoryDropdownItem(category: cat),
                          ))
                              .toList(),
                          onChanged: (value) => setState(() => _selectedValue = value),
                          validator: (v) => v == null ? 'Please select a category' : null,
                        ),
                        const SizedBox(height: 10),

                        // ── Amount ───────────────────────────────────────
                        const Text('Amount'),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: amountTextController,
                          decoration: const InputDecoration(hintText: 'Enter amount'),
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          validator: (v) =>
                          (v == null || v.isEmpty) ? 'Please enter amount' : null,
                        ),
                        const SizedBox(height: 10),



                        // ── Date ─────────────────────────────────────────
                        const Text('Date'),
                        const SizedBox(height: 10),
                        DatePickerField(
                          dateController: dateController,
                          onChanged: (d) => setState(() => _selectedDate = d),
                        ),

                        const SizedBox(height: 16),

                        // ── Description ──────────────────────────────────
                        const Text('Description'),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: descriptionTextController,
                          decoration: const InputDecoration(hintText: 'Enter description (optional)'),
                          maxLines: 3,
                        ),
                        const SizedBox(height: 16),

                        // ─── Payment Method — Radio Buttons with Icons ────────────────────────────
                        const Text('Payment Method'),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: _paymentMethods.asMap().entries.map((entry) {
                              final isLast = entry.key == _paymentMethods.length - 1;
                              final method = entry.value;
                              return Column(
                                children: [
                                  RadioListTile<String>(
                                    dense: true,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                                    title: Row(
                                      children: [
                                        Icon(_paymentMethodIcon(method), size: 18, color: DColors.primary),
                                        const SizedBox(width: 8),
                                        Text(method, style: const TextStyle(fontSize: 14)),
                                      ],
                                    ),
                                    value: method,
                                    groupValue: _selectedPaymentMethod,
                                    activeColor: DColors.primary,
                                    onChanged: (v) => setState(() => _selectedPaymentMethod = v),
                                  ),
                                  if (!isLast)
                                    Divider(height: 1, indent: 12, endIndent: 12, color: Colors.grey.shade200),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 16),


                        // ── Tags ─────────────────────────────────────────
                        const Text('Tags'),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: tagInputController,
                                decoration: const InputDecoration(
                                  hintText: 'Type a tag and press +',
                                  contentPadding:
                                  EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                ),
                                onFieldSubmitted: _addTag,
                              ),
                            ),
                            const SizedBox(width: 8),
                            // ← Add button on the right side
                            ElevatedButton(
                              onPressed: () => _addTag(tagInputController.text),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: DColors.primary,
                                minimumSize: const Size(48, 48),
                                padding: const EdgeInsets.all(12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Icon(Icons.add, color: Colors.white, size: 22),
                            ),
                          ],
                        ),
                        if (_tags.isNotEmpty) ...[
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: _tags
                                .map(
                                  (tag) => Chip(
                                label: Text(tag, style: const TextStyle(fontSize: 12)),
                                backgroundColor: DColors.primary.withOpacity(0.1),
                                side: BorderSide(color: DColors.primary.withOpacity(0.3)),
                                deleteIcon: Icon(Icons.close, size: 14, color: DColors.primary),
                                onDeleted: () => _removeTag(tag),
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                              ),
                            )
                                .toList(),
                          ),
                        ],
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ─── Submit Button ─────────────────────────────────────────────────
          bottomNavigationBar: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ElevatedButton(
              onPressed: () async {
                // Enable validation display
                setState(() => _autovalidateMode = AutovalidateMode.onUserInteraction);

                if (_selectedDate == null) return;
                if (!_fromKey.currentState!.validate()) return;

                final double amount = double.parse(amountTextController.text);
                final TransactionType type =
                (_selectedIndex == 0) ? TransactionType.income : TransactionType.expense;

                final TransactionModel tModel = TransactionModel(
                  title: titleTextController.text.trim(),
                  amount: amount,
                  type: type,
                  categoryId: _selectedValue!.id,
                  createdAt: DateTime.now(),
                  customDate: _selectedDate!,
                  description: descriptionTextController.text.trim().isEmpty
                      ? null
                      : descriptionTextController.text.trim(),
                  paymentMethod: _selectedPaymentMethod,
                  tags: _tags.isEmpty ? null : List<String>.from(_tags),
                  imageUrls: addExpenseProvider.imagePaths.isEmpty
                      ? null
                      : List<String>.from(addExpenseProvider.imagePaths),
                  updatedAt: null,
                  notes: null,
                );

                debugPrint("tModel : $tModel");

                final int? success = await addExpenseProvider.addTransaction(tModel);

                if (success != null) {
                  final String label = _selectedIndex == 0 ? "Income" : "Expense";
                  DSnackbar.showSuccess(context, "$label added successfully");
                  await clearAll();
                  context.addExpenseProvider.clearImagePaths();
                  context.transactionProvider.init();
                } else {
                  DSnackbar.showError(context, "Something went wrong");
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                backgroundColor: DColors.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text(
                'Submit',
                style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }

  // ─── Clear All ─────────────────────────────────────────────────────────────
  Future<void> clearAll() async {
    titleTextController.clear();
    amountTextController.clear();
    descriptionTextController.clear();
    tagInputController.clear();
    dateController.clear();
    setState(() {
      _selectedValue = null;
      _selectedDate = null;
      _selectedPaymentMethod = null;
      _tags.clear();
      _autovalidateMode = AutovalidateMode.disabled;
    });
  }

  // ─── Helpers ───────────────────────────────────────────────────────────────
  void _showFileSourceOptions(BuildContext context, AddExpenseProvider addExpenseProvider) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Choose Source',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 20.h),
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: DColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.camera_alt, color: DColors.primary),
              ),
              title: const Text('Camera'),
              subtitle: const Text('Take a Photo'),
              onTap: () {
                Navigator.pop(context);
                _pickFromCamera(addExpenseProvider);
              },
            ),
            SizedBox(height: 10.h),
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: DColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.folder_open, color: DColors.primary),
              ),
              title: const Text('File Manager'),
              subtitle: const Text('Choose From Files'),
              onTap: () {
                Navigator.pop(context);
                _pickFromFiles(addExpenseProvider);
              },
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  Future<void> _pickFromCamera(AddExpenseProvider addExpenseProvider) async {
    try {
      final XFile? image =
      await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 85);
      if (image != null) {
        addExpenseProvider.addImagePath(image.path);
        setState(() {});
      }
    } catch (e) {
      debugPrint('Error in _pickFromCamera: $e');
    }
  }

  Future<void> _pickFromFiles(AddExpenseProvider addExpenseProvider) async {
    try {
      final FilePickerResult? result =
      await FilePicker.platform.pickFiles(allowMultiple: true, type: FileType.image);
      if (result != null) {
        for (var file in result.files) {
          if (file.path != null) addExpenseProvider.addImagePath(file.path!);
        }
        debugPrint('take all files: ${result.files}');
        setState(() {});
      }
    } catch (e) {
      debugPrint('Error in _pickFromFiles: $e');
    }
  }

  List<CategoryModel> _filteredCategories(AddExpenseProvider addExpenseProvider) {
    return addExpenseProvider.demoCategories
        .where((cat) => _selectedIndex == 0
        ? cat.type == TransactionType.income
        : cat.type == TransactionType.expense)
        .toList();
  }

  IconData _paymentMethodIcon(String method) {
    switch (method) {
      case 'Cash':            return Icons.payments_outlined;
      case 'Card':            return Icons.credit_card_outlined;
      case 'Bank Transfer':   return Icons.account_balance_outlined;
      case 'Mobile Payment':  return Icons.phone_android_outlined;
      case 'Other':           return Icons.more_horiz_outlined;
      default:                return Icons.attach_money;
    }
  }
}

