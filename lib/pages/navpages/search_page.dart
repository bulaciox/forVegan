import 'package:flutter/material.dart';

import '../../konstants.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Discover', style: kTextStyleTitle),
            SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search for your desired recipe',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kColorPurple)),
                hintStyle: kTextStyleTextField,
              ),
              keyboardType: TextInputType.text,
            ),
          ],
        ),
      ),
    );
  }
}
