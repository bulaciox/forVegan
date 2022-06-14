// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:for_vegan/pages/navpages/home_page.dart';
import 'package:for_vegan/pages/navpages/main_page.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  var email = '';
  var password = '';
  @override
  Widget build(BuildContext context) {
    login(email, password) async {
      CollectionReference users =
          FirebaseFirestore.instance.collection('Users');
      try {
        _auth.signInWithEmailAndPassword(email: email, password: password);
        AlertDialog(
          content: Text('Sucessfully Signup !'),
        );
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainPage()),
            (route) => false);
      } catch (e) {
        AlertDialog(
          content: Text("Something went wrong!"),
        );
      }
    }

    return Scaffold(
      body: Container(
        // constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(),
        margin: EdgeInsets.symmetric(vertical: 20),
        child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: TextField(
                    onChanged: (value) => email = value,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter your valid email'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: TextField(
                    onChanged: (value) => password = value,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter valid password'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(
                    "Login ➡️",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () => {login(email, password)},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(15),
                    primary: Colors.purple[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
