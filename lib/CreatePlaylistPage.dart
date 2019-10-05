import 'package:flutter/material.dart';
import 'package:spotify_starter/AnimatedBackground.dart';
import 'package:flutter/services.dart';
import 'MergeOrAddMusicSelectionPage.dart';

//class CollabButton extends StatefulWidget {
//  @override
//  _CollabButtonState createState() => _CollabButtonState();
//}

//class _CollabButtonState extends State<CollabButton> {
//
//  bool _collab = false;
//
//  void toggleCollab() {
//    setState(() {
//      _collab = !_collab;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//        child:
//        RaisedButton(onPressed: () {
//          toggleCollab();
//        },
//          child: Text(_collab ? "Yes":"No"),)
//    );
//  }
//}

class CreatePlaylistPage extends StatefulWidget {
  const CreatePlaylistPage();

  @override
  _CreatePlaylistPage createState() => _CreatePlaylistPage();
}

class _CreatePlaylistPage extends State<CreatePlaylistPage> {
  var _collab = true;
  var _public = true;

  final _playlistNameEntryController = TextEditingController();
  final _descriptionEntryController = TextEditingController();
  bool _validate = false;

  @override
  void initState() {
    super.initState();
    _collab = true;
    _public = true;
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    final colabRadio = Container(
        margin: EdgeInsets.only(top: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Collaborative:"),
            RaisedButton(
              child: Text("Yes"),
              splashColor: Colors.blue,
              color: _collab ? Colors.green : Colors.black12,
              onPressed: () {
                setState(() {
                  _collab = true;
                });
              },
            ),
            RaisedButton(
              child: Text("No"),
              splashColor: Colors.blue,
              color: _collab ? Colors.black12 : Colors.green,
              onPressed: () {
                setState(() {
                  _collab = false;
                });
              },
            ),
          ],
        ));
    final publicRadio = Container(
        margin: EdgeInsets.only(top: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Public:"),
            RaisedButton(
              child: Text("Yes"),
              splashColor: Colors.blue,
              color: _public ? Colors.green : Colors.black12,
              onPressed: () {
                setState(() {
                  _public = true;
                });
              },
            ),
            RaisedButton(
              child: Text("No"),
              splashColor: Colors.blue,
              color: _public ? Colors.black12 : Colors.green,
              onPressed: () {
                setState(() {
                  _public = false;
                });
              },
            ),
          ],
        ));

    final playlistNameEntry = Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        height: MediaQuery.of(context).size.height * .20,
        child: Hero(
            tag: "PlaylistName",
            child: TextField(
              controller: _playlistNameEntryController,
              decoration: InputDecoration(
                  labelText: "Playlist Name",
                  errorText: _validate ? "Can\'t be left empty" : null),
              cursorColor: Colors.green,
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
                decoration: TextDecoration.none,
                fontFamily: "Roboto",
              ),
            )));

    final playlistDescriptionEntry = Hero(
        tag: "description",
        child: Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            height: MediaQuery.of(context).size.height * .15,
            child: TextField(
              controller: _descriptionEntryController,
              decoration: InputDecoration(labelText: "Description"),
              cursorColor: Colors.green,
              style: TextStyle(color: Colors.green, fontSize: 50),
            )));

    final appbar = AppBar(
      backgroundColor: Colors.transparent,
    );

    final createPlaylistButton = Hero(
        tag: "FAB",
        child: Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height - 100,
                left: MediaQuery.of(context).size.width - 350),
            height: 65,
            width: MediaQuery.of(context).size.width * .70,
            child: RaisedButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                color: Colors.green,
                elevation: 10,
                onPressed: () {
                  setState(() {
                    ///TODO: API call validation

                    _playlistNameEntryController.text.isEmpty
                        ? _validate = true
                        : _validate = false;

                    if (_validate == false) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MergeOrAddMusic(
                                  playlistName:
                                      _playlistNameEntryController.text,
                                  description:
                                      _descriptionEntryController.text)));
                    }
                  });
                },
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                      margin: EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                      )),
                  Text(
                    "Create",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )
                ]))));

    return Material(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: Stack(children: [
              AnimatedBackground(),
              appbar,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  playlistNameEntry,
                  playlistDescriptionEntry,
                  colabRadio,
                  publicRadio,
                ],
              ),
              createPlaylistButton
            ])));
  }
}
