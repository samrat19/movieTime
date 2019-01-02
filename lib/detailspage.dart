import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {

  final String poster;
  final String story;

  DetailsPage(this.poster,this.story);

  @override
  _DetailsPageState createState() => _DetailsPageState(this.poster,this.story);
}

class _DetailsPageState extends State<DetailsPage> {

  final String poster;
  final String story;
  _DetailsPageState(this.poster,this.story);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              child: Image.network(this.poster),
            ),
            Container(
              child: Text(this.story,style: TextStyle(fontSize: 25.0,color: Colors.deepPurple,),),
            )
          ],
        )
      ),
    );
  }
}
