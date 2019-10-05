import 'package:flutter/material.dart';
import 'package:spotify_starter/LoginPageBackground.dart';
import 'package:flutter/services.dart';

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

  @override
  void initState() {
    super.initState();
    _collab = true;
    _public = true;
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    Widget createPlaylistFAB = Container(
        width: MediaQuery.of(context).size.width * .70,
        height: 65,
        child: FloatingActionButton.extended(
          heroTag: "createPlaylistFAB",
          elevation: 10,
          onPressed: () {},
          icon: Icon(Icons.add),
          label: Text("Create"),
        ));

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
        child: TextField(
          decoration: InputDecoration(labelText: "Playlist Name"),
          cursorColor: Colors.green,
          style: TextStyle(color: Colors.white, fontSize: 55),
        ));

    final playlistDescriptionEntry = Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        height: MediaQuery.of(context).size.height * .15,
        child: TextField(
          decoration: InputDecoration(labelText: "Description"),
          cursorColor: Colors.green,
          style: TextStyle(color: Colors.white, fontSize: 45),
        ));

    final playlistPageBackButton = Container(
        margin: EdgeInsets.only(top: 40, left: 20),
        child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )));

    final createPlaylistButton = Container(
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * .88,
            left: MediaQuery.of(context).size.height * .13),
        height: 65,
        width: 250,
        child: RaisedButton(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.green,
            elevation: 10,
            onPressed: () {},
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  margin: EdgeInsets.only(right: 8), child: Icon(Icons.check)),
              Text(
                "Create",
                style: TextStyle(fontSize: 20),
              )
            ])));

    return Hero(
        tag: "FAB",
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(children: [
              AnimatedBackground(),
              playlistPageBackButton,
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
