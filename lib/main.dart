import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tap_the_black/providers/user.dart';
import 'package:tap_the_black/screens/chart_screen.dart';
import 'package:tap_the_black/screens/game_result_screen.dart';
import 'package:tap_the_black/screens/game_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => User(),
      child: MaterialApp(
        title: 'Tap The Black',
        theme: ThemeData(
            primaryColor: Colors.orange[200],
            primaryColorLight: Colors.white,
            primaryColorDark: Colors.black,
            buttonColor: Colors.deepOrange[200],
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  primary: Colors.orange[300],
                  textStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: 26,
                      fontWeight: FontWeight.w400)),
            ),
            backgroundColor: Colors.orange[200],
            scaffoldBackgroundColor: Colors.yellow[50],
            textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.deepOrange[200],
                    textStyle: TextStyle(color: Colors.black54))),
            textTheme: TextTheme(
              bodyText1: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
              ),
              headline1: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  shadows: <Shadow>[
                    Shadow(
                      color: Colors.grey.withOpacity(0.8),
                      blurRadius: 5,
                      offset: Offset(-5, 5),
                    ),
                  ]),
              headline3: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  shadows: <Shadow>[
                    Shadow(
                      color: Colors.grey.withOpacity(0.8),
                      blurRadius: 5,
                      offset: Offset(-5, 5),
                    ),
                  ]),
              headline6: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  shadows: <Shadow>[
                    Shadow(
                      color: Colors.grey.withOpacity(0.8),
                      blurRadius: 5,
                      offset: Offset(-5, 5),
                    ),
                  ]),

            )),

        
        routes: {
          ChartScreen.routeName: (context) => ChartScreen(),
          GameScreen.routeName: (context) => GameScreen(),
          GameResultScreen.routeName: (context) => GameResultScreen(),
        },
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Tap The Black',
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'The easiest game ever!',
              style: Theme.of(context).textTheme.headline3,
            ),
            SizedBox(
              height: 50,
            ),
            Card(
              margin: EdgeInsets.only(bottom: 20),
              elevation: 5,
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.7,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(GameScreen.routeName);
                    },
                    child:
                        Text('Play!', style: TextStyle(color: Colors.black))),
              ),
            ),
            Card(
              margin: EdgeInsets.only(bottom: 20),
              elevation: 5,
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.7,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(ChartScreen.routeName);
                    },
                    child: Text('Top Players',
                        style: TextStyle(color: Colors.black))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
