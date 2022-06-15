import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:for_vegan/pages/recipe_page.dart';

import '../../konstants.dart';

class FavPage extends StatefulWidget {
  const FavPage({Key? key}) : super(key: key);

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var allRecipes = [];
  final _auth = FirebaseAuth.instance;
  var user_Id = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print(user?.uid);
      } else {
        CollectionReference users =
            FirebaseFirestore.instance.collection('Users');
        users
            .where("Email", isEqualTo: user.email)
            .get()
            .then((QuerySnapshot querySnapshot) {
          final userId = querySnapshot.docs.map((doc) => doc.id).toList();
          for (var element in userId) {
            setState(() {
              user_Id = element.toString();
            });
          }
        });
        users.doc(user_Id).get().then((DocumentSnapshot documentsnapshot) {
          setState(() {
            allRecipes = documentsnapshot.get('Favorite_Recipes');
          });
        });
      }
    });

    // print(allRecipes);
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Favourites', style: kTextStyleTitle),
            const SizedBox(height: 9),
            Expanded(
                //Cuando son de tamaño variable usar ListView.builder
                child: allRecipes.isEmpty
                    ? const Text("Nothing in favourites")
                    : ListView(
                        children: [
                          ...allRecipes
                              .map<Widget>((rec) => GestureDetector(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            RecipePage(id: rec['id']),
                                      ),
                                    ),
                                    child: Card(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      elevation: 16, //sombreado
                                      clipBehavior: Clip.antiAlias,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Ink.image(
                                            height: 150,
                                            image: NetworkImage(rec['image']),
                                            fit: BoxFit.cover,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(rec['title'],
                                                style: kTextStyleCardText),
                                          )
                                        ],
                                      ),
                                    ),
                                  ))
                              .toList()
                        ],
                      )),
          ],
        ),
      ),
    );
  }

  Widget _cartaFavorito1() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Card(
        elevation: 16, //sombreado
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Ink.image(
              height: 120,
              image: const AssetImage('assets/images/fav_img1.png'),
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('French toast', style: kTextStyleCardText),
            )
          ],
        ),
      ),
    );
  }

  Widget _cartaFavorito2() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Card(
        elevation: 16, //sombreado
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 120,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/images/fav_img1.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('French toast', style: kTextStyleCardText),
            )
          ],
        ),
      ),
    );
  }
}
