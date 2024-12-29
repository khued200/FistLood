import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_conv/blocs/grocery/grocery_list_bloc.dart';
import 'package:shopping_conv/blocs/grocery/grocery_list_event.dart';

class EditGroceryScreen extends StatefulWidget {
  final String item;
  final String quantity;
  final String category;

  const EditGroceryScreen({
    Key? key,
    required this.item,
    required this.quantity,
    required this.category,
  }) : super(key: key);

  @override
  State<EditGroceryScreen> createState() => _EditGroceryScreenState();
}

class _EditGroceryScreenState extends State<EditGroceryScreen> {
  late TextEditingController itemController;
  late TextEditingController quantityController;
  late String selectedCategory;

  @override
  void initState() {
    super.initState();
    itemController = TextEditingController(text: widget.item);
    quantityController = TextEditingController(text: widget.quantity);
    selectedCategory = widget.category;
  }

  @override
  void dispose() {
    itemController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  void _handleDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Xóa vật phẩm'),
        content: const Text('Bạn có muốn xóa vật phẩm này?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              // Use the current selected category for deletion
              context.read<GroceryBloc>().add(DeleteGroceryItem(
                item: itemController.text,  // Use current item name
                category: selectedCategory, // Use current selected category
              ));
              
              Navigator.pop(dialogContext);  // Close dialog
              Navigator.pop(context);        // Return to list screen
            },
            child: const Text('Xóa', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chỉnh sửa thông tin vật phẩm'),
        backgroundColor: const Color.fromRGBO(158, 237, 255, 100),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _handleDelete(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: itemController,
              decoration: const InputDecoration(
                labelText: 'Item Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: quantityController,
              decoration: const InputDecoration(
                labelText: 'Quantity',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // DropdownButtonFormField<String>(
            //   value: selectedCategory,
            //   decoration: const InputDecoration(
            //     labelText: 'Category',
            //     border: OutlineInputBorder(),
            //   ),
            //   items: ['Vegetable', 'Meat', 'Others'].map((String category) {
            //     return DropdownMenuItem(
            //       value: category,
            //       child: Text(category),
            //     );
            //   }).toList(),
            //   onChanged: (String? newValue) {
            //     if (newValue != null) {
            //       setState(() {
            //         selectedCategory = newValue;
            //       });
            //     }
            //   },
            // ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (itemController.text.isNotEmpty) {
                    context.read<GroceryBloc>().add(EditGroceryItem(
                      oldItem: widget.item,
                      oldCategory: widget.category,
                      newItem: itemController.text,
                      newQuantity: quantityController.text,
                      newCategory: selectedCategory,
                    ));
                    Navigator.pop(context);
                  }
                },
                child: const Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}