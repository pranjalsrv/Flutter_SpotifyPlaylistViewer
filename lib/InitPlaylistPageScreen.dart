import 'package:flutter/material.dart';
import 'PlaylistWidget.dart';
import 'CreatePlaylistPage.dart';
import 'package:spotify_starter/AnimatedBackground.dart';
import 'package:flutter/animation.dart';

class PlaylistPage extends StatefulWidget {
  const PlaylistPage();

  @override
  _PlaylistPageState createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage>
    with SingleTickerProviderStateMixin {
  final mockMyPlaylistWidgets = <Playlist>[];
  final mockCreatedPlaylistWidgets = <Playlist>[];
  final mockReceivedPlaylistWidgets = <Playlist>[];

  TabController _tabController;

  static var mockMyPlaylistsName = <String>[
    "My Playlist 1",
    "My Playlist 2",
    "My Playlist 3",
    "My Playlist 4",
  ];

  static var mockMyPlaylistsAuthor = <String>[
    "My Author 1",
    "My Author 2",
    "My Author 3",
    "My Author 4",
  ];

  static var mockCreatedPlaylistsName = <String>[
    "Created Playlist 1",
    "Created Playlist 2",
    "Created Playlist 3",
    "Created Playlist 4",
  ];

  static var mockCreatedPlaylistsAuthor = <String>[
    "Created Author 1",
    "Created Author 2",
    "Created Author 3",
    "Created Author 4",
  ];

  static var mockReceivedPlaylistsName = <String>[
    "Received Playlist 1",
    "Received Playlist 2",
    "Received Playlist 3",
    "Received Playlist 4",
  ];

  static var mockReceivedPlaylistsAuthor = <String>[
    "Received Author 1",
    "Received Author 2",
    "Received Author 3",
    "Received Author 4",
  ];

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this, initialIndex: 1);

    void PlaylistWidgetCreator(PlaylistName, PlaylistWdget, PlaylistAuthor) {
      for (var i = 0; i < PlaylistName.length; i++) {
        PlaylistWdget.add(Playlist(
          name: PlaylistName[i],
          iconLocation: Icons.person,
          author: PlaylistAuthor[i],
          isSelected: false,
        ));
      }
    }

    PlaylistWidgetCreator(
        mockMyPlaylistsName, mockMyPlaylistWidgets, mockMyPlaylistsAuthor);
    PlaylistWidgetCreator(mockCreatedPlaylistsName, mockCreatedPlaylistWidgets,
        mockCreatedPlaylistsAuthor);
    PlaylistWidgetCreator(mockReceivedPlaylistsName,
        mockReceivedPlaylistWidgets, mockReceivedPlaylistsAuthor);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget buildPlaylistWidget(PlaylistWidgetType) {
    return ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            PlaylistWidgetType[index],
        itemCount: PlaylistWidgetType.length);
  }

  @override
  Widget build(BuildContext context) {
    Widget currentPlaylistDisplay(PlaylistWidgetType) {
      return Expanded(
        child: buildPlaylistWidget(PlaylistWidgetType),
      );
    }

    Widget FAB = Container(
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height - 250,
            left: MediaQuery.of(context).size.width - 350),
        width: MediaQuery.of(context).size.width * .70,
        height: 65,
        child: FloatingActionButton.extended(
          heroTag: "FAB",
          elevation: 10,
          onPressed: () {
            Navigator.push(context,
                PageRouteBuilder(
                    settings: RouteSettings(isInitialRoute: true),
                    pageBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation) =>
                        CreatePlaylistPage()));
          },
          icon: Icon(Icons.add),
          label: Text(
            "Add Playlist",
            style: TextStyle(fontSize: 20),
          ),
        ));

    Widget listOnly(PlaylistWidgetType) {
      return Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [currentPlaylistDisplay(PlaylistWidgetType)]));
    }

    final tabBar = TabBar(
        labelColor: Colors.green,
        controller: _tabController,
        indicatorColor: Color(0xffD38312),
        tabs: [
          new Tab(
            text: "My Playlists",
            icon: Icon(Icons.person),
          ),
          new Tab(
            text: "Created Playlists",
            icon: Icon(Icons.create),
          ),
          new Tab(
            text: "Received Playlists",
            icon: Icon(Icons.send),
          )
        ]);

    final appBar = AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Playlists',
          style: TextStyle(
            color: Colors.green,
            fontSize: 30.0,
          ),
        ));

    final AddPlaylistButton = Hero(
        tag: "FAB",
        child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                new BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: new Offset(10, 10),
                    blurRadius: 20)
              ],
            ),
            width: MediaQuery.of(context).size.width * .70,
            height: 65,
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * .15,
                top: MediaQuery.of(context).size.height * .72),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Material(
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 900),
                                pageBuilder: (BuildContext context,
                                        Animation<double> animation,
                                        Animation<double> secondaryAnimation) =>
                                    CreatePlaylistPage()));
                      },
                      child: Stack(children: <Widget>[
                        AnimatedBackground(),
                        Center(
                          child: Text(
                            "Add Playlist",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        )
                      ])),
                ))));

    Widget MyPlaylistsTabScaffold = Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        child: listOnly(mockMyPlaylistWidgets));

    Widget CreatedPlaylistsTabScaffold = Stack(children: [
      Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
          child: listOnly(mockCreatedPlaylistWidgets)),
      FAB,
    ]);

    Widget ReceivedPlaylistsTabScaffold = Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        child: listOnly(mockReceivedPlaylistWidgets));

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          AnimatedBackground(reversed: true),
          Container(
            child: Column(children: <Widget>[
              appBar,
              tabBar,
              Container(
                  height: MediaQuery.of(context).size.height - 161,
                  child: TabBarView(controller: _tabController, children: [
                    MyPlaylistsTabScaffold,
                    CreatedPlaylistsTabScaffold,
                    ReceivedPlaylistsTabScaffold,
                  ]))
            ]),
          ),
        ]));
  }
}
