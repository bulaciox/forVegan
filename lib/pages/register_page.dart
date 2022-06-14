import 'package:flutter/material.dart';
import 'package:for_vegan/konstants.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorPurple,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 18.0),
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
                    SizedBox(height: 5),
                    TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          //hintText: 'Email adress',
                          hintStyle: kTextStyleTextField,
                        ),
                        keyboardType: TextInputType.text),
                  ]),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Email adress',
                      style: kTextStylAddRecipe,
                    ),
                    SizedBox(height: 5),
                    TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          //hintText: 'Email adress',
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
                    SizedBox(height: 5),
                    TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          //hintText: 'Email adress',
                          hintStyle: kTextStyleTextField,
                        ),
                        keyboardType: TextInputType.text),
                  ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/main_page');
                      },
                      child: Container(
                        width: 206,
                        height: 54,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
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
                          Navigator.pushReplacementNamed(context, '/login');
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
