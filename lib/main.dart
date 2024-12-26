import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_conv/blocs/mealplan/meal_plan_bloc.dart';
import 'package:shopping_conv/ui/app_routes.dart';
import 'package:shopping_conv/blocs/navigation/navigation.dart';
import 'package:shopping_conv/ui/register/register_screen.dart';
import 'package:shopping_conv/ui/register/request_otp_view_model.dart';
import '../ui/home_screen.dart';
import '../blocs/grocery/grocery_list_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shopping_conv/data/services/auth_service.dart';
import 'package:shopping_conv/data/services/utils/api_instance.dart';
import 'package:shopping_conv/ui/list/grocery_list_screen.dart';
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
    return MultiProvider(
      providers: [
        // Base services
        Provider(create: (_) => ApiService()),
        ProxyProvider<ApiService, AuthService>(
          update: (_, apiService, __) => AuthService(apiService: apiService),
        ),
        
        // ViewModels
        ChangeNotifierProxyProvider<AuthService, RegisterViewModel>(
          create: (context) => RegisterViewModel(
            authService: context.read<AuthService>(),
          ),
          update: (_, authService, __) => RegisterViewModel(
            authService: authService,
          ),
        ),
        ChangeNotifierProxyProvider<AuthService, LoginViewModel>(
          create: (context) => LoginViewModel(
            authService: context.read<AuthService>(),
          ),
          update: (_, authService, __) => LoginViewModel(
            authService: authService,
          ),
        ),
        ChangeNotifierProxyProvider<AuthService,RequestOtpViewModel>(
            create: (context) => RequestOtpViewModel(authService: context.read<AuthService>()),
            update: (_, authService, __) => RequestOtpViewModel(authService: authService),),
        // Blocs
        BlocProvider(create: (_) => NavigationBloc()),
        BlocProvider(create: (_) => GroceryBloc()),
        BlocProvider(create: (_) => MealPlanBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        title: 'GroceryListScreen',
        theme: ThemeData(primarySwatch: Colors.cyan),
        home: _isAuthenticated ? HomeScreen() : RegisterScreen(),
        routes: AppRoutes.getRoutes(),
      ),
    );
  }
}