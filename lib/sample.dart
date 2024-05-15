import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PageController _pageController;
  String formDataFromForm1 = '';
  String formDataFromForm2 = '';

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void updateFormData(String data, int formNumber) {
    setState(() {
      if (formNumber == 1) {
        formDataFromForm1 = data;
      } else if (formNumber == 2) {
        formDataFromForm2 = data;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sync Forms'),
        actions: [
          IconButton(
            icon: Icon(Icons.sync),
            onPressed: () {
              // Do something with the form data
              print('Form 1 data: $formDataFromForm1');
              print('Form 2 data: $formDataFromForm2');
            },
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: [
          FormWidget(
            formNumber: 1,
            onFormDataChanged: (data) => updateFormData(data, 1),
          ),
          FormWidget(
            formNumber: 2,
            onFormDataChanged: (data) => updateFormData(data, 2),
          ),
        ],
      ),
    );
  }
}

class FormWidget extends StatefulWidget {
  final int formNumber;
  final Function(String) onFormDataChanged;

  FormWidget({required this.formNumber, required this.onFormDataChanged});

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _controller,
        onChanged: (value) {
          widget.onFormDataChanged(value);
        },
        decoration: InputDecoration(
          labelText: 'Form ${widget.formNumber}',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
