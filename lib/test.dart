import 'package:flutter/material.dart';

class MyDropdownTextField extends StatefulWidget {
  @override
  _MyDropdownTextFieldState createState() => _MyDropdownTextFieldState();
}

class _MyDropdownTextFieldState extends State<MyDropdownTextField> {
  TextEditingController _textEditingController = TextEditingController();
  List<String> _options = ['Option 1', 'Option 2', 'Option 3'];
  late String _selectedOption=_options[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textEditingController,
              onTap: () {
                _showPopupMenu(context);
              },
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Select an option',
                suffixIcon: Icon(Icons.arrow_drop_down),
              ),
            ),
            SizedBox(height: 16),
            _selectedOption != null
                ? Text('Selected Option: $_selectedOption')
                : Container(),
          ],
        ),
      ),
    );
  }

  void _showPopupMenu(BuildContext context) async {
    final result = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(0, 60, 0, 0),
      items: _options.map((String option) {
        return PopupMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
    );

    if (result != null) {
      setState(() {
        _selectedOption = result;
        _textEditingController.text = result;
      });
    }
  }
}
