import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:for_vegan/konstants.dart';
import 'package:for_vegan/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  var fullName = '';
  var email = '';
  var password = '';
  var favoriteRecipes = [];
  @override
  Widget build(BuildContext context) {
    signup(fullName, email, password) async {
      CollectionReference users =
          FirebaseFirestore.instance.collection('Users');
      User? user;
      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        user = userCredential.user;
        await user!.updateProfile(displayName: fullName);
        user = _auth.currentUser;
        users.add({
          'Full name': fullName,
          'Email': email,
          "Favorite_Recipes": favoriteRecipes
        }).then((value) => {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Sucessfully Signup !"),
              )),
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()))
            });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("The password provided is too weak."),
            backgroundColor: Colors.red,
          ));
          setState(() {
            password = "";
          });
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("The account already exists for that email."),
            backgroundColor: Colors.red,
          ));
          setState(() {
            password = "";
          });
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Something went wrong!"),
        ));
        setState(() {
          password = "";
        });
      }
    }

    return Scaffold(
      backgroundColor: kColorPurple,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 18.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Register', style: kTextStyleTitle),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Name',
                      style: kTextStylAddRecipe,
                    ),
                    const SizedBox(height: 5),
                    TextField(
                        onChanged: (value) => fullName = value,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.black)),
                          //hintText: 'Email adress',
                          hintStyle: kTextStyleTextField,
                        ),
                        keyboardType: TextInputType.text),
                  ]),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Email address',
                      style: kTextStylAddRecipe,
                    ),
                    const SizedBox(height: 5),
                    TextField(
                        onChanged: (value) => email = value,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          //hintText: 'Email address',
                          hintStyle: kTextStyleTextField,
                        ),
                        keyboardType: TextInputType.text),
                  ]),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Password',
                      style: kTextStylAddRecipe,
                    ),
                    const SizedBox(height: 5),
                    TextField(
                        onChanged: (value) => password = value,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.black)),
                          //hintText: 'Email address',
                          hintStyle: kTextStyleTextField,
                        ),
                        keyboardType: TextInputType.text),
                  ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        signup(fullName, email, password);
                      },
                      child: Container(
                        width: 206,
                        height: 54,
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(const Radius.circular(10.0)),
                            color: Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text('Register', style: kTextStylAddButtonPurple),
                            Icon(
                              Icons.arrow_forward,
                              color: kColorPurple,
                            )
                          ],
                        ),
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text('Already have an account?',
                          style: kTextStylAddRecipe),
                      GestureDetector(
                        child: Text('Login', style: kTextStyleProfile),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                        },
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
