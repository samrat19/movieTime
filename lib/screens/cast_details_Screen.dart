import 'package:flutter/material.dart';
import 'package:movitm/assets/api_url.dart';
import 'package:movitm/logic/bloc/movie_details_bloc.dart';
import 'package:movitm/logic/model/person_model.dart';

class CastDetailsScreen extends StatelessWidget {
  final int heroTag;

  const CastDetailsScreen({Key key, this.heroTag}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<PersonModel>(
        stream: MovieDetailsBloc().personStream,
        builder: (context,AsyncSnapshot<PersonModel> snapshot) {
          return Hero(
            tag: heroTag,
            child: Container(
              child: Image.network(ApiURL.posterBaseURL+snapshot.data.profilePath),
            ),
          );
        }
      ),
    );
  }
}
