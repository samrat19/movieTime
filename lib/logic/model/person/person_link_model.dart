class PersonLinkModel {
  int id;
  String freebaseMid;
  String freebaseId;
  String imdbId;
  int tvrageId;
  String facebookId;
  String instagramId;
  String twitterId;

  PersonLinkModel(
      {this.id,
        this.freebaseMid,
        this.freebaseId,
        this.imdbId,
        this.tvrageId,
        this.facebookId,
        this.instagramId,
        this.twitterId});

  PersonLinkModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    freebaseMid = json['freebase_mid'];
    freebaseId = json['freebase_id'];
    imdbId = json['imdb_id'];
    tvrageId = json['tvrage_id'];
    facebookId = json['facebook_id'];
    instagramId = json['instagram_id'];
    twitterId = json['twitter_id'];
  }
}