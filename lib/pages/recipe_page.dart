// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:for_vegan/konstants.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toggle_switch/toggle_switch.dart';
// import 'package:share_plus/share_plus.dart';
import 'package:flutter_html/flutter_html.dart';

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
  var recIns = '';
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
        FirebaseFirestore.instance.collection('Recipes');
    recipes
        .doc(widget.id.toString())
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      final allData = documentSnapshot;
      // print(finalData);
      setState(() {
        finalData = (allData.data())!;
        recTitle = allData.get('title');
        recId = allData.get('id').toString();
        recTime = allData.get('time');
        recImg = allData.get('image');
        recIng = allData.get('ingredients');
        recIns = allData.get('instructions');
      });
    });

    addTofav() {
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
            users.doc(user_Id).update(
              {
                'Favorite_Recipes': FieldValue.arrayUnion([
                  finalData,
                ]),
              },
            ).then((value) {
              print('updated');
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
          FirebaseFirestore.instance.collection('RecipsReport');
      reports
          .add({'Error message': reportText, 'Recipe_Id': widget.id.toString()})
          .then((value) => {
                const SnackBar(
                  content: Text('Sucessfully accepted !'),
                ),
              })
          // ignore: invalid_return_type_for_catch_error
          .catchError((error) => const SnackBar(
                content: Text("Something went wrong!"),
              ));
      ;
    }

    var shareText =
        "Recipes Name: $recTitle \nRecipes Time: $recTime min \nRecipes Ingredients: $recIng \nRecipes Instructions: $recIns";

    return Scaffold(
      backgroundColor: kColorGrey,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: size.height * 0.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(recImg), fit: BoxFit.cover, scale: 1),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24),
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
                color: kColorGrey,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            //height: 15,

                            child: FittedBox(
                              child: Text(recTitle,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                          SizedBox(width: 15),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              GestureDetector(
                                onTap: (() async =>
                                    await Share.share(shareText)),
                                child:
                                    Image.asset('assets/icons/icon_share.png'),
                              ),
                              SizedBox(width: 7),
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
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
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
                      inactiveBgColor: Color.fromRGBO(227, 232, 235, 1.0),
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
                    const SizedBox(height: 15),
                    Visibility(
                      visible: switchValue == 1 ? isVisible : !isVisible,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Table(
                          //border: TableBorder.all(),
                          children: [
                            ...recIng.map(
                              (ing) => buildRow([ing]),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Visibility(
                      visible: switchValue == 0 ? isVisible : !isVisible,
                      child: Column(
                        children: <Widget>[
                          /*Text(
                            recIns,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          )*/
                          Html(
                            data: recIns,
                            style: {
                              'body': Style(
                                fontFamily: 'Poppins',
                                fontSize: FontSize.larger,
                              ),
                            },
                          ),
                        ],
                      ),
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
