// ignore_for_file: unrelated_type_equality_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:for_vegan/konstants.dart';
import 'package:for_vegan/pages/navpages/main_page.dart';
import 'package:for_vegan/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  var email = '';
  var password = '';
  @override
  Widget build(BuildContext context) {
    void login(email, password) async {
      User? user;
      if (email == '' || password == "") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please fill all the fields !"),
          backgroundColor: Colors.red,
        ));
      } else {
        try {
          UserCredential userCredential =
              await _auth.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
          user = userCredential.user;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Sucessfully Login !"),
          ));
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainPage()),
              (route) => false);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("No user found for this email."),
              backgroundColor: Colors.red,
            ));
            setState(() {
              password = "";
            });
          } else if (e.code == 'wrong-password' || e.code == 'invalid-email') {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Wrong email or password provided."),
              backgroundColor: Colors.red,
            ));
            setState(() {
              password = "";
            });
          }
        }
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
              const Text('Login', style: kTextStyleTitle),
              Column(
                children: <Widget>[
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Email address',
                          style: kTextStylAddRecipe,
                        ),
                        const SizedBox(height: 5),
                        TextField(
                            onChanged: (value) => email = value,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              //hintText: 'Email adress',
                              hintStyle: kTextStyleTextField,
                            ),
                            keyboardType: TextInputType.text),
                      ]),
                  const SizedBox(height: 30),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Password',
                          style: kTextStylAddRecipe,
                        ),
                        const SizedBox(height: 5),
                        TextField(
                            obscureText: true,
                            onChanged: (value) => password = value,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              //hintText: 'Password',
                              hintStyle: kTextStyleTextField,
                            ),
                            keyboardType: TextInputType.text),
                      ]),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () async {
                        login(email, password);
                      },
                      child: Container(
                        width: 206,
                        height: 54,
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            color: Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const <Widget>[
                            Text('Login', style: kTextStylAddButtonPurple),
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
                children: [
                  Column(
                    children: <Widget>[
                      const Text('Dont have an account?',
                          style: kTextStylAddRecipe),
                      GestureDetector(
                        child: const Text('Create account',
                            style: kTextStyleProfile),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterPage()));
                        },
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
