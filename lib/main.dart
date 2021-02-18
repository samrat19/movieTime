import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'logic/bloc/home_screen/home_screen_bloc.dart';
import 'screens/homeScreen/home_screen.dart';

main() => runApp(
      MaterialApp(
        home: InitApp(),
      ),
    );

class InitApp extends StatefulWidget {
  @override
  _InitAppState createState() => _InitAppState();
}

class _InitAppState extends State<InitApp> {
  @override
  void initState() {
    HomeScreenBloc().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: HomeScreenBloc().movieStream,
        builder: (_, AsyncSnapshot<HomeScreenMovieContent> snapshot) =>
            snapshot.hasData
                ? Provider<HomeScreenMovieContent>.value(
                    value: snapshot.data, child: HomeScreen())
                : Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
      ),
    );
  }
}
