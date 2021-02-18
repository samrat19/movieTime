import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movitm/assets/api_url.dart';
import 'package:movitm/logic/model/movie_details_model.dart';
import 'package:movitm/tools/app_utils.dart';

class MovieTitleSection extends StatelessWidget {

  final MovieDetailsModel movieDetails;

  const MovieTitleSection({Key key, @required this.movieDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String posterPath = movieDetails.backdropPath ==
        null ? ApiURL.nullImage : ApiURL.posterBaseURL + movieDetails.backdropPath;

    return Expanded(
      flex: 2,
      child: Stack(
        children: [
          Container(
            foregroundDecoration: AppUtils.foreGroundDecoration,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(posterPath),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  movieDetails.title,
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  '${movieDetails.runtime} minutes',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    Text(
                      'Rating',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    RatingBar(
                      initialRating:
                      movieDetails.voteAverage,
                      ratingWidget: RatingWidget(
                        full: Icon(
                          Icons.star,
                          color: Colors.grey,
                        ),
                        half: Icon(
                          Icons.star_half,
                          color: Colors.grey,
                        ),
                        empty: Icon(
                          Icons.star_border_outlined,
                          color: Colors.grey,
                        ),
                      ),
                      onRatingUpdate: null,
                      itemCount: 10,
                      itemSize: 20.0,
                    )
                  ],
                ),
                SizedBox(
                  height: 4.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}