import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping_conv/blocs/category/category_bloc.dart';
import 'package:shopping_conv/blocs/category/category_state.dart';
import 'package:shopping_conv/blocs/category/catgory_event.dart';
import 'package:shopping_conv/blocs/food/food_bloc.dart';
import 'package:shopping_conv/blocs/food/food_event.dart';
import 'package:shopping_conv/blocs/food/food_state.dart';
import 'package:shopping_conv/blocs/unit/unit_bloc.dart';
import 'package:shopping_conv/blocs/unit/unit_event.dart';
import 'package:shopping_conv/blocs/unit/unit_state.dart';

class FoodManagementScreen extends StatelessWidget {
  void _showAddFoodDialog(BuildContext context) {
    final _nameController = TextEditingController();
    String? selectedCategory;
    String? selectedUnit;
    String? imageBase64;

    Future<void> _pickImage() async {
      try {
        final picker = ImagePicker();
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);

        if (pickedFile != null) {
          final bytes = await File(pickedFile.path).readAsBytes();
          imageBase64 = base64Encode(bytes); // Convert image to Base64
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Image uploaded successfully')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No image selected')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload image: $e')),
        );
      }
    }

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Add New Food'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, state) {
                      List<DropdownMenuItem<String>> categoryItems = [];

                      if (state is CategoryLoaded) {
                        categoryItems = state.categories.categories
                            .map((category) => DropdownMenuItem<String>(
                          value: category.id.toString(),
                          child: Text(category.name ?? 'N/A'),
                        ))
                            .toList();
                      }

                      return DropdownButtonFormField<String>(
                        value: selectedCategory,
                        hint: Text('Select a category'),
                        items: categoryItems,
                        onTap: () {
                          if (state is! CategoryLoaded) {
                            context.read<CategoryBloc>().add(FetchCategories());
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value;
                          });
                        },
                      );
                    },
                  ),
                  BlocBuilder<UnitBloc, UnitState>(
                    builder: (context, state) {
                      List<DropdownMenuItem<String>> unitItems = [];

                      if (state is UnitLoaded) {
                        unitItems = state.units.units
                            .map((unit) => DropdownMenuItem<String>(
                          value: unit.id.toString(),
                          child: Text(unit.name ?? 'N/A'),
                        ))
                            .toList();
                      }

                      return DropdownButtonFormField<String>(
                        value: selectedUnit,
                        hint: Text('Select a unit'),
                        items: unitItems,
                        onTap: () {

                            context.read<UnitBloc>().add(FetchUnits());

                        },
                        onChanged: (value) {
                          setState(() {
                            selectedUnit = value;
                          });
                        },
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: Icon(Icons.upload),
                    label: Text('Upload Image'),
                  ),
                  if (imageBase64 != null) ...[
                    SizedBox(height: 8),
                    Text('Image selected', style: TextStyle(color: Colors.green)),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  final name = _nameController.text.trim();

                  if (name.isNotEmpty &&
                      selectedCategory != null &&
                      selectedUnit != null &&
                      imageBase64 != null) {
                    context.read<FoodBloc>().add(AddFoodItem(
                      context: context,
                      name: name,
                      category: selectedCategory!,
                      unit: selectedUnit!,
                      imageBase64: imageBase64!,
                    ));
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please fill in all fields and upload an image'),
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
    // Trigger the FetchFoodItems event when the screen is opened
    context.read<FoodBloc>().add(FetchFoodItems(context: context));

    return Scaffold(
      appBar: AppBar(
        title: Text('Food Management'),
      ),
      body: BlocBuilder<FoodBloc, FoodState>(
        builder: (context, state) {
          if (state is FoodLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FoodLoaded) {
            return state.items.length > 0 ? ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final item = state.items[index];
                return ListTile(
                  title: Text(item.name ?? 'N/A'),
                  subtitle: Text(item.type ?? 'N/A'),
                );
              },
            ) : Center(child: Text('No food items found'));
          } else if (state is FoodError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return Center(child: Text('No food items found'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddFoodDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
