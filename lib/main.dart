import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:for_vegan/pages/Start_screen.dart';
import 'package:for_vegan/pages/add_recipe_page.dart';
import 'package:for_vegan/pages/navpages/main_page.dart';
import 'package:for_vegan/pages/recipe_page.dart';
import 'package:for_vegan/pages/send_suggestions_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:for_vegan/pages/signup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _auth = FirebaseAuth.instance;

  bool userisSignin = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        setState(() {
          userisSignin = false;
        });
      } else {
        setState(() {
          userisSignin = true;
        });
      }
    });
    // print(userisSignin);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: userisSignin ? const MainPage() : const Start(),
      // routes: <String, WidgetBuilder>{
      //   '/': (BuildContext context) => const MainPage(),
      //   // '/recipe': (BuildContext context) => const RecipePage(),
      //   '/add_recipe': (BuildContext context) => const AddRecipePage(),
      //   '/send_suggestions': (BuildContext context) =>
      //       const SendSuggestionsPage(),
      // },
    );
  }
}
