import 'package:flutter/material.dart';

class MovieCast extends StatelessWidget {
  final String posterURL;
  final String name;

  const MovieCast({Key key, this.posterURL, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width * 0.2,
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(posterURL == null
                    ? 'https://www.vippng.com/png/full/356-3563630_continue-marketing.png'
                    : posterURL),
              ),
            ),
          ),
          Text(
            name,
            style: TextStyle(
              fontSize: 17.0,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}