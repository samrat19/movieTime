import 'package:flutter/material.dart';
import 'package:movitm/assets/api_url.dart';

class ViewAllScreen extends StatefulWidget {
  final String segment;
  final int index;

  const ViewAllScreen({Key key, @required this.segment, this.index}) : super(key: key);

  @override
  _ViewAllScreenState createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {

  List<String> urls = [
    ApiURL.upcomingMovieURL,
    ApiURL.streamingMovieURL,
    ApiURL.topRatedMovieURL,
    ApiURL.popularMovieURL,
  ];

  getMovies(){

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
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo[900], Colors.black],
              begin: Alignment(0, 1.5),
              end: Alignment(0, -1),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: SingleChildScrollView(
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
                              color: Colors.white, size: 25)),
                      Text(
                        widget.segment,
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    children: List.generate(
                        20,
                        (index) => Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ViewAllMoviePosterWidget(),
                            )),
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
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.grey,
      width: width * 0.3,
      height: height * 0.2,
    );
  }
}
