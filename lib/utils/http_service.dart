import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:recipe_app/models/recipe.dart';
import 'dart:convert';

class HttpService {
  Future<List<Recipe>> getRecipes(String searchQuery) async {
    String postsUrl =
        "https://api.spoonacular.com/recipes/search?query=$searchQuery&number=20&apiKey=${DotEnv().env['API']}";
    Response res = await get(postsUrl);

    if (res.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(res.body);
      List<dynamic> bodyList = (body.values.toList()[0]);
      List<Recipe> recipes =
          bodyList.map((dynamic item) => Recipe.fromJson(item)).toList();
      print(recipes.runtimeType);
      return recipes;
    } else {
      throw 'Failed';
    }
  }
}
