import 'dart:convert';

class ShoppingList {
  final String id;
  final String userId;
  final String name;
  final List<Item> items;
  final DateTime createdAt;

  ShoppingList({
    required this.id,
    required this.userId,
    required this.name,
    required this.items,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'user_id': userId,
      'name': name,
      'items': items.map((x) => x.toMap()).toList(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory ShoppingList.fromMap(Map<String, dynamic> map) {
    return ShoppingList(
      id: map['_id'],
      userId: map['user_id'],
      name: map['name'],
      items: List<Item>.from(map['items']?.map((x) => Item.fromMap(x))),
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ShoppingList.fromJson(String source) => ShoppingList.fromMap(json.decode(source));
}

class Item {
  final String name;
  final int quantity;
  final String unit;

  Item({
    required this.name,
    required this.quantity,
    required this.unit,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'unit': unit,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      name: map['name'],
      quantity: map['quantity'],
      unit: map['unit'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) => Item.fromMap(json.decode(source));
}

class Inventory {
  final String id;
  final String userId;
  final List<InventoryItem> items;

  Inventory({
    required this.id,
    required this.userId,
    required this.items,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'user_id': userId,
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  factory Inventory.fromMap(Map<String, dynamic> map) {
    return Inventory(
      id: map['_id'],
      userId: map['user_id'],
      items: List<InventoryItem>.from(map['items']?.map((x) => InventoryItem.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Inventory.fromJson(String source) => Inventory.fromMap(json.decode(source));
}

class InventoryItem {
  final String name;
  final int quantity;
  final DateTime expiryDate;

  InventoryItem({
    required this.name,
    required this.quantity,
    required this.expiryDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'expiry_date': expiryDate.toIso8601String(),
    };
  }

  factory InventoryItem.fromMap(Map<String, dynamic> map) {
    return InventoryItem(
      name: map['name'],
      quantity: map['quantity'],
      expiryDate: DateTime.parse(map['expiry_date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoryItem.fromJson(String source) => InventoryItem.fromMap(json.decode(source));
}

class Meal {
  final String id;
  final String userId;
  final DateTime mealTime;
  final String mealType;
  final List<String> recipes;

  Meal({
    required this.id,
    required this.userId,
    required this.mealTime,
    required this.mealType,
    required this.recipes,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'user_id': userId,
      'meal_time': mealTime.toIso8601String(),
      'meal_type': mealType,
      'recipes': recipes,
    };
  }

  factory Meal.fromMap(Map<String, dynamic> map) {
    return Meal(
      id: map['_id'],
      userId: map['user_id'],
      mealTime: DateTime.parse(map['meal_time']),
      mealType: map['meal_type'],
      recipes: List<String>.from(map['recipes']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Meal.fromJson(String source) => Meal.fromMap(json.decode(source));
}

class Recipe {
  final String id;
  final String userId;
  final String title;
  final List<Ingredient> ingredients;
  final String instructions;

  Recipe({
    required this.id,
    required this.userId,
    required this.title,
    required this.ingredients,
    required this.instructions,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'user_id': userId,
      'title': title,
      'ingredients': ingredients.map((x) => x.toMap()).toList(),
      'instructions': instructions,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['_id'],
      userId: map['user_id'],
      title: map['title'],
      ingredients: List<Ingredient>.from(map['ingredients']?.map((x) => Ingredient.fromMap(x))),
      instructions: map['instructions'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Recipe.fromJson(String source) => Recipe.fromMap(json.decode(source));
}

class Ingredient {
  final String name;
  final int quantity;
  final String unit;

  Ingredient({
    required this.name,
    required this.quantity,
    required this.unit,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'unit': unit,
    };
  }

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      name: map['name'],
      quantity: map['quantity'],
      unit: map['unit'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Ingredient.fromJson(String source) => Ingredient.fromMap(json.decode(source));
}
