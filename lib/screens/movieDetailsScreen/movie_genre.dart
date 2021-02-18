import 'package:flutter/material.dart';
import 'package:movitm/logic/model/movie_details_model.dart';

class MovieGenre extends StatelessWidget {

  final List<Genres> genres;

  const MovieGenre({Key key, @required this.genres}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      direction: Axis.horizontal,
      children: genres
          .map(
            (e) => Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius:
            BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets
                .symmetric(
                horizontal: 10.0,
                vertical: 4.0),
            child: Text(
              e.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: width * 0.05,
              ),
            ),
          ),
        ),
      )
          .toList(),
    );
  }
}

