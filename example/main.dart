import 'package:ez_email_field/ez_email_field.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EZ Email Field Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const EmailFormScreen(),
    );
  }
}

class EmailFormScreen extends StatefulWidget {
  const EmailFormScreen({super.key});

  @override
  State<EmailFormScreen> createState() => _EmailFormScreenState();
}

class _EmailFormScreenState extends State<EmailFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Valid Email: ${_controller.text}')),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('EZ Email Field Demo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                '1. Basic Usage',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              const EzEmailField(),
              const Divider(height: 32),
              const Text(
                '2. Clear Button & Custom Styling',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              const EzEmailField(
                labelText: 'Work Email',
                hintText: 'john.doe@company.com',
                showClearButton: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.work_outline),
                  filled: true,
                ),
              ),
              const Divider(height: 32),
              const Text(
                '3. Custom Validation (e.g., Corporate Only)',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              EzEmailField(
                controller: _controller,
                validator: (value) {
                  if (value != null && !value.endsWith('@ezinner.com')) {
                    return 'Must be an @ezinner.com email address';
                  }
                  return null;
                },
                showClearButton: true,
                decoration: const InputDecoration(
                  labelText: 'Corporate Email',
                  helperText: 'Must end with @ezinner.com',
                ),
              ),
              const Divider(height: 32),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _submitForm,
                  icon: const Icon(Icons.check),
                  label: const Text('Validate All'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
