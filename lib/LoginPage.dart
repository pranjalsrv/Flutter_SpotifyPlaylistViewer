import 'package:flutter/material.dart';
import 'LoginPageBackground.dart';
import 'LoginWebviewMaker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'PlaylistsPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage();

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String refresh_token, access_token;

  void initState() {
    super.initState();
  }

  _loginTrial() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString("refresh_token", "0");
      refresh_token = (prefs.getString('refresh_token') ?? "0");
      print("refresh_token searched in persistent memory");
    });

    if (refresh_token == "0") {
      print("refresh_token not found in persistent memory");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginWebview()),
      );
    } else {
      print("refresh_token recieved from persistent memory");
      print(refresh_token);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AddUserPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Logo = Container(
        height: 200, width: 350, child: Image.asset("images/SpotifyLogo.png"));

    final LoginButton = Hero(
        tag: "LoginButton",
        child: Container(
            width: MediaQuery.of(context).size.width * .70,
            height: 45,
            child: RaisedButton(
                splashColor: Colors.blue,
                color: Colors.green,
                child: Text("Login To Spotify"),
                onPressed: () {
                  _loginTrial();
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)))));

    return Scaffold(
        body: Stack(alignment: Alignment.center, children: [
      AnimatedBackground(),
      Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Logo,
            LoginButton,
          ])
    ]));
  }
}
