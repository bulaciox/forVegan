import 'package:flutter/material.dart';
import '../../konstants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: kColorGrey,
        margin: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Trending now', style: kTextStyleTitle),
            Container(
              height: 238,
              //color: Colors.red,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  _cartaTrendy(context),
                  _cartaTrendy(context),
                  _cartaTrendy(context),
                  _cartaTrendy(context),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text('Popular categories', style: kTextStyleTitle),
            Container(
              height: 40,
              //color: Colors.blueAccent,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  _cartaCategoria('For breakfast'),
                  _cartaCategoria('For dinner'),
                  _cartaCategoria('For launch'),
                  _cartaCategoria('Asian'),
                  _cartaCategoria('Desserts'),
                ],
              ),
            ),
            SizedBox(height: 100),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/recipe');
              },
              child: Center(
                child: Container(
                  color: kColorPurple,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Receta'),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _cartaCategoria(String text) {
  return Card(
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: Color.fromRGBO(122, 122, 199, 1.0),
          ),
        ),
      ),
    ),
  );
}

Widget _cartaTrendy(BuildContext context) {
  return GestureDetector(
    child: Card(
      //elevation: 16, //sombreado
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 280,
            height: 180,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/fav_img1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('French toast', style: kTextStyleCardText),
          )
        ],
      ),
    ),
  );
}
