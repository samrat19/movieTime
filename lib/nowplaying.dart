import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:movitm/detailspage.dart';
import 'package:http/http.dart' as http;


class Movie extends StatefulWidget {
  @override
  _MovieState createState() => _MovieState();
}

class _MovieState extends State<Movie> {

  final String url = "https://api.themoviedb.org/3/movie/now_playing?api_key=e151ccdde6fbf9ea2d84c67dfb0a920c";
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

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body:Container(
          height: 300.0,
          color: Colors.redAccent,
          margin: EdgeInsets.symmetric(vertical: 20.0),
          child: ListView.builder(
            itemCount: data == null ? 0 : data.length ,
            itemBuilder: (BuildContext context,int index){
              return GestureDetector(
                child: Container(
                  padding: EdgeInsets.only(left: 0.0,right: 200.0),
                  height: 300.0,
                  width: 250.0,
                  child: Image.network("https://image.tmdb.org/t/p/w400"+data[index]['poster_path']),
                ),
                onTap: (){
                  String poster = "https://image.tmdb.org/t/p/w400"+data[index]['backdrop_path'];
                  String story = data[index]['overview'];
                  String title = data[index]['title'];
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          DetailsPage(poster,story,title)));
                },
              );
            },
          ),
        )
      );
  }
}