import 'package:flutter/material.dart';
import 'package:movitm/assets/api_url.dart';
import 'package:movitm/logic/model/movie_model.dart';
import 'package:movitm/logic/movie_response.dart';

import '../view_all_screen.dart';

class LabelManagerWidget extends StatefulWidget {
  final MovieResponse movieType;
  final int index;

  const LabelManagerWidget(
      {Key key, @required this.movieType, @required this.index})
      : super(key: key);

  @override
  _LabelManagerWidgetState createState() => _LabelManagerWidgetState();
}

class _LabelManagerWidgetState extends State<LabelManagerWidget> {
  String url = '';
  String segmentTitle = '';

  @override
  void initState() {
    if (widget.index == 1) {
      setState(() {
        segmentTitle = 'Streaming Now';
        url = ApiURL.paginationNowPlayingURL;
      });
    } else if (widget.index == 2) {
      setState(() {
        segmentTitle = 'Top Rated';
        url = ApiURL.paginationTopRatedURL;
      });
    } else {
      setState(() {
        segmentTitle = 'Popular Movies';
        url = ApiURL.paginationPopularURL;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          segmentTitle,
          style: TextStyle(
            fontSize: width * 0.07,
            color: Colors.blueGrey,
          ),
        ),
        GestureDetector(
          onTap: () {
            List<MovieModel> list = widget.movieType.movieList;
            return Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ViewAllScreen(
                  segment: ' $segmentTitle',
                  movies: list,
                  totalPage: widget.movieType.totalPages,
                  url: url,
                ),
              ),
            );
          },
          child: Text(
            'View All',
            style: TextStyle(
                fontSize: width * 0.04,
                color: Colors.blueGrey,
                decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }
}