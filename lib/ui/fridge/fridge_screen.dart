import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_conv/blocs/fridge/fridge_bloc.dart';
import 'package:shopping_conv/blocs/fridge/fridge_event.dart';
import 'package:shopping_conv/blocs/fridge/fridge_state.dart';
import 'package:shopping_conv/ui/app_routes.dart';
import 'package:shopping_conv/ui/constant/error.dart';
import 'package:shopping_conv/ui/food/food_screen.dart';

class FridgeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tủ lạnh'),
      ),
      drawer: _buildSidebar(context),
      body: BlocProvider(
        create: (context) => FridgeBloc(fridgeService: context.read())
          ..add(FetchFridgeItems()),
        child: BlocBuilder<FridgeBloc, FridgeState>(
          builder: (context, state) {
            if (state is FridgeLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is FridgeLoaded) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<FridgeBloc>().add(FetchFridgeItems());
                },
                child: state.items.length > 0 ?  ListView.builder(
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    final item = state.items[index];
                    return ListTile(
                      title: Text(item.id as String),
                      leading: Icon(Icons.kitchen),
                    );
                  },
                ) : Center(child: Text('No items found')),
              );
            } else if (state is FridgeError) {
              return Center(child: Text(MessageError.errorCommon));
            } else {
              return Center(child: Text('No items found'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Quản lý món ăn',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: Icon(Icons.refresh),
            title: Text('Refresh'),
            onTap: () {
              Navigator.pop(context);
              context.read<FridgeBloc>().add(FetchFridgeItems());
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Danh sách món ăn'),
            onTap: () {
              // Navigator.pop(context);
             Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodManagementScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
