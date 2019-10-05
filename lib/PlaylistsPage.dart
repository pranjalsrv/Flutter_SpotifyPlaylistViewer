import 'package:flutter/material.dart';
import 'PlaylistWidget.dart';
import 'CreatePlaylistPage.dart';
import 'package:spotify_starter/LoginPageBackground.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage();

  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage>
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
      return (Expanded(
        child: buildPlaylistWidget(PlaylistWidgetType),
      ));
    }

    Widget FAB = Container(
        width: MediaQuery.of(context).size.width * .70,
        height: 65,
        child: FloatingActionButton.extended(
          heroTag: "FAB",
          elevation: 10,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePlaylistPage()));
          },
          icon: Icon(Icons.add),
          label: Text("Add Playlist"),
        ));

    Widget listOnly(PlaylistWidgetType) {
      return Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [currentPlaylistDisplay(PlaylistWidgetType)]));
    }

    final tabBar = TabBar(controller: _tabController, tabs: [
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
        elevation: 0.0,
        title: Text(
          'Playlists',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
          ),
        ),
        bottom: tabBar);

    Widget MyPlaylistsTabScaffold =
        Scaffold(body: listOnly(mockMyPlaylistWidgets));

    Widget CreatedPlaylistsTabScaffold = Scaffold(
        body: listOnly(mockCreatedPlaylistWidgets),
        floatingActionButton: FAB,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);

    Widget ReceivedPlaylistsTabScaffold =
        Scaffold(body: listOnly(mockReceivedPlaylistWidgets));

    return Scaffold(
        appBar: appBar,
        body: TabBarView(controller: _tabController, children: [
          MyPlaylistsTabScaffold,
          CreatedPlaylistsTabScaffold,
          ReceivedPlaylistsTabScaffold
        ]));
  }
}
