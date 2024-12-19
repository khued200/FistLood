import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_conv/data/services/auth_service.dart';
import 'package:shopping_conv/data/services/utils/api_instance.dart';
import 'package:shopping_conv/ui/meal_plan/meal_planner.dart';
import 'package:shopping_conv/ui/list/grocery_list_screen.dart';
import 'package:shopping_conv/ui/app_routes.dart';
import 'package:shopping_conv/ui/register/login_view_model.dart';
import 'package:shopping_conv/ui/register/register_view_model.dart';
import 'package:shopping_conv/utils/auth_storage_util.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    _isAuthenticated = await AuthStorage.isAuthenticated();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _isAuthenticated
        ? MultiProvider(
      providers: [
        Provider(create: (_) => ApiService()),
        ProxyProvider<ApiService, AuthService>(
          update: (_, apiService, __) => AuthService(apiService: apiService),
        ),
        ChangeNotifierProxyProvider<AuthService, RegisterViewModel>(
          update: (_, authService, __) => RegisterViewModel(authService: authService),
          create: (BuildContext context) => RegisterViewModel(authService: context.read<AuthService>()),
        ),
        ChangeNotifierProxyProvider<AuthService, LoginViewModel>(
          update: (_, authService, __) => LoginViewModel(authService: authService),
          create: (BuildContext context) => LoginViewModel(authService: context.read<AuthService>()),
        ),
      ],
      child: MaterialApp(
        initialRoute: AppRoutes.groceryList,
        routes: AppRoutes.getRoutes(),
        debugShowCheckedModeBanner: true,
        title: 'GroceryListScreen',
        theme: ThemeData(primarySwatch: Colors.cyan),
      ),
    )
        : MaterialApp(
      initialRoute: AppRoutes.register,
      routes: AppRoutes.getRoutes(),
      debugShowCheckedModeBanner: true,
      title: 'GroceryListScreen',
      theme: ThemeData(primarySwatch: Colors.cyan),
    );
  }
}