// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:for_vegan/konstants.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:firebase_core/firebase_core.dart';

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
  var recTime = '';
  var recImg = '';
  List recIng = [];
  var recIns = '';

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
                  child: Center(
                    child: Text(cell),
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
      setState(() {
        recTitle = allData.get('title');
        recTime = allData.get('time');
        recImg = allData.get('image');
        recIng = allData.get('ingredients');
        recIns = allData.get('instructions');
      });
    });
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
                            showBottomSheet(context);
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(recTitle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold)),
                        Row(
                          children: <Widget>[
                            Image.asset('assets/icons/icon_share.png'),
                            SizedBox(width: 7),
                            Image.asset(
                              'assets/icons/icon_like.png',
                              scale: 1,
                            ),
                          ],
                        )
                      ],
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
                      activeBgColors: [
                        [Colors.white],
                        [Colors.white]
                      ],
                      customTextStyles: [
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
                      labels: ["LET\'COOK", 'INGREDIENTS'],
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
                          Text(
                            recIns,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          )
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

void showBottomSheet(BuildContext context) => showModalBottomSheet(
      //enableDrag: false,
      //isDismissible: false,
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
          //mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Report an error in the recipe', style: kTextStyleTitle),
            SizedBox(height: 13),
            TextField(
                maxLines: 7,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kColorPurple)),
                  hintText: 'Describe the error here',
                  hintStyle: kTextStyleTextField,
                ),
                keyboardType: TextInputType.text),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(context);
                    },
                    child: Container(
                      width: 206,
                      height: 54,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: kColorPurple),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text('Send', style: kTextStylAddButton),
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

/*
* ListTile(
            leading: Icon(Icons.link),
            title: Text('Copy link'),
            onTap: () => {},
          ),
* */
