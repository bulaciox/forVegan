import 'package:flutter/material.dart';

import '../../konstants.dart';

class FavPage extends StatelessWidget {
  const FavPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Favourites', style: kTextStyleTitle),
            SizedBox(height: 9),
            Expanded(
                //Cuando son de tamaño variable usar ListView.builder
                child: ListView(
              children: [
                _cartaFavorito1(),
                _cartaFavorito1(),
                _cartaFavorito1(),
                _cartaFavorito1(),
                _cartaFavorito1(),
                _cartaFavorito1(),
                _cartaFavorito1(),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget _cartaFavorito1() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Card(
        elevation: 16, //sombreado
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Ink.image(
              height: 120,
              image: AssetImage('assets/images/fav_img1.png'),
              fit: BoxFit.cover,
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

  Widget _cartaFavorito2() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Card(
        elevation: 16, //sombreado
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 120,
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
}
