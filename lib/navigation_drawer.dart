import 'package:fantasy_football/login_view.dart';
import 'package:fantasy_football/model/user.dart';
import 'package:fantasy_football/players_details_view.dart';

import 'package:fantasy_football/team_display_view.dart';
import 'package:fantasy_football/teams_details_view.dart';
import 'package:flutter/material.dart';


class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => new _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {

  Widget widgetForBody = TeamDisplayView();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
          appBar: new AppBar(title: new Text("Fantasy Football"), backgroundColor: Colors.redAccent),
          drawer: new Drawer(
            child: new ListView(
              children: <Widget>[
                new UserAccountsDrawerHeader(
                    accountEmail: new Text(User.get().username),
                    accountName: new Text(User.get().team.name),
                    currentAccountPicture: Image.asset("assets/tnn.png", height: 1000.0,width: 700,),
                    decoration: new BoxDecoration(
                        color: Colors.redAccent
                    )
                ),
                new ListTile(
                    leading: new Icon(Icons.home),
                    title: new Text("My Team"),
                    onTap: () {
                      setState(() {
                        widgetForBody = TeamDisplayView();
                      });
                      Navigator.pop(context);
                    }
                ),
                new ListTile(
                    title: new Text("Teams"),
                    leading: new Icon(Icons.people),
                    onTap: () {
                      setState(() {
                        widgetForBody = TeamsDetailsView();
                      });
                      Navigator.pop(context);
                    }
                ),
                new ListTile(
                    title: new Text("Players"),
                    leading: new Icon(Icons.person),
                    onTap: () {
                      setState(() {
                        widgetForBody = PlayersDetailsView();
                      });
                      Navigator.pop(context);
                    }
                ),

//    android:icon="@drawable/ic_web_asset"
//    android:icon="@drawable/ic_menu_share"
//    android:icon="@drawable/ic_exit_to_app"
//    android:icon="@drawable/ic_add"
//    android:icon="@drawable/ic_menu_send"
                  Divider(),
                  new ListTile(
                  title: new Text("Log out"),
                  leading: new Icon(Icons.exit_to_app),
                  onTap: () {
                    User.get().clearUser();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {return LoginView();}));
                    }
                  ,
                ),
                new ListTile(
                  title: new Text("Cancel"),
                  leading: new Icon(Icons.cancel),
                  onTap: () => Navigator.pop(context),
                ),


              ],
            ),
          ),
          body: widgetForBody
      ),
    );
  }
}

