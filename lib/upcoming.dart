import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class UpcomingMovie extends StatefulWidget {
  @override
  _MovieState createState() => _MovieState();
}

class _MovieState extends State<UpcomingMovie> {

  final String url = "https://api.themoviedb.org/3/movie/upcoming?api_key=e151ccdde6fbf9ea2d84c67dfb0a920c";
  List data;
  bool isdataloaed = false;

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var response = await http.get(

        //encoding url
        Uri.encodeFull(url),
        headers: {"Accept": "application/json"});

    print(response.body);

    setState(() {
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['results'];
      isdataloaed = true;
    });

    return "Success";
  }

  //String poster="https://image.tmdb.org/t/p/w500"+data[index]['title'];

  @override
  Widget build(BuildContext context) {
    if(isdataloaed == false){
      return Scaffold(
        backgroundColor: Colors.white,
        body: new Center(
          child: CircularProgressIndicator(backgroundColor: Colors.teal,strokeWidth: 6.0,),
        ),
      );
    }else{
      return Scaffold(
          body:Container(
            height: 300.0,
            color: Colors.deepPurpleAccent,
            margin: EdgeInsets.symmetric(vertical: 20.0),
            child: ListView.builder(
              itemCount: data == null ? 0 : data.length ,
              itemBuilder: (BuildContext context,int index){
                return Container(
                  padding: EdgeInsets.only(left: 200.0,right: 0.0),
                  height: 300.0,
                  width: 250.0,
                  child: Image.network("https://image.tmdb.org/t/p/w400"+data[index]['poster_path']),
                );
              },
            ),
          )
      );
    }
  }
}