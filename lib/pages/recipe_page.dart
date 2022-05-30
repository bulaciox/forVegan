import 'package:flutter/material.dart';
import 'package:for_vegan/konstants.dart';
import 'package:toggle_switch/toggle_switch.dart';

class RecipePage extends StatelessWidget {
  const RecipePage({Key? key}) : super(key: key);

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
                image: AssetImage('assets/images/imageimagen_detail.png'),
                fit: BoxFit.cover,
              )),
              child: SafeArea(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset('assets/icons/icon_close.png')),
                    ),
                  ],
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
                        Text('Pumpkin Soup', style: kTextStyleTitleRecipe),
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
                        Text('24 min', style: kTextStyleIconDetails)
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      child: Table(
                        //border: TableBorder.all(),

                        children: [
                          buildRow(['Pumpkin', '1']),
                          buildRow(['Onion', '1']),
                          buildRow(['Garlic', '1']),
                          buildRow(['Milk', '0.5 L']),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Column(
                      children: <Widget>[
                        _steps(),
                        SizedBox(height: 7),
                        _steps(),
                        SizedBox(height: 7),
                        _steps(),
                        SizedBox(height: 7),
                        _steps(),
                        SizedBox(height: 7),
                        _steps(),
                        SizedBox(height: 7),
                        _steps(),
                      ],
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

/*
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
                          initialLabelIndex: 1,
                          totalSwitches: 2,
                          labels: ["LET\'COOK", 'INGREDIENTS'],
                          radiusStyle: true,
                          onToggle: (index) {
                            print('switched to: $index');
                          },
                        ),

*/
