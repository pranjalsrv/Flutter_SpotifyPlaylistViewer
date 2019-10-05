import 'package:flutter/material.dart';
import 'AnimatedBackground.dart';
import 'package:auto_size_text/auto_size_text.dart';

class SearchOrSavedSelection extends StatefulWidget {
  final String playlistName;
  final String description;

  const SearchOrSavedSelection({Key key, this.playlistName, this.description})
      : super(key: key);

  @override
  _SearchOrSavedSelectionState createState() => _SearchOrSavedSelectionState();
}

class _SearchOrSavedSelectionState extends State<SearchOrSavedSelection> {
  @override
  Widget build(BuildContext context) {
    final playlistNameDisplay = Hero(
        tag: "PlaylistName",
        child: AutoSizeText(
          "${widget.playlistName}",
          maxLines: 1,
          style: TextStyle(
            decoration: TextDecoration.none,
            fontFamily: "Roboto",
            fontSize: MediaQuery.of(context).size.height * 0.15,
            fontStyle: FontStyle.italic,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ));

    final descriptionDisplay = Hero(
        tag: "description",
        child: Center(
            child: AutoSizeText(
          "${widget.description}",
          maxLines: 2,
          style: TextStyle(
            decoration: TextDecoration.none,
            fontFamily: "Roboto",
            fontSize: MediaQuery.of(context).size.height * 0.05,
            fontStyle: FontStyle.italic,
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        )));

    final SavedMusicButton = Container(
        margin: EdgeInsets.only(top: 30),
        height: 65,
        width: MediaQuery.of(context).size.width * 0.8,
        child: RaisedButton(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.green,
            elevation: 10,
            onPressed: () {},
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.favorite,
                    color: Colors.white,
                  )),
              Text(
                "Select from Saved Music",
                style: TextStyle(fontSize: 20, color: Colors.white),
              )
            ])));

    final SearchButton = Container(
        margin: EdgeInsets.only(top: 60),
        height: 65,
        width: MediaQuery.of(context).size.width * 0.8,
        child: RaisedButton(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.green,
            elevation: 10,
            onPressed: () {},
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  margin: EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  )),
              Text(
                "Search on Spotify",
                style: TextStyle(fontSize: 20, color: Colors.white),
              )
            ])));

    return Scaffold(
        body: Container(
            child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        AnimatedBackground(),
        AppBar(
          backgroundColor: Colors.transparent,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            playlistNameDisplay,
            descriptionDisplay,
            SearchButton,
            SavedMusicButton,
          ],
        )
      ],
    )));
  }
}
