import 'package:flutter/material.dart';
import 'package:for_vegan/konstants.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
              Text('Login', style: kTextStyleTitle),
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
                          //hintText: 'Password',
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
                      Text('Dont have an account?', style: kTextStylAddRecipe),
                      GestureDetector(
                        child: Text('Create account', style: kTextStyleProfile),
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/register');
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
