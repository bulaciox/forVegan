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

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorGrey,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Discover', style: kTextStyleTitle),
              const SizedBox(height: 10),
              TextField(
                controller: controller,
                onChanged: (val) {
                  setState(() {
                    name = val;
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        controller.text = "";
                        name = "";
                      });
                    },
                  ),
                  hintText: 'Search for your desired recipe',
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: kColorPurple)),
                  hintStyle: kTextStyleTextField,
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 15),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('recipes')
                      .snapshots(),
                  builder: (context, snapshots) {
                    return (snapshots.connectionState ==
                            ConnectionState.waiting)
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
                                  child: Card(
                                    //elevation: 16, //sombreado
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    clipBehavior: Clip.antiAlias,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                            width: 380,
                                            height: 100,
                                            child: Image.network(
                                              data['image'],
                                              fit: BoxFit.fitWidth,
                                              height: 120,
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 5),
                                          child: Text(data['title'],
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              style: const TextStyle(
                                                  fontSize: 17)),
                                        )
                                      ],
                                    ),
                                  ),
                                );
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
                                  child: Card(
                                    //elevation: 16, //sombreado
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    clipBehavior: Clip.antiAlias,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                            width: 380,
                                            height: 100,
                                            child: Image.network(
                                              data['image'],
                                              fit: BoxFit.fitWidth,
                                              height: 120,
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 5),
                                          child: Text(data['title'],
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              style: const TextStyle(
                                                  fontSize: 17)),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }
                              return Container();
                            });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
