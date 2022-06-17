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
  var email = '';
  @override
  void initState() {
    super.initState();
  }

  Widget cardProfile(IconData icon, String text) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => SimpleDialog(
            title: const Text('Not available'),
            contentPadding: const EdgeInsets.all(20.0),
            children: <Widget>[
              const Text('This function will be added in future updates'),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Close'),
                  ),
                ],
              )
            ],
          ),
        );
      },
      child: Row(children: <Widget>[
        Icon(icon),
        const SizedBox(width: 10),
        Text(text, style: kTextStyleProfile),
        const Expanded(child: SizedBox()),
        const Icon(Icons.arrow_forward)
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      email = (_auth.currentUser?.email)!;
    });
    setState(() {});
    return Scaffold(
      backgroundColor: kColorGrey,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Row(
                children: const <Widget>[
                  Text('Profile', style: kTextStyleTitle),
                ],
              ),
              Image.asset("assets/images/avatar_user.png"),
              const SizedBox(height: 10.0),
              Text(
                email,
                style: const TextStyle(
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
                      cardProfile(Icons.person, 'Account preferences'),
                      cardProfile(Icons.language, 'Language'),
                      cardProfile(Icons.star, 'Rate app'),
                      cardProfile(Icons.share, 'Share App'),
                      cardProfile(Icons.receipt, 'Acknowledgements'),
                      cardProfile(Icons.shield, 'Privacy Police'),
                      cardProfile(Icons.file_copy_rounded, 'Terms of service'),
                      GestureDetector(
                        onTap: () => {
                          _auth.signOut().then((value) =>
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const WelcomePage()),
                                  (route) => false)),
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Sucessfully logout!"),
                          )),
                        },
                        child: Row(children: const <Widget>[
                          Icon(Icons.logout),
                          SizedBox(width: 10),
                          Text('Logout', style: kTextStyleProfile),
                          Expanded(child: SizedBox()),
                          Icon(Icons.arrow_forward)
                        ]),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
