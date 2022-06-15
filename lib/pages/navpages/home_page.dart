// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:for_vegan/pages/recipe_page.dart';
import '../../konstants.dart';
import 'package:firebase_core/firebase_core.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var allRecipes = [];
  var filterRecipes = [];
  bool selected = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference recipes =
        FirebaseFirestore.instance.collection('Recipes');
    recipes.get().then((QuerySnapshot querySnapshot) {
      final allData = querySnapshot.docs.map((doc) => doc.data());
      setState(() {
        allRecipes = allData.toList();
        filterRecipes =
            filterRecipes.isEmpty ? allData.toList() : filterRecipes;
      });
    });

    handleCat(value) {
      CollectionReference recipes =
          FirebaseFirestore.instance.collection('Recipes');
      recipes
          .where('categories', isEqualTo: value)
          .get()
          .then((QuerySnapshot querySnapshot) {
        final allData = querySnapshot.docs.map((doc) => doc.data());
        setState(() {
          filterRecipes = allData.toList();
        });
      });
    }

    // print(filterRecipes);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: Container(
            alignment: Alignment.center,
            // color: kColorGrey,
            margin: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Trending now', style: kTextStyleTitle),
                Container(
                  alignment: Alignment.center,
                  height: 238,
                  //color: Colors.red,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
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
                                  //elevation: 16, //sombreado
                                  clipBehavior: Clip.antiAlias,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          alignment: Alignment.center,
                                          width: 320,
                                          height: 180,
                                          child: Image.network(
                                            rec['image'],
                                            fit: BoxFit.fill,
                                            height: 190,
                                            width: 330,
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 5),
                                        child: Text(rec['title'],
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            style: TextStyle(fontSize: 17)),
                                      )
                                    ],
                                  ),
                                ),
                              ))
                          .toList()
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text('Popular categories', style: kTextStyleTitle),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  height: 40,
                  //color: Colors.blueAccent,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      ...allRecipes
                          .map<Widget>(
                            (cat) => GestureDetector(
                                onTap: () => handleCat(cat['categories']),
                                child: Card(
                                  color: selected ? Colors.red : Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 12.0),
                                    child: Center(
                                      child: Text(
                                        cat['categories'],
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Color.fromRGBO(
                                              122, 122, 199, 1.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                          )
                          .toList(),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  height: 238,
                  //color: Colors.red,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      ...filterRecipes
                          .map<Widget>((rec) => GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        RecipePage(id: rec['id']),
                                  ),
                                ),
                                child: Card(
                                  //elevation: 16, //sombreado
                                  clipBehavior: Clip.antiAlias,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          alignment: Alignment.center,
                                          width: 320,
                                          height: 180,
                                          child: Image.network(
                                            rec['image'],
                                            fit: BoxFit.fill,
                                            height: 190,
                                            width: 330,
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 5),
                                        child: Text(rec['title'],
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            style: TextStyle(fontSize: 17)),
                                      )
                                    ],
                                  ),
                                ),
                              ))
                          .toList()
                          .reversed
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _cartaCategoria(String text) {
  return Card(
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: Color.fromRGBO(122, 122, 199, 1.0),
          ),
        ),
      ),
    ),
  );
}

Widget _cartaTrendy(BuildContext context) {
  return GestureDetector(
    child: Card(
      //elevation: 16, //sombreado
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 280,
            height: 180,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/fav_img1.png'),
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
