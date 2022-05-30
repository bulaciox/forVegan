import 'package:flutter/material.dart';
import 'package:for_vegan/konstants.dart';

class AddPage extends StatelessWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: kColorGrey,
        margin: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Add',
              style: kTextStyleTitle,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/add_recipe');
                },
                child: Card(
                  color: kColorPurple,
                  child: Stack(
                    children: <Widget>[
                      Image.asset('assets/images/add1.png'),
                      Positioned(
                          bottom: 32,
                          right: 10,
                          child: Text('Add recipe', style: kTextStyleAdd)),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/send_suggestions');
                  },
                  child: Card(
                      color: kColorPurple,
                      child: Stack(
                        children: <Widget>[
                          Image.asset('assets/images/add2.png'),
                          Positioned(
                              bottom: 32,
                              right: 10,
                              child: Text('Send suggestions',
                                  style: kTextStyleAdd)),
                        ],
                      ))),
            ),
          ],
        ),
      ),
    );
  }
}
