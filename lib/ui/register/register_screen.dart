import 'package:flutter/material.dart';
import 'package:shopping_conv/ui/register/widgets/login_form.dart';
import 'package:shopping_conv/ui/register/widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tài khoản'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Đăng nhập'),
              Tab(text: 'Đăng ký'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            LoginForm(), // Login Tab
            RegisterForm(), // Register Tab
          ],
        ),
      ),
    );
  }
}
