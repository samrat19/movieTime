import 'package:flutter/material.dart';

//https://api.themoviedb.org/3/movie/now_playing?api_key=e151ccdde6fbf9ea2d84c67dfb0a920c

main() => runApp(
  MaterialApp(
    home: Scaffold(
      body: MovieList(),
    ),
  ),
);