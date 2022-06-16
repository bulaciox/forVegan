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

  final titleController = TextEditingController();
  final imageURLController = TextEditingController();
  final caloriesController = TextEditingController();
  final timeController = TextEditingController();
  final ingredientsController = TextEditingController();
  final instructionsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference recipes =
        FirebaseFirestore.instance.collection('userRecipes');

    Future<void> addRecipes(
        {String? title,
        String? calories,
        String? image,
        String? instructions,
        String? ingredients,
        String? time}) {
      return recipes.add({
        'calories': calories,
        'instructions': instructions,
        'image': image,
        'ingredients': ingredients,
        'time': time,
        'title': title
      }).then(
        (value) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Your recipes adding soon!"),
            ),
          );
        },
      ).catchError(
          (error) => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Something went wrong!"),
              )));
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
                  controller: titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kColorPurple)),
                    hintText: 'Insert title here',
                    hintStyle: kTextStyleTextField,
                  ),
                  keyboardType: TextInputType.text),
              Text('ImageURL', style: kTextStylAddRecipe),
              SizedBox(height: 5),
              TextField(
                  controller: imageURLController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kColorPurple)),
                    hintText: 'Insert imageURL here',
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
                            controller: caloriesController,
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
                          controller: timeController,
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
                  controller: ingredientsController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kColorPurple)),
                    hintText: 'Insert ingredients here',
                    hintStyle: kTextStyleTextField,
                  ),
                  keyboardType: TextInputType.text),
              SizedBox(height: 8),
              Text('Instructions', style: kTextStylAddRecipe),
              SizedBox(height: 5),
              TextField(
                  maxLines: 4,
                  controller: instructionsController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kColorPurple)),
                    hintText: 'Insert instructions here',
                    hintStyle: kTextStyleTextField,
                  ),
                  keyboardType: TextInputType.text),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        addRecipes(
                            title: titleController.text,
                            image: imageURLController.text,
                            calories: caloriesController.text,
                            time: timeController.text,
                            ingredients: ingredientsController.text,
                            instructions: instructionsController.text);
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
