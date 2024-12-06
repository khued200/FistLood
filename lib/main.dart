// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'ui/grocery_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: const GroceryListScreen(),
      title: 'GroceryListScreen',
      theme: ThemeData(primarySwatch: Colors.cyan),
    );
  }
}

