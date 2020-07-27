import 'package:flutter/material.dart';
import 'package:recipe_app/utils/http_service.dart';
import 'package:recipe_app/models/recipe.dart';

class RecipePage extends StatefulWidget {
  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  final HttpService httpService = HttpService();
  TextEditingController _searchController = TextEditingController();
  final ScrollController controller = ScrollController();
  List<Recipe> recipeMaker = [];
  String search;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              search = _searchController.text;
              recipeMaker = await httpService.getRecipes(search);
              setState(() {
                controller.animateTo(0,
                    duration: Duration(microseconds: 500),
                    curve: Curves.easeInOut);
                if (recipeMaker.isEmpty) {
                  print('No Recipes');
                }
              });
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Recipe',
            ),
          ),
          Expanded(
            child: GridView.builder(
              controller: controller,
              itemCount: recipeMaker.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      print('Image Pressed');
                    },
                    child: Container(
                      child: Text(recipeMaker[index].title),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://spoonacular.com/recipeImages/' +
                                  recipeMaker[index].id.toString() +
                                  '-240x150.jpg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
