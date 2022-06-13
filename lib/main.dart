import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:for_vegan/pages/add_recipe_page.dart';
import 'package:for_vegan/pages/navpages/main_page.dart';
import 'package:for_vegan/pages/recipe_page.dart';
import 'package:for_vegan/pages/send_suggestions_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:for_vegan/pages/welcome_page.dart';
import 'package:for_vegan/pages/login_page.dart';
import 'package:for_vegan/pages/register_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => const MainPage(),
        '/main_page': (BuildContext context) => const MainPage(),
        // '/recipe': (BuildContext context) => const RecipePage(),
        '/add_recipe': (BuildContext context) => const AddRecipePage(),
        '/send_suggestions': (BuildContext context) =>
            const SendSuggestionsPage(),
      },
    );
  }
}
