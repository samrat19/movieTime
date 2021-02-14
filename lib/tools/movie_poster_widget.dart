import 'package:flutter/material.dart';
import 'package:movitm/assets/api_url.dart';
import 'package:movitm/logic/bloc/home_screen_bloc.dart';
import 'package:movitm/logic/bloc/movie_details_bloc.dart';
import 'package:movitm/logic/model/movie_model.dart';
import 'package:movitm/screens/movie_details_screen.dart';

class MoviePosterWidget extends StatelessWidget {
  final MovieModel movie;

  const MoviePosterWidget({Key key, @required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        MovieBloc()..getSimilarMovies(movie.id);
        MovieDetailsBloc()..init(movie.id);
        return Navigator.of(context).push(MaterialPageRoute(builder: (_)=>MovieDetailsScreen()));
      },
      child: Container(
        width: width * 0.37,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.indigo[900],
              blurRadius: 6.0,
              spreadRadius: 4.0,
            ),
            BoxShadow(
              color: Colors.white,
              blurRadius: 6.0,
              spreadRadius: 4.0,
            ),
          ],
          color: Colors.transparent,
          image: DecorationImage(
            fit: BoxFit.contain,
            image: NetworkImage(ApiURL.posterBaseURL + movie.posterPath),
          ),
        ),
      ),
    );
  }
}