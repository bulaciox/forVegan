// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, invalid_return_type_for_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:for_vegan/pages/login.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
      try {
        _auth.createUserWithEmailAndPassword(email: email, password: password);
        users
            .add({
              'Full name': fullName,
              'Email': email,
              "Favorite_Recipes": favoriteRecipes
            })
            .then((value) => {
                  SnackBar(
                    content: Text('Sucessfully Signup !'),
                  ),
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Login()))
                })
            .catchError((error) => SnackBar(
                  content: Text("Something went wrong!"),
                ));
      } catch (e) {
        SnackBar(
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
                    onChanged: (value) => fullName = value,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Full Name',
                        hintText: 'Enter your full name'),
                  ),
                ),
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
                    "Signup ➡️",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () => {signup(fullName, email, password)},
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
