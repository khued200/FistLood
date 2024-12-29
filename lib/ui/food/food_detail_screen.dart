import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_conv/blocs/food/food_bloc.dart';
import 'package:shopping_conv/blocs/food/food_event.dart';
import 'package:shopping_conv/blocs/food/food_state.dart';
import 'dart:typed_data';

class FoodDetailScreen extends StatelessWidget {
  final int foodId; // Pass the food ID to the screen

  FoodDetailScreen({required this.foodId});

  @override
  Widget build(BuildContext context) {
    // Trigger the API call to fetch food details
    context.read<FoodBloc>().add(FetchFoodDetail(context: context, id: foodId));

    return Scaffold(
      appBar: AppBar(
        title: Text('Food Detail'),
      ),
      body: BlocBuilder<FoodBloc, FoodState>(
        builder: (context, state) {
          if (state is FoodDetailLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FoodDetailLoaded) {
            final food = state.foodDetail;
            Uint8List? imageBytes;
            if (food.imgUrl != null) {
              try {
                imageBytes = base64Decode(food.imgUrl!);
              } catch (e) {
                print('Failed to decode Base64 image: $e');
              }
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (imageBytes != null)
                    Image.memory(
                      imageBytes,
                      fit: BoxFit.cover,
                      height: 200,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildDefaultImage();
                      },
                    )
                  else
                    _buildDefaultImage(),
                  SizedBox(height: 16),
                  Text(
                    'Name: ${food.name ?? 'N/A'}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Type: ${food.type ?? 'N/A'}',
                    style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Description:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          } else if (state is FoodDetailError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return Center(child: Text('No details available'));
          }
        },
      ),
    );
  }

  /// Default image for food without a thumbnail
  Widget _buildDefaultImage() {
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.grey[200],
      child: Icon(
        Icons.fastfood,
        size: 100,
        color: Colors.grey[400],
      ),
    );
  }
}
