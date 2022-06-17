// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:for_vegan/konstants.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toggle_switch/toggle_switch.dart';

class RecipePage extends StatefulWidget {
  final int id;
  const RecipePage({Key? key, required this.id}) : super(key: key);
  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  var switchValue = 0;
  bool isVisible = true;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var recTitle = '';
  var recId = '';
  var recTime = '';
  var recImg = '';
  List recIng = [];
  List recSteps = [];
  var reportText = '';
  final _auth = FirebaseAuth.instance;
  var finalData = Object();
  bool fav = false;

  var user_Id = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    TableRow buildRow(List<String> cells) => TableRow(
        children: cells
            .map((cell) => Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    cell,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16.0,
                    ),
                  ),
                ))
            .toList());
    CollectionReference recipes =
        FirebaseFirestore.instance.collection('recipes');
    try {
      recipes
          .doc(widget.id.toString())
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        final allData = documentSnapshot;
        setState(() {
          finalData = (allData.data())!;
          recTitle = allData.get('title').toString();
          recId = allData.get('id').toString();
          recTime = allData.get('time').toString();
          recImg = allData.get('image').toString();
          recIng = allData.get('ingredients');
          recSteps = allData.get('steps');
        });
      });
    } catch (e) {
      print(e);
    }

    addTofav() {
      _auth.authStateChanges().listen((User? user) {
        if (user == null) {
          // print(user?.uid);
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
            users.doc(user_Id).update(
              {
                'Favorite_Recipes': FieldValue.arrayUnion([
                  finalData,
                ]),
              },
            ).then((value) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Added to the favourite"),
              ));
              setState(() {
                fav = true;
              });
            });
          });
        }
      });
    }

    sendReport(value) {
      CollectionReference reports =
          FirebaseFirestore.instance.collection('recipeReports');
      reports
          .add({
            'Error message': reportText,
            'Recipe_Id': widget.id.toString(),
            'User_email': _auth.currentUser?.email
          })
          .then(
            (value) => {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Sucessfully accepted !"),
              )),
              reportText = ''
            },
          )
          // ignore: invalid_return_type_for_catch_error
          .catchError((error) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Something went wrong!"),
            ));
          });
    }

    var shareText =
        "Recipes Name: $recTitle \nRecipes Time: $recTime min \nRecipes Ingredients: $recIng \nRecipes Instructions: $recSteps";
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: size.height * 0.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(recImg), fit: BoxFit.cover, scale: 1),
              ),
              child: SafeArea(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              context: context,
                              builder: (context) => Padding(
                                padding: const EdgeInsets.all(17.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Report an error in the recipe',
                                        style: kTextStyleTitle),
                                    SizedBox(height: 13),
                                    TextField(
                                        onChanged: ((value) =>
                                            reportText = value),
                                        maxLines: 7,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: kColorPurple)),
                                          hintText: 'Describe the error here',
                                          hintStyle: kTextStyleTextField,
                                        ),
                                        keyboardType: TextInputType.text),
                                    SizedBox(height: 25),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              sendReport(reportText);
                                              Navigator.of(context)
                                                  .pop(context);
                                            },
                                            child: Container(
                                              width: 206,
                                              height: 54,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.0)),
                                                  color: kColorPurple),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  Text('Send',
                                                      style:
                                                          kTextStylAddButton),
                                                  Icon(
                                                    Icons.arrow_forward,
                                                    color: Colors.white,
                                                  )
                                                ],
                                              ),
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          child: Image.asset('assets/icons/icon_inform.png')),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset('assets/icons/icon_close.png')),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: size.height * 0.35),
              width: double.infinity,
              //color: Colors.red,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(recTitle,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      GestureDetector(
                        onTap: (() async => await Share.share(shareText)),
                        child: Image.asset('assets/icons/icon_share.png'),
                      ),
                      // SizedBox(width: 7),
                      GestureDetector(
                        onTap: (() async => await addTofav()),
                        child: !fav
                            ? Image.asset(
                                'assets/icons/icon_like.png',
                              )
                            : Image.asset(
                                'assets/icons/icon_like2.png',
                              ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(width: 25),
                      Icon(Icons.local_fire_department_rounded),
                      SizedBox(width: 5),
                      Text('244 calories', style: kTextStyleIconDetails),
                      SizedBox(width: 15),
                      Icon(Icons.timer),
                      SizedBox(width: 5),
                      Text('$recTime min', style: kTextStyleIconDetails)
                    ],
                  ),
                  SizedBox(height: 20),
                  ToggleSwitch(
                    minWidth: 162.0,
                    minHeight: 48.0,
                    cornerRadius: 90.0,
                    activeBgColors: const [
                      [Colors.white],
                      const [Colors.white]
                    ],
                    customTextStyles: const [
                      TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      )
                    ],
                    activeFgColor: Colors.black,
                    inactiveBgColor: Color.fromARGB(255, 197, 203, 206),
                    inactiveFgColor: Color.fromRGBO(94, 94, 94, 1.0),
                    initialLabelIndex: switchValue,
                    labels: const ["LET\'COOK", 'INGREDIENTS'],
                    radiusStyle: true,
                    onToggle: (index) {
                      setState(() {
                        switchValue = index!;
                      });
                    },
                  ),
                  SizedBox(height: 15),
                  Visibility(
                    visible: switchValue == 1 ? isVisible : !isVisible,
                    child: SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Table(
                          border: TableBorder.all(
                              color: Colors.white,
                              width: 1,
                              borderRadius: BorderRadius.circular(20)),
                          children: [
                            ...recIng.map(
                              (ing) => buildRow([ing]),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: switchValue == 0 ? isVisible : !isVisible,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ...recSteps.map(
                          (st) => Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                st,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              )),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _steps() {
  return Container(
    child: Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.yellow,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Text('1'),
          ),
        ),
        SizedBox(width: 5),
        Expanded(
          child: Text(
              'Cut the pumpkin. Cut the skin off and scrape seeds out. Cut into chunks.'),
        ),
      ],
    ),
  );
}

// void showBottomSheet(BuildContext context) => showModalBottomSheet(
//       //enableDrag: false,
//       //isDismissible: false,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(24),
//           topRight: Radius.circular(24),
//         ),
//       ),
//       context: context,
//       builder: (context) => Padding(
//         padding: const EdgeInsets.all(17.0),
//         child: Column(
//           //mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text('Report an error in the recipe', style: kTextStyleTitle),
//             SizedBox(height: 13),
//             TextField(
//                 maxLines: 7,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: kColorPurple)),
//                   hintText: 'Describe the error here',
//                   hintStyle: kTextStyleTextField,
//                 ),
//                 keyboardType: TextInputType.text),
//             SizedBox(height: 25),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 GestureDetector(
//                     onTap: () {
//                       // sendReport();
//                     },
//                     child: Container(
//                       width: 206,
//                       height: 54,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                           color: kColorPurple),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: <Widget>[
//                           Text('Send', style: kTextStylAddButton),
//                           Icon(
//                             Icons.arrow_forward,
//                             color: Colors.white,
//                           )
//                         ],
//                       ),
//                     )),
//               ],
//             )
//           ],
//         ),
//       ),
//     );

/*
* ListTile(
            leading: Icon(Icons.link),
            title: Text('Copy link'),
            onTap: () => {},
          ),
* */
