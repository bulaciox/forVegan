import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:for_vegan/pages/recipe_page.dart';

import '../../konstants.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var allRecipes = [];
  var filterRecipes = [];

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
        allRecipes =
            filterRecipes.isEmpty ? allData.toList() : filterRecipes.toList();
      });
    });

    handleSearch(value) {
      CollectionReference recipes =
          FirebaseFirestore.instance.collection('Recipes');
      recipes
          .where('title', isLessThanOrEqualTo: value)
          .get()
          .then((QuerySnapshot querySnapshot) {
        final allData = querySnapshot.docs.map((doc) => doc.data());
        setState(() {
          filterRecipes = allData.toList();
        });
      });
    }

    return SingleChildScrollView(
      child: SafeArea(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Discover', style: kTextStyleTitle),
              SizedBox(height: 12),
              TextField(
                onChanged: (value) => handleSearch(value),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {},
                  ),
                  hintText: 'Search for your desired recipe',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kColorPurple)),
                  hintStyle: kTextStyleTextField,
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 22),
              Container(
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  scrollDirection: Axis.vertical,
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
                                margin: EdgeInsets.symmetric(vertical: 10),
                                clipBehavior: Clip.antiAlias,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: 380,
                                        height: 180,
                                        child: Image.network(
                                          rec['image'],
                                          fit: BoxFit.fitWidth,
                                          height: 150,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
