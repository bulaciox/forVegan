import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:for_vegan/konstants.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({Key? key}) : super(key: key);

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController titleC = TextEditingController();
  TextEditingController categoriesC = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();
  late String title;
  late String categories;
  late String image;
  late String description;
  late String ingredients;
  late String time;
  @override
  Widget build(BuildContext context) {
    CollectionReference recipes =
        FirebaseFirestore.instance.collection('Recipes');

    Future<void> addRecipes(String title, String categories, String image,
        String description, String ingredients, String time) {
      return recipes
          .add({
            'categories': categories,
            'description': description,
            'image': image,
            'ingredients': ingredients,
            'time': time,
            'title': title
          })
          .then((value) => Navigator.pushNamed(context, '/'))
          .catchError((error) => print("Failed to add user: $error"));
    }

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
              SizedBox(height: 2),
              Text('Title', style: kTextStylAddRecipe),
              SizedBox(height: 5),
              TextField(
                  controller: titleC,
                  onChanged: (value) => title = value,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kColorPurple)),
                    hintText: 'Insert title here',
                    hintStyle: kTextStyleTextField,
                  ),
                  keyboardType: TextInputType.text),
              Text('Image', style: kTextStylAddRecipe),
              SizedBox(height: 5),
              TextField(
                  onChanged: (value) => image = value,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kColorPurple)),
                    hintText: 'Insert image here',
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
                            onChanged: (value) => categories = value,
                            controller: categoriesC,
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
                          onChanged: (value) => time = value,
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
                  onChanged: (value) => ingredients = value,
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
                  onChanged: (value) => description = value,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kColorPurple)),
                    hintText: 'Insert steps here',
                    hintStyle: kTextStyleTextField,
                  ),
                  keyboardType: TextInputType.text),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        addRecipes(title, categories, time, description, image,
                            ingredients);
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
