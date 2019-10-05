import 'package:flutter/material.dart';
import 'AnimatedBackground.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'MergePlaylistPage.dart';
import 'SearchOrSavedSelection.dart';

class MergeOrAddMusic extends StatefulWidget {
  final String playlistName;
  final String description;

  const MergeOrAddMusic({Key key, this.playlistName, this.description})
      : super(key: key);

  @override
  _MergeOrAddMusicState createState() => _MergeOrAddMusicState();
}

class _MergeOrAddMusicState extends State<MergeOrAddMusic> {
  @override
  Widget build(BuildContext context) {
    final playlistNameDisplay = Hero(
        tag: "PlaylistName",
        child: Center(
            child:AutoSizeText(
          "${widget.playlistName}",
          maxLines: 2,
          style: TextStyle(
            decoration: TextDecoration.none,
            fontFamily: "Roboto",
            fontSize: MediaQuery.of(context).size.height * 0.1,
            fontStyle: FontStyle.italic,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        )));

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

    final MergePlaylistButton = Container(
        margin: EdgeInsets.only(top: 60),
        height: 65,
        width: MediaQuery.of(context).size.width * 0.8,
        child: RaisedButton(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.green,
            elevation: 10,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MergePlaylist(
                            newPlaylistName: widget.playlistName,
                            description: widget.description,
                          )));
            },
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  margin: EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.call_merge,
                    color: Colors.white,
                  )),
              Text(
                "Marge Existing Playlist",
                style: TextStyle(fontSize: 20, color: Colors.white),
              )
            ])));

    final AddMusicButton = Container(
        margin: EdgeInsets.only(top: 30),
        height: 65,
        width: MediaQuery.of(context).size.width * 0.8,
        child: RaisedButton(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.green,
            elevation: 10,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchOrSavedSelection(
                            playlistName: widget.playlistName,
                            description: widget.description,
                          )));
            },
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  margin: EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.music_note,
                    color: Colors.white,
                  )),
              Text(
                "Add Music",
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
            MergePlaylistButton,
            AddMusicButton
          ],
        )
      ],
    )));
  }
}
