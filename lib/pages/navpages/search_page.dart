import 'dart:ffi';

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
  String name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Card(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: TextField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search), hintText: 'Search...'),
              onChanged: (val) {
                setState(() {
                  name = val;
                });
              },
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('recipes').snapshots(),
          builder: (context, snapshots) {
            return (snapshots.connectionState == ConnectionState.waiting)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: snapshots.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshots.data!.docs[index].data()
                          as Map<String, dynamic>;
                      if (name.isEmpty) {
                        return GestureDetector(
                            onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        RecipePage(id: data['id']),
                                  ),
                                ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
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
                                          data['image'],
                                          fit: BoxFit.fitWidth,
                                          height: 150,
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 5),
                                      child: Text(data['title'],
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style: TextStyle(fontSize: 17)),
                                    )
                                  ],
                                ),
                              ),
                            ));
                      }
                      if (data['title']
                          .toString()
                          .toLowerCase()
                          .contains(name.toLowerCase())) {
                        return GestureDetector(
                            onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        RecipePage(id: data['id']),
                                  ),
                                ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
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
                                          data['image'],
                                          fit: BoxFit.fitWidth,
                                          height: 150,
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 5),
                                      child: Text(data['title'],
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style: TextStyle(fontSize: 17)),
                                    )
                                  ],
                                ),
                              ),
                            ));
                      }
                      return Container();
                    });
          },
        ));
  }
}
