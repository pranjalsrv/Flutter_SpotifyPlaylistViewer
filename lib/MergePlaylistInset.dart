import 'package:flutter/material.dart';
import 'PlaylistWidget.dart';
import 'CreatePlaylistPage.dart';
import 'package:spotify_starter/AnimatedBackground.dart';
import 'package:flutter/animation.dart';

class MergePlaylistInset extends StatefulWidget {
  const MergePlaylistInset();

  @override
  _MergePlaylistInsetState createState() => _MergePlaylistInsetState();
}

class CustomBoxShadow extends BoxShadow {
  final BlurStyle blurStyle;

  const CustomBoxShadow({
    Color color = const Color(0xFF000000),
    Offset offset = Offset.zero,
    double blurRadius = 0.0,
    double spreadRadius = 0.0,
    this.blurStyle = BlurStyle.normal,
  }) : super(color: color, offset: offset, blurRadius: blurRadius, spreadRadius:spreadRadius);

  @override
  Paint toPaint() {
    final Paint result = Paint()
      ..color = color
      ..maskFilter = MaskFilter.blur(this.blurStyle, blurSigma);
    assert(() {
      if (debugDisableShadows) result.maskFilter = null;
      return true;
    }());
    return result;
  }
}

class _MergePlaylistInsetState extends State<MergePlaylistInset>
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
        itemCount: PlaylistWidgetType.length,
        padding: EdgeInsets.only(top: 10));
  }

  @override
  Widget build(BuildContext context) {
    Widget currentPlaylistDisplay(PlaylistWidgetType) {
      return Expanded(
        child: buildPlaylistWidget(PlaylistWidgetType),
      );
    }

    Widget listOnly(PlaylistWidgetType) {
      return Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [currentPlaylistDisplay(PlaylistWidgetType)]));
    }

    final tabBar = TabBar(
        indicatorColor: Colors.green,
        labelColor: Colors.green,
        controller: _tabController,
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

    Widget MyPlaylistsTabScaffold = Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        child: listOnly(mockMyPlaylistWidgets));

    Widget CreatedPlaylistsTabScaffold = Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        child: listOnly(mockCreatedPlaylistWidgets));

    Widget ReceivedPlaylistsTabScaffold = Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        child: listOnly(mockReceivedPlaylistWidgets));

    return ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child:  Scaffold(
                backgroundColor: Colors.transparent,
                appBar: tabBar,
                body: TabBarView(controller: _tabController, children: [
                  MyPlaylistsTabScaffold,
                  CreatedPlaylistsTabScaffold,
                  ReceivedPlaylistsTabScaffold,
                ])));
  }
}
