import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recipe_app/screens/recipe_page.dart';

void main() async {
  await DotEnv().load('.env');
  runApp(RecipeApp());
}

class RecipeApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe App',
      home: RecipePage(),
    );
  }
}
