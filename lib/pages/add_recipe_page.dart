import 'package:flutter/material.dart';
import 'package:for_vegan/konstants.dart';

class AddRecipePage extends StatelessWidget {
  const AddRecipePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kColorGrey,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Add recipe',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Calories',
                          style: kTextStylAddRecipe,
                        ),
                        SizedBox(height: 5),
                        TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: kColorPurple)),
                              hintText: 'Insert calories here',
                              hintStyle: kTextStyleTextField,
                            ),
                            keyboardType: TextInputType.text),
                      ],
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Time',
                        style: kTextStylAddRecipe,
                      ),
                      SizedBox(height: 5),
                      TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: kColorPurple)),
                            hintText: 'Insert time here',
                            hintStyle: kTextStyleTextField,
                          ),
                          keyboardType: TextInputType.text),
                    ],
                  ))
                ],
              ),
              SizedBox(height: 8),
              Text('Ingredients', style: kTextStylAddRecipe),
              SizedBox(height: 5),
              TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kColorPurple)),
                    hintText: 'Insert ingredients here',
                    hintStyle: kTextStyleTextField,
                  ),
                  keyboardType: TextInputType.text),
              SizedBox(height: 8),
              Text('Steps', style: kTextStylAddRecipe),
              SizedBox(height: 5),
              TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kColorPurple)),
                    hintText: 'Insert steps here',
                    hintStyle: kTextStyleTextField,
                  ),
                  keyboardType: TextInputType.text),
              SizedBox(height: 85),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
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
      ),
    );
  }
}
