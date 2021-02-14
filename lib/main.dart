import 'package:flutter/material.dart';
import 'package:movitm/logic/bloc/home_screen_bloc.dart';
import 'package:movitm/logic/model/movie_model.dart';
import 'package:movitm/screens/home_screen.dart';
import 'package:provider/provider.dart';

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
              gradient: LinearGradient(
                colors: [
                  Colors.deepPurpleAccent,
                  Colors.indigo[900],
                  Colors.black
                ],
                begin: Alignment(0, 1.6),
                end: Alignment(0, -1),
              ),
            ),
          ),
        ));
  }
}
