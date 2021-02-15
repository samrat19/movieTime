import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movitm/assets/api_url.dart';
import 'package:movitm/logic/model/movie_model.dart';
import 'package:movitm/logic/movie_response.dart';
import 'package:http/http.dart' as http;

class ViewAllScreen extends StatefulWidget {
  final String segment;
  final List<MovieModel> movies;
  final int totalPage;

  const ViewAllScreen({Key key, @required this.segment, @required this.movies, this.totalPage})
      : super(key: key);

  @override
  _ViewAllScreenState createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {
  ScrollController controller = ScrollController();
  bool scrolling = false;
  bool loading = false;

  @override
  void initState() {
    print(widget.movies.length.toString());
    // controller = ScrollController(initialScrollOffset: 0.0);
    controller.addListener(() {
      if (controller.position.pixels ==
          controller.position.maxScrollExtent) {
        if(widget.totalPage >= 2 ){
          fetchMovies();
        }
      }
    });
    super.initState();
  }

  fetchMovies(){
    for(int i = 2 ; i<widget.totalPage ; i++){
      fetchMoreMovies(i);
    }
  }

  fetchMoreMovies(int page) async {

    setState(() {
      loading = true;
    });

    String url = 'https://api.themoviedb.org/3/movie/popular?api_key=e151ccdde6fbf9ea2d84c67dfb0a920c&language=en-US&page=$page';
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    var fetched =  MovieResponse.fromJson(json.decode(response.body)).movieList;

    setState((){
      loading = false;
     // await Future.delayed(Duration(seconds: 2));
      widget.movies.addAll(fetched);
      print(widget.movies.length.toString());
    });
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Container(
          height: height,
          width: width,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: SingleChildScrollView(
              controller: controller,
              child: Column(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.arrow_back_ios_outlined,
                            color: Colors.blueGrey[900], size: 25),
                      ),
                      Text(
                        widget.segment,
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.blueGrey[900],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  loading?CupertinoActivityIndicator():Wrap(
                    runSpacing: 10,
                    direction: Axis.horizontal,
                    children: List.generate(
                        widget.movies.length+1,
                        (index) {
                          return index == widget.movies.length?CupertinoActivityIndicator():Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ViewAllMoviePosterWidget(
                                movie: widget.movies[index],
                              ),
                            );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ViewAllMoviePosterWidget extends StatelessWidget {
  final MovieModel movie;

  const ViewAllMoviePosterWidget({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String imagePath = movie.posterPath == null?'https://www.pngrepo.com/download/34896/movie.png':ApiURL.posterBaseURL+movie.posterPath;
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(0),
      child: Container(
        width: width * 0.3,
        height: height * 0.2,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.contain,
            image: NetworkImage(imagePath),
          ),
        ),
      ),
    );
  }
}
