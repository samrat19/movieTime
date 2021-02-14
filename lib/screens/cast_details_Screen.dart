import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movitm/assets/api_url.dart';
import 'package:movitm/logic/bloc/movie_details_bloc.dart';
import 'package:movitm/logic/bloc/person/person_details_bloc.dart';
import 'package:movitm/logic/model/person_model.dart';
import 'package:movitm/tools/movie_poster_widget.dart';

class CastDetailsScreen extends StatelessWidget {
  final int heroTag;

  const CastDetailsScreen({Key key, this.heroTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      top: true,
      child: Hero(
        tag: heroTag,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            fit: StackFit.expand,
            children: [
              StreamBuilder<PersonModel>(
                  stream: MovieDetailsBloc().personStream,
                  builder: (context, AsyncSnapshot<PersonModel> snapshot) {
                    return snapshot.hasData
                        ? SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal:8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Container(
                                      width: width * 0.5,
                                      height: height * 0.3,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                ApiURL.posterBaseURL +
                                                    snapshot.data.profilePath)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Center(
                                    child: Text(
                                      snapshot.data.name,
                                      style: TextStyle(
                                        fontSize: 30.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    snapshot.data.biography,
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    'Other Images',
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  StreamBuilder<PersonDetailsManager>(
                                      stream:
                                          PersonDetailsBloc().personDetailsStream,
                                      builder: (context,
                                          AsyncSnapshot<PersonDetailsManager>
                                              snapshot) {
                                        return Container(
                                          height: height * 0.3,
                                          child: ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: snapshot
                                                .data.images.profiles.length,
                                            itemBuilder: (_, index) => Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.network(
                                                    ApiURL.posterBaseURL +
                                                        snapshot
                                                            .data
                                                            .images
                                                            .profiles[index]
                                                            .filePath)),
                                            separatorBuilder: (_, index) =>
                                                SizedBox(
                                              width: 2.0,
                                            ),
                                          ),
                                        );
                                      }),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    'Movies',
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  StreamBuilder<PersonDetailsManager>(
                                      stream:
                                          PersonDetailsBloc().personDetailsStream,
                                      builder: (context,
                                          AsyncSnapshot<PersonDetailsManager>
                                              snapshot) {
                                        return Container(
                                          height: height * 0.3,
                                          child: ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: snapshot
                                                .data.movies.movies.length,
                                            itemBuilder: (_, index) => Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: MoviePosterWidget(
                                                movie: snapshot
                                                    .data.movies.movies[index],
                                              ),
                                            ),
                                            separatorBuilder: (_, index) =>
                                                SizedBox(
                                              width: 2.0,
                                            ),
                                          ),
                                        );
                                      }),
                                  StreamBuilder<PersonDetailsManager>(
                                      stream:
                                          PersonDetailsBloc().personDetailsStream,
                                      builder: (context,
                                          AsyncSnapshot<PersonDetailsManager>
                                              snapshot) {
                                        return Container(
                                          height: 20.0,
                                          child: ListView(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            children: [
                                              Text(
                                                snapshot.data.links.facebookId == null ? 'fb'
                                                    : snapshot
                                                        .data.links.facebookId,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                snapshot.data.links.instagramId == null ? 'insta'
                                                    : snapshot
                                                    .data.links.instagramId,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                snapshot.data.links.twitterId == null ? 'tw'
                                                    : snapshot
                                                    .data.links.twitterId,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        );
                                      }),
                                ],
                              ),
                            ),
                          )
                        : CupertinoActivityIndicator();
                  }),
              Positioned(
                top: 10,
                left: 10,
                child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back_ios_outlined,
                        color: Colors.grey)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
