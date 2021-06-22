import 'dart:convert';

import 'package:flutter/services.dart';


class User {
  // ignore: non_constant_identifier_names
  final String Name;

  const User({
    // ignore: non_constant_identifier_names
    required this.Name,
  });

  static User fromJson(Map<String, dynamic> json) => User(
        Name: json['Name'],
      );
}

class UserData {
  static Future<List<User>> getItemSuggestions(String query) async {
    final String fruit = await rootBundle.loadString('assets/fruit.json');
    final List items = await json.decode(fruit);
    return items.map((json) => User.fromJson(json)).where((user) {
      final nameLower = user.Name.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();
  } 
}