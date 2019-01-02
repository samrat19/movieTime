import 'package:flutter/material.dart';
import 'package:movitm/nowplaying.dart';
import 'package:movitm/upcoming.dart';
import 'package:movitm/toprated.dart';
import 'package:movitm/popular.dart';


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
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text("MovieTm"),
      ),
      body: ListView(
        children: <Widget>[
          Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            children: <Widget>[
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  clipBehavior: Clip.hardEdge,
                  child:    Container(
                    color: Colors.redAccent,
                    child: Text("  Now Playing Movie  ",style: TextStyle(fontSize: 30.0,color: Colors.white),),
                  ),
                ),
              )
            ],
          ),
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40.0),
              clipBehavior: Clip.hardEdge,
              child: Container(
                height: 250.0,
                color: Colors.redAccent,
                child: Movie(),
              ),
            ),
          ),
          Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.end,
            children: <Widget>[
              Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    clipBehavior: Clip.hardEdge,
                    child:  Container(
                    color: Colors.deepPurpleAccent,
                    child: Text("  Upcoming Movie  ",
                      style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(40.0),
                clipBehavior: Clip.hardEdge,
              child: Container(
                height: 250.0,
                child: UpcomingMovie(),
              ),
            ),
          ),
          Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.center,
            children: <Widget>[
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  clipBehavior: Clip.hardEdge,
                  child:   Container(
                    color: Colors.orangeAccent,
                    child: Text("  Top rated Movie  ",
                      style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(40.0),
                clipBehavior: Clip.hardEdge,
              child:  Container(
                height: 250.0,
                child: TopRatedMovie(),
              ),
            ),
          ),
          Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.end,
            children: <Widget>[
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  clipBehavior: Clip.hardEdge,
                  child:   Container(
                    color: Colors.teal,
                    child: Text("  Popular Movie  ",
                      style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40.0),
              clipBehavior: Clip.hardEdge,
              child: Container(
                height: 250.0,
                child: PopularMovie(),
              ),
            ),
          )
        ],
      )
    );
  }
}



