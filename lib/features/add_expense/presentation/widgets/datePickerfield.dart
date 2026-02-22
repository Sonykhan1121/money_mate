import 'package:flutter/material.dart';

class DatePickerField extends StatefulWidget {
  final TextEditingController dateController;
  final void Function(DateTime)? onChanged;

  const DatePickerField({super.key, this.onChanged,required this.dateController});

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.dateController,
      readOnly: true,
      decoration: const InputDecoration(
        hintText: 'Select Date',
      ),
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2030),
        );

        if (pickedDate != null) {
          widget.dateController.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";

          // call the parent's onChanged
          if (widget.onChanged != null) {
            widget.onChanged!(pickedDate);
          }
        }
      },
      validator: (value) => value == null || value.isEmpty ? 'Please select a date' : null,
    );
  }
}
