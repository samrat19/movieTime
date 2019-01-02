import 'package:flutter/material.dart';
import 'package:movitm/nowplaying.dart';
import 'package:movitm/upcoming.dart';
import 'package:movitm/toprated.dart';
import 'package:movitm/popular.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(new MaterialApp(
  theme: new ThemeData(primarySwatch: Colors.red),
  home: new MyPage(),
  debugShowCheckedModeBanner: false,
 )
);

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: ListView(
        children: <Widget>[
          Container(
            color: Colors.redAccent,
            child: Text("Now Playing Movie",style: TextStyle(fontSize: 30.0,color: Colors.white),),
          ),
          Container(
            height: 350.0,
            child: Movie(),
          ),
          Container(
            color: Colors.deepPurpleAccent,
            child: Text("Upcoming Movie",
              textAlign: TextAlign.end,
              style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white
              ),
            ),
          ),
          Container(
            height: 350.0,
            child: UpcomingMovie(),
          ),
          Container(
            color: Colors.orangeAccent,
            child: Text("Top rated Movie",
              style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white
              ),
            ),
          ),
          Container(
            height: 350.0,
            child: TopRatedMovie(),
          ),
          Container(
            color: Colors.teal,
            child: Text("Popular Movie",
              textAlign: TextAlign.end,
              style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white
              ),
            ),
          ),
          Container(
            height: 350.0,
            child: PopularMovie(),
          )
        ],
      )
    );
  }
}



