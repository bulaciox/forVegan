import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:for_vegan/notificationservice.dart';
import 'package:for_vegan/pages/add_recipe_page.dart';
import 'package:for_vegan/pages/navpages/main_page.dart';
import 'package:for_vegan/pages/send_suggestions_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:for_vegan/pages/welcome_page.dart';
import 'package:for_vegan/pages/login_page.dart';
import 'package:for_vegan/pages/register_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
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
      home: userisSignin ? const MainPage() : const WelcomePage(),
      // routes: <String, WidgetBuilder>{
      //   '/': (BuildContext context) => const MainPage(),
      //   // '/recipe': (BuildContext context) => const RecipePage(),
      //   '/add_recipe': (BuildContext context) => const AddRecipePage(),
      //   '/send_suggestions': (BuildContext context) =>
      //       const SendSuggestionsPage(),
      // },
      // routes: <String, WidgetBuilder>{
      //   '/': (BuildContext context) => const WelcomePage(),
      //   '/main_page': (BuildContext context) => const MainPage(),
      //   // '/recipe': (BuildContext context) => const RecipePage(),
      //   '/add_recipe': (BuildContext context) => const AddRecipePage(),
      //   '/send_suggestions': (BuildContext context) =>
      //       const SendSuggestionsPage(),
      //   '/login': (BuildContext context) => const LoginPage(),
      //   '/register': (BuildContext context) => const RegisterPage(),
      // },
    );
  }
}
