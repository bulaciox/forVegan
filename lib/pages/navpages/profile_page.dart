import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:for_vegan/konstants.dart';
import 'package:for_vegan/pages/welcome_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Profile', style: kTextStyleTitle),
              ],
            ),
            Image.asset("assets/images/avatar_user.png"),
            const SizedBox(height: 10.0),
            const Text(
              'Marta Salmeron Blas',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 17.52,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(7.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(children: <Widget>[
                      const Icon(Icons.person),
                      const SizedBox(width: 10),
                      Text('Account preferences', style: kTextStyleProfile),
                      const Expanded(child: SizedBox()),
                      const Icon(Icons.arrow_forward)
                    ]),
                    Row(children: <Widget>[
                      const Icon(Icons.language),
                      const SizedBox(width: 10),
                      Text('Language', style: kTextStyleProfile),
                      const Expanded(child: SizedBox()),
                      const Icon(Icons.arrow_forward)
                    ]),
                    Row(children: <Widget>[
                      const Icon(Icons.star),
                      const SizedBox(width: 10),
                      Text('Rate app', style: kTextStyleProfile),
                      const Expanded(child: SizedBox()),
                      const Icon(Icons.arrow_forward)
                    ]),
                    Row(children: <Widget>[
                      const Icon(Icons.share),
                      const SizedBox(width: 10),
                      Text('Share App', style: kTextStyleProfile),
                      const Expanded(child: SizedBox()),
                      const Icon(Icons.arrow_forward)
                    ]),
                    Row(children: <Widget>[
                      const Icon(Icons.receipt),
                      const SizedBox(width: 10),
                      Text('Acknowledgements', style: kTextStyleProfile),
                      const Expanded(child: SizedBox()),
                      const Expanded(child: SizedBox()),
                      const Icon(Icons.arrow_forward)
                    ]),
                    Row(children: <Widget>[
                      const Icon(Icons.shield),
                      const SizedBox(width: 10),
                      Text('Privacy Police', style: kTextStyleProfile),
                      const Expanded(child: const SizedBox()),
                      const Icon(Icons.arrow_forward)
                    ]),
                    Row(children: <Widget>[
                      const Icon(Icons.file_copy_rounded),
                      const SizedBox(width: 10),
                      Text('Terms of service', style: kTextStyleProfile),
                      const Expanded(child: SizedBox()),
                      const Icon(Icons.arrow_forward)
                    ]),
                    GestureDetector(
                      onTap: () => {
                        _auth.signOut().then((value) =>
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const WelcomePage()),
                                (route) => false)),
                      },
                      child: Row(children: <Widget>[
                        const Icon(Icons.logout),
                        const SizedBox(width: 10),
                        Text('Logout', style: kTextStyleProfile),
                        const Expanded(child: SizedBox()),
                        const Icon(Icons.arrow_forward)
                      ]),
                    )
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
