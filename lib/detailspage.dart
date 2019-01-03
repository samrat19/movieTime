import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {

  final String poster;
  final String story;
  final String title;

  DetailsPage(this.poster,this.story,this.title);

  @override
  _DetailsPageState createState() => _DetailsPageState(this.poster,this.story,this.title);
}

class _DetailsPageState extends State<DetailsPage> {

  final String poster;
  final String story;
  final String title;

  _DetailsPageState(this.poster,this.story,this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              child: Image.network(this.poster),
            ),
            Container(
              height: 30.0,
              color: Colors.indigo,
            ),
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                clipBehavior: Clip.hardEdge,
                child: Container(
                  height: 300.0,
                    color: Colors.indigo,
                    child: ListView(
                      children: <Widget>[
                         Text(this.story,style: TextStyle(fontSize: 20.0,color: Colors.white),),
                      ],
                    ),
                )
              )
            ),
          ],
        )
      ),
    );
  }
}
