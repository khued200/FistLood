import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../register_view_model.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _name = '';
  String _language = 'vn';
  String _timezone = 'Asia/Ho_Chi_Minh';

  void _register(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.read<RegisterViewModel>().register(
        email: _email,
        password: _password,
        name: _name,
        language: _language,
        timezone: _timezone,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RegisterViewModel>();

    return Form(
      key: _formKey,
      child: Padding(padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) =>
              value != null && value.contains('@') ? null : 'Email không hợp lệ',
              onSaved: (value) => _email = value!,
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Mật khẩu',
                prefixIcon: Icon(Icons.lock_outline),
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              validator: (value) =>
              value != null && value.length >= 6 ? null : 'Mật khẩu quá ngắn',
              onSaved: (value) => _password = value!,
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Tên',
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(),
              ),
              onSaved: (value) => _name = value!,
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: viewModel.isLoading ? null : () => _register(context),
              icon: Icon(Icons.person_add),
              label: Text('Đăng ký'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(10),
                // ),
              ),
            ),
            if (viewModel.errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  viewModel.errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),),
    );
  }
}