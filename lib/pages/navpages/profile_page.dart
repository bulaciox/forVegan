import 'package:flutter/material.dart';

import 'package:for_vegan/konstants.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Profile', style: kTextStyleTitle),
              ],
            ),
            Image.asset("assets/images/avatar_user.png"),
            SizedBox(height: 10.0),
            Text(
              'Marta Salmeron Blas',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 17.52,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(7.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(children: <Widget>[
                      Icon(Icons.person),
                      SizedBox(width: 10),
                      Text('Account preferences', style: kTextStyleProfile),
                      Expanded(child: SizedBox()),
                      Icon(Icons.arrow_forward)
                    ]),
                    Row(children: <Widget>[
                      Icon(Icons.language),
                      SizedBox(width: 10),
                      Text('Language', style: kTextStyleProfile),
                      Expanded(child: SizedBox()),
                      Icon(Icons.arrow_forward)
                    ]),
                    Row(children: <Widget>[
                      Icon(Icons.star),
                      SizedBox(width: 10),
                      Text('Rate app', style: kTextStyleProfile),
                      Expanded(child: SizedBox()),
                      Icon(Icons.arrow_forward)
                    ]),
                    Row(children: <Widget>[
                      Icon(Icons.share),
                      SizedBox(width: 10),
                      Text('Share App', style: kTextStyleProfile),
                      Expanded(child: SizedBox()),
                      Icon(Icons.arrow_forward)
                    ]),
                    Row(children: <Widget>[
                      Icon(Icons.receipt),
                      SizedBox(width: 10),
                      Text('Acknowledgements', style: kTextStyleProfile),
                      Expanded(child: SizedBox()),
                      Expanded(child: SizedBox()),
                      Icon(Icons.arrow_forward)
                    ]),
                    Row(children: <Widget>[
                      Icon(Icons.shield),
                      SizedBox(width: 10),
                      Text('Privacy Police', style: kTextStyleProfile),
                      Expanded(child: SizedBox()),
                      Icon(Icons.arrow_forward)
                    ]),
                    Row(children: <Widget>[
                      Icon(Icons.file_copy_rounded),
                      SizedBox(width: 10),
                      Text('Terms of service', style: kTextStyleProfile),
                      Expanded(child: SizedBox()),
                      Icon(Icons.arrow_forward)
                    ]),
                    Row(children: <Widget>[
                      Icon(Icons.logout),
                      SizedBox(width: 10),
                      Text('Logout', style: kTextStyleProfile),
                      Expanded(child: SizedBox()),
                      Icon(Icons.arrow_forward)
                    ]),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
