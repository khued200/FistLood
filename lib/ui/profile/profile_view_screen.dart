import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_conv/blocs/profile/profile_event.dart';
import 'package:shopping_conv/ui/app_routes.dart';
import 'package:shopping_conv/ui/profile/user_profile_view_model.dart';
import 'package:shopping_conv/ui/register/register_screen.dart';
import 'package:shopping_conv/utils/auth_storage_util.dart';

import '../../blocs/profile/profile_bloc.dart';


class ProfileScreen extends StatelessWidget {
  Uint8List? _decodeBase64(String base64String) {
    try {
      return base64Decode(base64String);
    } catch (e) {
      return null;
    }
  }

  Future<void> _refreshProfile(BuildContext context) async {
    context.read<ProfileBloc>().add(FetchProfile(context));
  }

  Future<void> _logout(BuildContext context) async{
    AuthStorage.clearAuthData();
    Navigator.pushNamedAndRemoveUntil(
      context,
        AppRoutes.register,
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProfileViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Trang cá nhân'),
        backgroundColor: Colors.cyan,
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshProfile(context),
        child: viewModel.isLoading && viewModel.profile == null
            ? Center(child: CircularProgressIndicator())
            : viewModel.errorMessage != null
            ? Center(child: Text(viewModel.errorMessage!))
            : viewModel.profile == null
            ? Center(child: Text('Mọi thứ vẫn ổn trừ trang này'))
            : ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Profile Picture
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: viewModel.profile!.avatarImageUrl != null
                    ? MemoryImage(
                    _decodeBase64(viewModel.profile!.avatarImageUrl!)!)
                    : AssetImage('assets/default_profile_avatar.png') as ImageProvider,
              ),
            ),
            SizedBox(height: 20),

            // Profile Details
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name:',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 4),
                    Text(
                      viewModel.profile!.name ?? 'N/A',
                      style: TextStyle(fontSize: 18),
                    ),
                    Divider(),
                    Text(
                      'Email:',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 4),
                    Text(
                      viewModel.profile!.email ?? 'N/A',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Logout Button
            ElevatedButton(
              onPressed: () => _logout(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Đăng xuất',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
