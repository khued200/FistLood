import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_conv/blocs/food/food_bloc.dart';
import 'package:shopping_conv/blocs/food/food_event.dart';
import 'package:shopping_conv/blocs/food/food_state.dart';
import 'package:shopping_conv/blocs/fridge/fridge_bloc.dart';
import 'package:shopping_conv/blocs/fridge/fridge_event.dart';
import 'package:shopping_conv/blocs/fridge/fridge_state.dart';
import 'package:shopping_conv/ui/constant/error.dart';
import 'package:shopping_conv/ui/food/food_screen.dart';

class FridgeScreen extends StatelessWidget {
  void _showAddFridgeItemDialog(BuildContext context) {
    int? selectedFoodId;
    final _quantityController = TextEditingController();
    final _dateController = TextEditingController();
    final _noteController = TextEditingController();
    DateTime? selectedDate;

    Future<void> _pickDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );

      if (pickedDate != null) {
        final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );

        if (pickedTime != null) {
          // Combine date and time into a single DateTime object
          selectedDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );

          // Update the date controller with the local time display
          _dateController.text = '${selectedDate!.toLocal()}'.split('.')[0];
        }
      }
    }

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Thêm mới'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocConsumer<FoodBloc, FoodState>(
                    listener: (context, state) {
                      if (state is FoodError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Có lỗi xảy ra khi tải dữ liệu Món ăn')),
                        );
                      }
                    },
                    builder: (context, state) {
                      List<DropdownMenuItem<int>> foodItems = [];
                      if (state is FoodLoaded) {
                        foodItems = state.items
                            .map((food) => DropdownMenuItem<int>(
                          value: food.id,
                          child: Text(food.name ?? 'N/A'),
                        ))
                            .toList();
                      }

                      return GestureDetector(
                        onTap: () {
                          if (state is! FoodLoaded) {
                            context.read<FoodBloc>().add(FetchFoodItems(context: context));
                          }
                        },
                        child: DropdownButtonFormField<int>(
                          value: selectedFoodId,
                          hint: Text('Chọn Món ăn'),
                          items: foodItems,
                          onChanged: (value) {
                            setState(() {
                              selectedFoodId = value;
                            });
                          },
                        ),
                      );
                    },
                  ),
                  TextField(
                    controller: _quantityController,
                    decoration: InputDecoration(labelText: 'Số lượng'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: _noteController,
                    decoration: InputDecoration(labelText: 'Ghi chú'),
                  ),
                  TextField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      labelText: 'Ngày hết hạn',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () => _pickDate(context),
                      ),
                    ),
                    readOnly: true,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Huỷ'),
              ),
              ElevatedButton(
                onPressed: () {
                  final quantity = int.tryParse(_quantityController.text.trim());
                  final note = _noteController.text.trim();
                  if (selectedFoodId != null && quantity != null && selectedDate != null) {
                    // Convert the expiration date to UTC (GMT+0)
                    final expiredDate = selectedDate!.toUtc().millisecondsSinceEpoch ~/ 1000;

                    context.read<FridgeBloc>().add(AddFridgeItem(
                      context: context,
                      foodId: selectedFoodId!,
                      quantity: quantity,
                      expiredDate: expiredDate, // Send UTC timestamp
                      note: note.isNotEmpty ? note : null,
                    ));
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Hãy điền đầy đủ thông tin'),
                      ),
                    );
                  }
                },
                child: Text('Add'),
              ),
            ],
          );
        },
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    // Trigger the FetchFridgeItems event on screen load
    context.read<FridgeBloc>().add(FetchFridgeItems(context: context));

    return Scaffold(
      appBar: AppBar(
        title: Text('Tủ lạnh'),
        automaticallyImplyLeading: true, // Ensures the toggle icon is displayed
      ),
      drawer: _buildSidebar(context), // Sidebar
      body: BlocBuilder<FridgeBloc, FridgeState>(
        builder: (context, state) {
          if (state is FridgeLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FridgeLoaded) {
            if (state.items.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<FridgeBloc>().add(FetchFridgeItems(context: context));
                },
                child: ListView.builder(
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    final item = state.items[index];
                    final food = item.food;
                    final Uint8List? foodImage = _decodeBase64(food?.imgUrl);

                    return GestureDetector(
                      onTap: () {
                        // Navigate to fridge item detail screen
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: Row(
                          children: [
                            // Food Image or Default Placeholder
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.grey[200], // Background color for default
                              ),
                              child: foodImage != null
                                  ? ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.memory(
                                  foodImage,
                                  fit: BoxFit.cover,
                                ),
                              )
                                  : Icon(
                                Icons.fastfood,
                                size: 40,
                                color: Colors.grey[400],
                              ),
                            ),
                            SizedBox(width: 16), // Spacing
                            // Food Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    food?.name ?? 'N/A',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Số lượng: ${item.quantity}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Ngày hết hạn: ${_formatTimestamp(item.expiredDate)}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.red[700],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Center(child: Text('Không tìm thấy mục nào'));
            }
          } else if (state is FridgeError) {
            return Center(child: Text(MessageError.errorCommon));
          } else {
            return Center(child: Text('Không tìm thấy mục nào'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddFridgeItemDialog(context),
        child: Icon(Icons.add),
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
              'Quản lý Món ăn',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Danh sách Món ăn'),
            onTap: () {
              Navigator.pop(context);
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

  /// Decode Base64 image to Uint8List
  Uint8List? _decodeBase64(String? base64String) {
    if (base64String == null) return null;
    try {
      return base64Decode(base64String);
    } catch (e) {
      print('Failed to decode Base64: $e');
      return null;
    }
  }

  /// Format timestamp to a readable date and time
  String _formatTimestamp(int? timestamp) {
    if (timestamp == null) return 'N/A';
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} '
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
