import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/add_expense_provider.dart';
import '../widgets/datePickerfield.dart';
import '../widgets/add_expense_tab.dart';
import '../../data/models/catergory.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../shared_widgets/dottedBorder_box.dart';
import '../../../../providers/transactions_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_mate/shared_widgets/custom_app_bar.dart';
import 'package:money_mate/features/add_expense/presentation/views/image_grid_viewer.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> with SingleTickerProviderStateMixin {
  final TextEditingController amountTextController = TextEditingController();
  final TextEditingController descriptionTextController = TextEditingController();
  final _fromKey = GlobalKey<FormState>();
  CategoryModel? _selectedValue;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer2<TransactionsProvider,AddExpenseProvider>(
      builder: (context, tProvider,addExpenseProvider, child) {
        return Scaffold(
          appBar: CustomAppBar(title: "Add Expense"),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            _showFileSourceOptions(context,addExpenseProvider);
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.image_outlined),
                                  SizedBox(height: 5),
                                  Text('PickImage', style: TextStyle(color: DColors.primary)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: DColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: DottedBorderBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.receipt_long_outlined),
                                SizedBox(height: 5),
                                Text('Scan Bill', style: TextStyle(color: DColors.primary)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  ImageGridViewer(),
                  SizedBox(height: 10),
                  Text('Type'),
                  SizedBox(height: 10),
                  AddExpenseTab(
                    tabIndex: (index) {
                      _selectedIndex = index;
                    },
                  ),
                  Form(
                    key: _fromKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text('Amount'),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: amountTextController,
                          decoration: InputDecoration(hintText: 'Enter amount'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter amount';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        Text('Category'),
                        SizedBox(height: 10),
                        DropdownButtonFormField<CategoryModel>(
                          decoration: InputDecoration(hintText: 'Select an option'),
                          value: _selectedValue,

                          items:
                              tProvider.demoCategories
                                  .map((option) => DropdownMenuItem(value: option, child: Text(option.name)))
                                  .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select an option';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        Text('Description'),
                        SizedBox(height: 10),

                        TextFormField(
                          controller: descriptionTextController,
                          decoration: InputDecoration(hintText: 'Enter description'),
                          maxLines: 4,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter description';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        Text('Date'),
                        SizedBox(height: 10),
                        DatePickerField(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),

            child: ElevatedButton(
              onPressed: () {
                if (_fromKey.currentState!.validate()) {
                  if (_selectedIndex == 0) {
                  } else {}
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill all the fields')));
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                backgroundColor: DColors.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text('Submit', style: TextStyle(fontSize: 14, color: DColors.fWhite, fontWeight: FontWeight.bold)),
            ),
          ),
        );
      },
    );
  }

  void _showFileSourceOptions(BuildContext context,AddExpenseProvider addExpenseProvider) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder:
          (context) => Container(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Choose Source', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
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
                  title: Text('Camera'),
                  subtitle: Text('TakeAPhoto'),
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
                  title: Text('FileManager'),
                  subtitle: Text('Choose From Files'),
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

  // Pick image from camera
  Future<void> _pickFromCamera(AddExpenseProvider addExpenseProvider) async {
    try {
      final ImagePicker picker = ImagePicker();

      final XFile? image = await picker.pickImage(source: ImageSource.camera, imageQuality: 85);

      if (image != null) {
        addExpenseProvider.imagePaths.add(image.path);
        setState(() {});
      }

    } catch (e) {
      debugPrint('Error in _pickFromCamera: $e');
    }
  }

  // Pick file from file manager
  Future<void> _pickFromFiles(AddExpenseProvider addExpenseProvider) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true, type: FileType.image);

      if (result != null) {
        for (var file in result.files) {
          if (file.path != null) {
            addExpenseProvider.imagePaths.add(file.path!);
          }
        }
        setState(() {});

      }
    } catch (e) {
      debugPrint('Error in _pickFromFiles: $e');
    }
  }
}
