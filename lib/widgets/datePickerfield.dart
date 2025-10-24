import 'package:flutter/material.dart';

class DatePickerField extends StatefulWidget {
  final void Function(DateTime)? onChanged;

  const DatePickerField({super.key, this.onChanged});

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
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
          _controller.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";

          // call the parent's onChanged
          if (widget.onChanged != null) {
            widget.onChanged!(pickedDate);
          }
        }
      },
    );
  }
}
