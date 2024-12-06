import 'dart:convert';

class User {
  final String id;
  final String username;
  final String email;
  final String passwordHash;
  final String roleId;
  final DateTime createdAt;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.passwordHash,
    required this.roleId,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password_hash': passwordHash,
      'role_id': roleId,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      passwordHash: map['password_hash'],
      roleId: map['role_id'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}

class Role {
  final String id;
  final String roleName;

  Role({
    required this.id,
    required this.roleName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'role_name': roleName,
    };
  }

  factory Role.fromMap(Map<String, dynamic> map) {
    return Role(
      id: map['id'],
      roleName: map['role_name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Role.fromJson(String source) => Role.fromMap(json.decode(source));
}

class Group {
  final String id;
  final String groupName;
  final String ownerId;
  final DateTime createdAt;

  Group({
    required this.id,
    required this.groupName,
    required this.ownerId,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'group_name': groupName,
      'owner_id': ownerId,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      id: map['id'],
      groupName: map['group_name'],
      ownerId: map['owner_id'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Group.fromJson(String source) => Group.fromMap(json.decode(source));
}

class GroupMember {
  final String groupId;
  final String userId;
  final DateTime joinedAt;
  final String roleInGroup;

  GroupMember({
    required this.groupId,
    required this.userId,
    required this.joinedAt,
    required this.roleInGroup,
  });

  Map<String, dynamic> toMap() {
    return {
      'group_id': groupId,
      'user_id': userId,
      'joined_at': joinedAt.toIso8601String(),
      'role_in_group': roleInGroup,
    };
  }

  factory GroupMember.fromMap(Map<String, dynamic> map) {
    return GroupMember(
      groupId: map['group_id'],
      userId: map['user_id'],
      joinedAt: DateTime.parse(map['joined_at']),
      roleInGroup: map['role_in_group'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupMember.fromJson(String source) => GroupMember.fromMap(json.decode(source));
}

class GroupShoppingList {
  final String groupId;
  final String shoppingListId;
  final DateTime sharedAt;

  GroupShoppingList({
    required this.groupId,
    required this.shoppingListId,
    required this.sharedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'group_id': groupId,
      'shopping_list_id': shoppingListId,
      'shared_at': sharedAt.toIso8601String(),
    };
  }

  factory GroupShoppingList.fromMap(Map<String, dynamic> map) {
    return GroupShoppingList(
      groupId: map['group_id'],
      shoppingListId: map['shopping_list_id'],
      sharedAt: DateTime.parse(map['shared_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupShoppingList.fromJson(String source) => GroupShoppingList.fromMap(json.decode(source));
}
