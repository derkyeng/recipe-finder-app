import 'package:flutter/material.dart';
import 'package:recipe_app/utils/http_service.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:url_launcher/url_launcher.dart';

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
                      print(recipeMaker[index].url);
                      _launchURL(recipeMaker[index].url);
                    },
                    child: Container(
                      alignment: Alignment.bottomRight,
                      child: FittedBox(
                        child: Container(
                          color: Color.fromRGBO(204, 223, 252, .3),
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              text: limitText(recipeMaker[index].title),
                              style: TextStyle(
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    offset: Offset(-1.0, -1.0),
                                    color: Colors.black,
                                  ),
                                  Shadow(
                                    offset: Offset(1.0, -1.0),
                                    color: Colors.black,
                                  ),
                                  Shadow(
                                    offset: Offset(1.0, 1.0),
                                    color: Colors.black,
                                  ),
                                  Shadow(
                                    offset: Offset(-1.0, 1.0),
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://spoonacular.com/recipeImages/' +
                                  recipeMaker[index].id.toString() +
                                  '-636x393.jpg'),
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

  String limitText(String text) {
    if (text.length > 15) {
      return text.substring(0, 15) + '...';
    }
    return text;
  }
}

_launchURL(String recipe) async {
  final url = recipe;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
