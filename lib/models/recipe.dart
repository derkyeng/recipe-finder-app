import 'package:flutter/foundation.dart';

class Recipe {
  final int id;
  final String title;
  final String url;
  final String image;

  Recipe(
      {@required this.id,
      @required this.title,
      @required this.url,
      @required this.image});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['sourceUrl'] as String,
      image: json['image'] as String,
    );
  }
}
