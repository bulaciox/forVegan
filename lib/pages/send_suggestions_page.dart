import 'package:flutter/material.dart';
import 'package:for_vegan/konstants.dart';

class SendSuggestionsPage extends StatelessWidget {
  const SendSuggestionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kColorGrey,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Send suggestions',
                  style: kTextStyleTitle,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset('assets/icons/icon_close.png')),
              ],
            ),
            SizedBox(height: 12),
            Text('Title', style: kTextStylAddRecipe),
            SizedBox(height: 5),
            TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kColorPurple)),
                  hintText: 'Insert title here',
                  hintStyle: kTextStyleTextField,
                ),
                keyboardType: TextInputType.text),
            SizedBox(height: 8),
            Text('Argument', style: kTextStylAddRecipe),
            SizedBox(height: 5),
            TextField(
                maxLines: 12,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kColorPurple)),
                  hintText: 'Insert argument here',
                  hintStyle: kTextStyleTextField,
                ),
                keyboardType: TextInputType.text),
            SizedBox(height: 220),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
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
    ));
  }
}
