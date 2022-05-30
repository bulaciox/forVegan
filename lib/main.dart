import 'package:flutter/material.dart';
import 'package:for_vegan/pages/add_recipe_page.dart';
import 'package:for_vegan/pages/navpages/main_page.dart';
import 'package:for_vegan/pages/recipe_page.dart';
import 'package:for_vegan/pages/send_suggestions_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => MainPage(),
        '/recipe': (BuildContext context) => RecipePage(),
        '/add_recipe': (BuildContext context) => AddRecipePage(),
        '/send_suggestions': (BuildContext context) => SendSuggestionsPage(),
      },
    );
  }
}
