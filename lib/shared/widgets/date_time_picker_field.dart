// lib/shared/widgets/date_time_picker_field.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sistema_clinico/shared/widgets/custom_text_form_field.dart';

class DateTimePickerField extends StatefulWidget {
  final String labelText;
  final String? Function(String?)? validator;
  final ValueChanged<DateTime?> onDateSelected;
  final ValueChanged<TimeOfDay?> onTimeSelected;
  final DateTime? initialDate;
  final TimeOfDay? initialTime;

  const DateTimePickerField({
    super.key,
    required this.labelText,
    this.validator,
    required this.onDateSelected,
    required this.onTimeSelected,
    this.initialDate,
    this.initialTime,
  });

  @override
  State<DateTimePickerField> createState() => _DateTimePickerFieldState();
}

class _DateTimePickerFieldState extends State<DateTimePickerField> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  late TextEditingController _displayController;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _selectedTime = widget.initialTime;
    _displayController = TextEditingController(text: _getFormattedDateTime());
  }

  @override
  void didUpdateWidget(covariant DateTimePickerField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialDate != oldWidget.initialDate ||
        widget.initialTime != oldWidget.initialTime) {
      _selectedDate = widget.initialDate;
      _selectedTime = widget.initialTime;
      _displayController.text = _getFormattedDateTime();
    }
  }

  String _getFormattedDateTime() {
    if (_selectedDate == null || _selectedTime == null) {
      return '';
    }
    final date = DateFormat('dd/MM/yyyy').format(_selectedDate!);
    final time = _selectedTime!.format(context);
    return '$date $time';
  }

  Future<void> _pickDateTime(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: _selectedTime ?? TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDate = pickedDate;
          _selectedTime = pickedTime;
          _displayController.text = _getFormattedDateTime();
        });
        widget.onDateSelected(pickedDate);
        widget.onTimeSelected(pickedTime);
      }
    }
  }

  @override
  void dispose() {
    _displayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: _displayController,
      labelText: widget.labelText,
      readOnly: true,
      suffixIcon: const Icon(Icons.calendar_today),
      onTap: () => _pickDateTime(context),
      validator: (value) {
        if (_selectedDate == null || _selectedTime == null) {
          return 'Por favor, selecione a data e o horário.';
        }
        return widget.validator?.call(value);
      },
    );
  }
}
