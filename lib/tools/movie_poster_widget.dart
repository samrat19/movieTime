import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movitm/assets/api_url.dart';
import 'package:movitm/logic/bloc/home_screen/home_screen_bloc.dart';
import 'package:movitm/logic/bloc/movie_details/movie_details_bloc.dart';
import 'package:movitm/logic/model/movie_model.dart';
import 'package:movitm/screens/movie_details_screen.dart';

class MoviePosterWidget extends StatelessWidget {
  final MovieModel movie;
  final bool viewAll;
  final double height;

  const MoviePosterWidget({Key key, @required this.movie, this.viewAll = false,this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    String imagePath = movie.posterPath == null?'https://www.pngrepo.com/download/34896/movie.png':ApiURL.posterBaseURL+movie.posterPath;
    return GestureDetector(
      onTap: (){
        if(movie.id != null){
          MovieBloc()..getSimilarMovies(movie.id);
          MovieDetailsBloc()..init(movie.id);
          return Navigator.of(context).push(MaterialPageRoute(builder: (_)=>MovieDetailsScreen(id: movie.id,))).then((value){
            MovieBloc()..getSimilarMovies(movie.id);
            MovieDetailsBloc()..init(movie.id);
          });
        }else{
          print('no id');
        }
      },
      child: Container(
        height: height,
        width: viewAll?width*0.3:width * 0.37,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(imagePath),
          ),
        ),
      ),
    );
  }
}