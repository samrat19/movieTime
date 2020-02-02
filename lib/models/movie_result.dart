class MovieResult {
  int _voteCount;
  int _id;
  bool _video;
  var _voteAverage;
  String _title;
  double _popularity;
  String _posterPath;
  String _originalLanguage;
  String _originalTitle;
  List<int> _genreID = [];
  String _backdropPath;
  bool _adult;
  String _overview;
  String _releaseDate;

  MovieResult(result) {
    _voteCount = result['voteCount'];
    _id = result['id'];
    _video = result['video'];
    _voteAverage = result['voteAverage'];
    _title = result['title'];
    _popularity = result['popularity'];
    _posterPath = result['posterPath'];
    _originalLanguage = result['originalLanguage'];
    _originalTitle = result['originalTitle'];
    for (int i = 0; i < result['genreID'].length; i++) {
      _genreID.add(result['genreID'][i]);
    }
    _backdropPath = result['backdropPath'];
    _adult = result['adult'];
    _overview = result['overview'];
    _releaseDate = result['releaseDate'];
  }

  String get releaseDate => _releaseDate;

  String get overview => _overview;

  bool get adult => _adult;

  String get backdropPath => _backdropPath;

  List<int> get genreID => _genreID;

  String get originalTitle => _originalTitle;

  String get originalLanguage => _originalLanguage;

  String get posterPath => _posterPath;

  double get popularity => _popularity;

  String get title => _title;

  double get voteAverage => _voteAverage;

  bool get video => _video;

  int get id => _id;

  int get voteCount => _voteCount;
}