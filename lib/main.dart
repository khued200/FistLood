import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_conv/blocs/category/category_bloc.dart';
import 'package:shopping_conv/blocs/food/food_bloc.dart';
import 'package:shopping_conv/blocs/fridge/fridge_bloc.dart';
import 'package:shopping_conv/blocs/mealplan/meal_plan_bloc.dart';
import 'package:shopping_conv/blocs/profile/profile_bloc.dart';
import 'package:shopping_conv/blocs/unit/unit_bloc.dart';
import 'package:shopping_conv/data/services/food_service.dart';
import 'package:shopping_conv/data/services/fridge_service.dart';
import 'package:shopping_conv/data/services/unit_service.dart';
import 'package:shopping_conv/ui/app_routes.dart';
import 'package:shopping_conv/blocs/navigation/navigation.dart';
import 'package:shopping_conv/ui/food/food_screen.dart';
import 'package:shopping_conv/ui/fridge/fridge_screen.dart';
import 'package:shopping_conv/ui/profile/profile_view_screen.dart';
import 'package:shopping_conv/ui/profile/user_profile_view_model.dart';
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

import 'data/services/category_service.dart';

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
        ProxyProvider<ApiService, FridgeService>(
          update: (_, apiService, __) => FridgeService(apiService: apiService),
        ),
        ProxyProvider<ApiService, FoodService>(
          update: (_, apiService, __) => FoodService(apiService: apiService),
        ),
        ProxyProvider<ApiService, CategoryService>(
          update: (_, apiService, __) => CategoryService(apiService: apiService),
        ),
        ProxyProvider<ApiService, UnitService>(
          update: (_, apiService, __) => UnitService(apiService: apiService),
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
        ChangeNotifierProxyProvider<AuthService, ProfileViewModel>(
          create: (context) => ProfileViewModel(
            apiService: context.read<AuthService>(),
          ),
          update: (_, authService, __) => ProfileViewModel(
            apiService: authService,
          ),
        ),
        // Blocs
        BlocProvider(create: (_) => NavigationBloc()),
        BlocProvider(create: (_) => GroceryBloc()),
        BlocProvider(create: (_) => MealPlanBloc()),
        BlocProvider(
          create: (context) => ProfileBloc(authService: context.read<AuthService>()),
          child: ProfileScreen(),
        ),
        BlocProvider(
          create: (context) => FridgeBloc(fridgeService: context.read<FridgeService>()),
          child: FridgeScreen(),
        ),
        BlocProvider(
          create: (context) => FoodBloc(foodService: context.read<FoodService>()),
          child: FoodManagementScreen(),
        ),
        BlocProvider(create: (context) => CategoryBloc(categoryService: context.read<CategoryService>())),
        BlocProvider(create: (context) => UnitBloc(unitService: context.read<UnitService>())),

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