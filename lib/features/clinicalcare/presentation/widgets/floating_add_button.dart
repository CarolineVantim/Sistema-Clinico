import 'package:flutter/material.dart';
import 'package:sistema_clinico/shared/constants/colors.dart';
import 'package:sistema_clinico/features/treatment/presentation/treatment_description_page.dart';

class CustomFloatingActionButton extends StatefulWidget {
  final VoidCallback onPressed;

  const CustomFloatingActionButton({
    super.key,
    required this.onPressed,
  });

  @override
  _CustomFloatingActionButtonState createState() =>
      _CustomFloatingActionButtonState();
}

class _CustomFloatingActionButtonState
    extends State<CustomFloatingActionButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _showAddStudentModal(context);
      },
      backgroundColor: tPrimaryColor,
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}

void _showAddStudentModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) => SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: const AddService(),
      ),
    ),
  );
}
