import 'package:flutter/material.dart';
import 'AnimatedBackground.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'PlaylistJSONObjects.dart';
import 'PlaylistWidget.dart';
import 'package:spotify_starter/AnimatedBackground.dart';
import 'MergePlaylistInset.dart';
import 'package:auto_size_text/auto_size_text.dart';

Future<PlaylistObject> getPlaylistData() async {
  String url = "https://api.spotify.com/v1/me/playlists/";
  String access_token =
      "BQDF93QB6v4sIyFBLaPcG2uge4uJ4OK8ZdSLeDdlgpG_LR57vpwNof0sABNXWt8WGtH7QamThrKJ-FKEORfcSKNmtdCKcsjqYwyNeqbMgCqkZ0weiiJZ0q8ueX4kUK0_LZNN1HqogsF0FMT2DNY0Sie6zZzMN8sXAn5h6P7x5Z3NNhc7ephLyoyi_2TQEOaC_Q72dmo";
  final response =
      await http.get(url, headers: {"Authorization": "Bearer " + access_token});

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    return PlaylistObject.fromJson(jsonDecode(response.body));
  } else {
    // If that response was not OK, throw an error.
    print("Error in retreiving playlist data from API");
  }
}

class MergePlaylist extends StatefulWidget {
  final String newPlaylistName;
  final String description;

  const MergePlaylist({Key key, this.newPlaylistName, this.description})
      : super(key: key);

  @override
  _MergePlaylistState createState() => _MergePlaylistState();
}

class _MergePlaylistState extends State<MergePlaylist> {
  Future<PlaylistObject> _PlaylistJsonData;
  List<String> _PlaylistNames;
  final myPlaylistsWidget = <Playlist>[];

  void initState() {
    super.initState();
    _PlaylistJsonData = getPlaylistData();
    _PlaylistNames = new List<String>();

    FutureBuilder<PlaylistObject>(
      future: getPlaylistData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          for (var jdata in snapshot.data.items) {
            print(jdata.name);
            _PlaylistNames.add(jdata.name);
          }
        } else if (snapshot.hasError) {
          print("${snapshot.error}");

          ///TODO:  ERROR HANDLING
        }
      },
    );

    void PlaylistWidgetCreator(PlaylistName, PlaylistWidget, PlaylistAuthor) {
      for (var i = 0; i < PlaylistName.length; i++) {
        PlaylistWidget.add(Playlist(
          name: PlaylistName[i],
          iconLocation: Icons.person,
          author: PlaylistAuthor,
          isSelected: false,

          ///TODO: change PlaylistAuthor to list, index it with 'i'
        ));
      }
    }

    PlaylistWidgetCreator(_PlaylistNames, myPlaylistsWidget, "Authors");

    ///TODO: change "Authors" to actual authors
  }

  Widget buildPlaylistWidget() {
    return ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            myPlaylistsWidget[index],
        itemCount: _PlaylistNames.length);
  }

  @override
  Widget build(BuildContext context) {
    final playlistNameDisplay = Hero(
        tag: "PlaylistName",
        child: Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.09),
            child: AutoSizeText(
              "${widget.newPlaylistName}",
              maxLines: 1,
              style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: MediaQuery.of(context).size.height * 0.05,
                fontStyle: FontStyle.italic,
                fontFamily: "Roboto",
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )));

    final descriptionDisplay = Hero(
        tag: "description",
        child: AutoSizeText(
          "${widget.description}",
          maxLines: 2,
          style: TextStyle(
            decoration: TextDecoration.none,
            fontFamily: "Roboto",
            fontSize: MediaQuery.of(context).size.height * 0.02,
            fontStyle: FontStyle.italic,
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ));

    return Scaffold(
        body: Container(
            child: Stack(
      children: <Widget>[
        AnimatedBackground(),
        AppBar(
          backgroundColor: Colors.transparent,
        ),
        Column(children: [
          playlistNameDisplay,
          descriptionDisplay,
          Container(
            padding: EdgeInsets.only(top: 50),
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05),
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(30)),
                child: MergePlaylistInset()),
          )
        ])
      ],
    )));
  }
}
