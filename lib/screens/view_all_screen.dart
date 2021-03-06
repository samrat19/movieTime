import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movitm/logic/model/movie_model.dart';
import 'package:movitm/logic/movie_response.dart';
import 'package:http/http.dart' as http;
import 'package:movitm/tools/app_utils.dart';
import 'package:movitm/tools/movie_poster_widget.dart';

class ViewAllScreen extends StatefulWidget {
  final String segment;
  final List<MovieModel> movies;
  final int totalPage;
  final String url;

  const ViewAllScreen({
    Key key,
    @required this.segment,
    @required this.movies,
    @required this.totalPage,
    @required this.url,
  }) : super(key: key);

  @override
  _ViewAllScreenState createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {
  ScrollController controller = ScrollController();
  bool scrolling = false;
  bool loading = false;
  int currentPage = 2;

  @override
  void initState() {
    print(widget.totalPage.toString());
    // controller = ScrollController(initialScrollOffset: 0.0);
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        if (widget.totalPage >= 2) {
          fetchMovies();
        }
      }
    });
    super.initState();
  }

  fetchMovies() {
    currentPage = widget.totalPage - (widget.totalPage - currentPage);
    fetchMoreMovies(currentPage);
  }


  fetchMoreMovies(int page) async {
    String url = '${widget.url}$page';
    print(url);
    var response = await http
        .get(Uri.parse(url),headers: {"Accept": "application/json"});

    var fetched = MovieResponse.fromJson(json.decode(response.body)).movieList;

    setState(() {
      widget.movies.addAll(fetched);
      print(widget.movies.length.toString());
      currentPage++;
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
                        child: AppUtils.backButton,
                      ),
                      Text(
                        widget.segment,
                        style: TextStyle(
                          fontSize: width*0.09,
                          color: Colors.blueGrey[900],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Wrap(
                    runSpacing: 10,
                    direction: Axis.horizontal,
                    children: List.generate(widget.movies.length + 1, (index) {
                      return index == widget.movies.length
                          ? CupertinoActivityIndicator()
                          : Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: MoviePosterWidget(
                                movie: widget.movies[index],
                                height: height*0.26,
                               viewAll: true,
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