import 'package:flutter/material.dart';
import 'package:spotify_starter/LoginPageBackground.dart';

class Playlist extends StatelessWidget {
  final String name;
  final IconData iconLocation;
  final String author;

  const Playlist({
    Key key,
    @required this.name,
    @required this.iconLocation,
    @required this.author,
  })  : assert(name != null),
        assert(iconLocation != null),
        assert(author != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),

      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  author,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          Icon(
            iconLocation,
            color: Colors.red[500],
          ),
        ],
      ),
    );
  }
}