import 'package:flutter/material.dart';
import 'package:sistema_clinico/shared/constants/colors.dart';

class FilterDateDropdown extends StatefulWidget {
  final ValueChanged<String> onDateChanged;
  final ValueChanged<String> onItemChanged;
  final VoidCallback onClearFilter;

  const FilterDateDropdown({
    super.key,
    required this.onDateChanged,
    required this.onItemChanged,
    required this.onClearFilter,
  });

  @override
  _FilterDateDropdownState createState() => _FilterDateDropdownState();
}

class _FilterDateDropdownState extends State<FilterDateDropdown> {
  DateTime? _selectedDate;
  late String _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = '0';
    _selectedDate =
        null; // Inicializa a data selecionada como nula ao abrir o dropdown
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    Color dropdownTextColor = isDarkTheme ? Colors.white : Colors.black;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => _showDatePicker(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: tPrimaryColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
              ),
              icon: const Icon(Icons.calendar_today, color: Colors.white),
              label: Text(
                _selectedDate != null
                    ? _selectedDate!.toString().split(' ')[0]
                    : 'Selecione',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 16.0),
            Container(
              constraints: const BoxConstraints(maxWidth: 200),
              child: DropdownButton<String>(
                value: _selectedItem,
                items: [
                  DropdownMenuItem(
                    value: '0',
                    child: Text('Todas',
                        style: TextStyle(color: dropdownTextColor)),
                  ),
                  DropdownMenuItem(
                    value: 'Educadora Especial',
                    child: Text('Educadora Especial',
                        style: TextStyle(color: dropdownTextColor)),
                  ),
                  DropdownMenuItem(
                    value: 'Professor de Educação Inclusiva',
                    child: Text('Professor de Educação Inclusiva',
                        style: TextStyle(color: dropdownTextColor)),
                  ),
                  DropdownMenuItem(
                    value: 'Pedagoga Inclusiva',
                    child: Text('Pedagoga Inclusiva',
                        style: TextStyle(color: dropdownTextColor)),
                  ),
                  DropdownMenuItem(
                    value: 'Psicopedagogo',
                    child: Text('Psicopedagogo',
                        style: TextStyle(color: dropdownTextColor)),
                  ),
                  DropdownMenuItem(
                    value: 'Terapeuta Ocupacional',
                    child: Text('Terapeuta Ocupacional',
                        style: TextStyle(color: dropdownTextColor)),
                  ),
                  DropdownMenuItem(
                    value: 'Fonoaudiólogo',
                    child: Text('Fonoaudiólogo',
                        style: TextStyle(color: dropdownTextColor)),
                  ),
                  DropdownMenuItem(
                    value: 'Professora de Educação Física Adaptada',
                    child: Text('Professora de Educação Física Adaptada',
                        style: TextStyle(color: dropdownTextColor)),
                  ),
                  DropdownMenuItem(
                    value: 'Neuropsicólogo Infantil',
                    child: Text('Neuropsicólogo Infantil',
                        style: TextStyle(color: dropdownTextColor)),
                  ),
                  DropdownMenuItem(
                    value: 'Acompanhante Terapêutica',
                    child: Text('Acompanhante Terapêutica',
                        style: TextStyle(color: dropdownTextColor)),
                  ),
                  DropdownMenuItem(
                    value: 'Musicoterapeuta',
                    child: Text('Musicoterapeuta',
                        style: TextStyle(color: dropdownTextColor)),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedItem = value!;
                    widget.onItemChanged(value);
                  });
                },
                iconSize: 30.0,
                isExpanded: true,
                hint: Text('Selecione',
                    style: TextStyle(color: dropdownTextColor)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  // Limpar filtro e reverter para o estado inicial
                  _selectedDate = null;
                  _selectedItem = '0';
                  widget
                      .onClearFilter(); // Chama a função de limpar filtro do ClinicalCarePage
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: tPrimaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text(
                'Limpar filtro',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.onDateChanged(picked.toString().split(' ')[0]);
      });
    }
  }
}
