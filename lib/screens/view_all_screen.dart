import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movitm/assets/api_url.dart';
import 'package:movitm/logic/model/movie_model.dart';

class ViewAllScreen extends StatelessWidget {
  final String segment;
  final List<MovieModel> movies;

  const ViewAllScreen({Key key, @required this.segment, @required this.movies})
      : super(key: key);

//   @override
//   _ViewAllScreenState createState() => _ViewAllScreenState();
// }
//
// class _ViewAllScreenState extends State<ViewAllScreen> {
//
//   @override
//   void initState() {
//     this.fetch();
//     super.initState();
//     _scrollController.addListener(() {
//       if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
//         fetch();
//       }
//     });
//   }
//
//   List<MovieModel> movies = [];
//   ScrollController _scrollController = ScrollController();
//   String message = 'Loading';
//
//   final List<String> urls = [
//     ApiURL.upcomingMovieURL,
//     ApiURL.streamingMovieURL,
//     ApiURL.topRatedMovieURL,
//     ApiURL.popularMovieURL,
//   ];
//
//
//   void getMovies(int page) async {
//     try{
//       var response = await http
//           .get('https://api.themoviedb.org/3/movie/popular?api_key=e151ccdde6fbf9ea2d84c67dfb0a920c&language=en-US&page=$page',);
//       print(response.statusCode.toString());
//       var result = MovieResponse.fromJson(json.decode(response.body));
//       setState(() {
//         for( var movie in result.movieList){
//           movies.add(movie);
//         }
//         print(result.movieList.length);
//       });
//     } on HandshakeException{
//       setState(() {
//         message = 'Connection Timed out';
//       });
//     }
//   }
//
//   fetch(){
//     for(int page = 1; page<widget.totalPage; page++){
//       this.getMovies(page);
//     }
//   }

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
                              color: Colors.blueGrey[900], size: 25),
                      ),
                      Text(
                        segment,
                        style: TextStyle(
                          fontSize: 30.0,
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
                    children: List.generate(
                        20,
                        (index) => Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ViewAllMoviePosterWidget(
                                movie: movies[index],
                              ),
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
  final MovieModel movie;

  const ViewAllMoviePosterWidget({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(0),
      child: Container(
        width: width * 0.3,
        height: height * 0.2,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.contain,
            image: NetworkImage(ApiURL.posterBaseURL + movie.posterPath),
          ),
        ),
      ),
    );
  }
}
