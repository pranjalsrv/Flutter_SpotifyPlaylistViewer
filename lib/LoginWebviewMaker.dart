import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'PlaylistsPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginWebview extends StatefulWidget {
  @override
  _LoginWebviewState createState() => new _LoginWebviewState();
}

class _LoginWebviewState extends State<LoginWebview> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  StreamSubscription _onDestroy;
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;

  String token;

  _saveAuthCode(token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('refresh_token', token);
      print("refresh_token set here from webview");
    });
  }

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    _onDestroy.cancel();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    flutterWebviewPlugin.close();

    // Add a listener to on destroy WebView, so you can make came actions.
    _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {
      print("destroy");
    });

    _onStateChanged =
        flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      print("onStateChanged: ${state.type} ${state.url}");
    });

    // Add a listener to on url changed
    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) async {
      if (mounted) {
        setState(() {
          print("URL changed: $url");
          if (url.startsWith("http://localhost:4002")) {
            print(url);
            RegExp regExp = new RegExp("code=(.*)");
            token = regExp.firstMatch(url)?.group(1);
            _saveAuthCode(token);
             Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => PlaylistPage()),
            );
            flutterWebviewPlugin.close();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String loginUrl =
        "https://accounts.spotify.com/authorize?client_id=246f6d09efd64b9b98a76373b8dd4a70&response_type=code&redirect_uri=http://localhost:4002&scope=user-read-private user-read-email";

    return new Hero(
        tag: "LoginButton",
        child: Scaffold(
            body: WebviewScaffold(
                url: loginUrl,
                appBar: new AppBar(
                  title: new Text("Login to Spotify"),
                ))));
  }
}
