import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

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
import 'package:shopping_conv/ui/app_routes.dart';
import 'package:shopping_conv/ui/home_screen.dart';

class FoodManagementScreen extends StatelessWidget {
  void _showAddFoodDialog(BuildContext context) {
    final _nameController = TextEditingController();
    final _typeController = TextEditingController();
    int? selectedCategory;
    int? selectedUnit;
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
                  TextField(
                    controller: _typeController,
                    decoration: InputDecoration(labelText: 'Type'),
                  ),
                  BlocConsumer<CategoryBloc, CategoryState>(
                    listener: (context, state) {
                      if (state is CategoryError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to load categories')),
                        );
                      }
                    },
                    builder: (context, state) {
                      List<DropdownMenuItem<int>> categoryItems = [];
                      if (state is CategoryLoaded) {
                        categoryItems = state.categories.categories
                            .map((category) => DropdownMenuItem<int>(
                          value: category.id,
                          child: Text(category.name ?? 'N/A'),
                        ))
                            .toList();
                      }

                      return GestureDetector(
                        onTap: () {
                          if (state is! CategoryLoaded) {
                            context.read<CategoryBloc>().add(FetchCategories());
                          }
                        },
                        child: DropdownButtonFormField<int>(
                          value: selectedCategory,
                          hint: Text('Select a category'),
                          items: categoryItems,
                          onChanged: (value) {
                            setState(() {
                              selectedCategory = value;
                            });
                          },
                        ),
                      );
                    },
                  ),
                  BlocConsumer<UnitBloc, UnitState>(
                    listener: (context, state) {
                      if (state is UnitError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to load units')),
                        );
                      }
                    },
                    builder: (context, state) {
                      List<DropdownMenuItem<int>> unitItems = [];
                      if (state is UnitLoaded) {
                        unitItems = state.units.units
                            .map((unit) => DropdownMenuItem<int>(
                          value: unit.id,
                          child: Text(unit.name ?? 'N/A'),
                        ))
                            .toList();
                      }

                      return GestureDetector(
                        onTap: () {
                          if (state is! UnitLoaded) {
                            context.read<UnitBloc>().add(FetchUnits());
                          }
                        },
                        child: DropdownButtonFormField<int>(
                          value: selectedUnit,
                          hint: Text('Select a unit'),
                          items: unitItems,
                          onChanged: (value) {
                            setState(() {
                              selectedUnit = value;
                            });
                          },
                        ),
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
                  final type = _typeController.text.trim();
                  if (name.isNotEmpty &&
                      type.isNotEmpty &&
                      selectedUnit != null) {
                    context.read<FoodBloc>().add(AddFoodItem (
                      context: context,
                      name: name,
                      categoryId: selectedCategory,
                      unitId: selectedUnit!,
                      imageBase64: imageBase64 ?? '',
                      type: type,
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
            if (state.items.isNotEmpty) {
              return ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  final item = state.items[index];

                  // Decode Base64 image
                  Uint8List? imageBytes;
                  if (item.imgUrl != null) {
                    try {
                      imageBytes = base64Decode(item.imgUrl!);
                    } catch (e) {
                      print('Failed to decode Base64 image: $e');
                    }
                  }

                  return GestureDetector(
                    onTap: () {
                      // Navigate to the Food Detail Screen
                      Navigator.pushNamed(context, AppRoutes.homescreen);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      child: Row(
                        children: [
                          // Thumbnail or default image
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.grey[200], // Background color for default
                            ),
                            child: imageBytes != null
                                ? ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.memory(
                                imageBytes,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return _buildDefaultImage();
                                },
                              ),
                            )
                                : _buildDefaultImage(),
                          ),
                          SizedBox(width: 16), // Spacing between image and text
                          // Food name and type
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name ?? 'N/A',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  item.type ?? 'N/A',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text('No food items found'));
            }
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

  /// Builds a default image placeholder for items without a thumbnail
  Widget _buildDefaultImage() {
    return Icon(
      Icons.fastfood,
      size: 40,
      color: Colors.grey[400],
    );
  }

}
