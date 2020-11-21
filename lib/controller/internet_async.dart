import 'package:fantasy_football/controller/player_lab.dart';
import 'package:fantasy_football/controller/player_update_lab.dart';
import 'package:fantasy_football/controller/team_lab.dart';
import 'package:fantasy_football/create_team_view.dart';
import 'package:fantasy_football/login_view.dart';
import 'package:fantasy_football/model/app_state.dart';
import 'package:fantasy_football/model/lastId.dart';
import 'package:fantasy_football/model/team.dart';
import 'package:fantasy_football/model/user.dart';
import 'package:fantasy_football/navigation_drawer.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';


import 'package:http/http.dart' as http;

class InternetAsync {


  Future<User> updatePlayerStats(context) async {
    String message = "";
    PlayerUpdateLab playerUpdateLab = new PlayerUpdateLab();
    // set up POST request arguments
    String url =
        'https://union.ic.ac.uk/acc/football/android_connect/set_stats.php';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = jsonEncode(playerUpdateLab);
    print(json);
    // make POST request
    http.Response response;
    try {
      response = await http.post(url, headers: headers, body: json);
      if (response.statusCode == 200) {
        message = response.body.toString();
        if (response.body.toString() != 'Failed to set stats for players') {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) {
                return NavigationDrawer();
              }));
        }
      } else {
        print(response.body);
        message = 'Cannot connect to server';
      }
    } catch (e) {
      message = 'Cannot connect to server123';
    }
    if (message != "") {
      final snackBar =
          SnackBar(content: Text(message), duration: Duration(seconds: 2));
      Scaffold.of(context).showSnackBar(snackBar);
    }
    return null;
  }

  Future<User> fetchUser(context, username, password) async {
    String message = "";
    http.Response response;

    try {

      response = await http.post(
          "http://192.168.1.6:4000/users/login",
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          body: {"name": username, "password": password}
              );
      if (response.statusCode == 200) {

        if (response.body.toString() != '"not found"') {
          // If the call to the server was successful, parse the JSON to get user data
          print(json.decode(response.body));
          Map userMap = jsonDecode(response.body);
          var user = User.fromJson(userMap );
          print(user.userId);

          fetchAppState(context);
          fetchPlayers(context);
        } else {
          message = 'Invalid username or password';
        }
      } else {
        message = 'Cannot connect to server';
      }
    } catch (e) {
      message = 'Cannot connect to serverr';
    }
    if (message != "") {
      final snackBar =
          SnackBar(content: Text(message), duration: Duration(seconds: 2));
      Scaffold.of(context).showSnackBar(snackBar);
    }
    return null;
  }

  //the last fetch has to build the navigation drawer
  fetchAppState(context) async {
    String message = "";
    http.Response response;
    try {
      response = await http.get(
          "https://union.ic.ac.uk/acc/football/android_connect/get_state.php");
      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON to get user data

        AppState.fromJson(json.decode(response.body)[0]);
      } else {
        message = 'Cannot fetch app state from servers';
      }
    } catch (e) {
      message = 'Cannot fetch app state from servers';
    }
    if (message != "") {
      final snackBar =
          SnackBar(content: Text(message), duration: Duration(seconds: 2));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  fetchPlayers(context) async {
    String message = "";
    http.Response response;
    try {
      response = await http.get(
          "http://192.168.1.6:4000/players"
          );
      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON to get user data
        PlayerLab.fromJson(json.decode(response.body));
        fetchTeams(context);
      } else {
        message = 'Cannot fetch players from servers';
      }
    } catch (e) {
      message = 'Cannot fetch players from serverss';
    }
    if (message != "") {
      final snackBar =
          SnackBar(content: Text(message), duration: Duration(seconds: 2));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  fetchTeams(context) async {
    String message = "";
    http.Response response;
    try {
      response = await http
          .get("http://192.168.1.6:4000/teams/select_all");
      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON to get teams data
        TeamLab.fromJson(json.decode(response.body));
        if (User.get().teamId == null) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) {

            return CreateTeamView();
          }));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return NavigationDrawer();
          }));
        }
      } else {
        message = 'Cannot fetch teams from servers';
      }
    } catch (e) {
      message = 'Cannot fetch teams from serverss';
    }
    if (message != "") {
      final snackBar =
          SnackBar(content: Text(message), duration: Duration(seconds: 2));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }


  Future addTeam(context, Team team) async {
    String message = "";
    http.Response response;

    try {

      var url = "http://192.168.1.6:4000/teams/add_team"; // iOS
      final http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode (<dynamic, dynamic>{
          "user_id" : User.get().userId,
          "name" : team.name,
          "owner" : team.owner,
          "def_num" : 4,
          "mid_num" : 4,
          "fwd_num" : 2,
          "goal_id" : int.parse(team.playerAt(0)),
          "player1_id" : int.parse(team.playerAt(1)),
          "player2_id" : int.parse(team.playerAt(2)),
          "player3_id" : int.parse(team.playerAt(3)),
          "player4_id" : int.parse(team.playerAt(4)),
          "player5_id" : int.parse(team.playerAt(5)),
          "player6_id" : int.parse(team.playerAt(6)),
          "player7_id" : int.parse(team.playerAt(7)),
          "player8_id" : int.parse(team.playerAt(8)),
          "player9_id" : int.parse(team.playerAt(9)),
          "player10_id" : int.parse(team.playerAt(10)),
          "sub_goal_id" : int.parse(team.playerAt(11)),
          "sub_player1_id" : int.parse(team.playerAt(12)),
          "sub_player2_id" : int.parse(team.playerAt(13)),
          "sub_player3_id" : int.parse(team.playerAt(14)),
          "sub_player4_id" : int.parse(team.playerAt(15))

        }),
      );

      if (response.statusCode == 200) {
        //get the teamId of the newly created team
        http.Response response1;
        try {
            response1 = await http.get("http://192.168.1.6:4000/teams/last_id");

          //team.teamId = int.parse(json.decode(response1.body)[0]["id"]) ;
            LastId.fromJson(json.decode(response1.body));
            int teamId = LastId.get().id;
          team.teamId = teamId;
          TeamLab.get().teams.add(team);
          User.get().teamId = teamId;
          User.get().team = team;
          message = response.body.toString();
          print (response1.body.toString());
            print (team.teamId);
          if (response1.statusCode == 200){

            http.Response response2 ;
            print (User.get().userId);
            response2 = await http.post("http://192.168.1.6:4000/teams/affecteteamauuser",
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: { "team_id": teamId.toString(), "user_id": User.get().userId.toString()}

            );
            if(response2.statusCode  == 200){
              print ("affected") ;
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return NavigationDrawer();
                  }));
            }

          }


        }catch (e){
          message = 'problem here';
        }

      } else {
        message = 'Could not add team, try again later';
      }
    } catch (e) {
      message = 'Could not add team, try again later';
    }
    if (message != "") {
      final snackBar =
      SnackBar(content: Text(message), duration: Duration(seconds: 2));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }
  /*Future addTeam(context, Team team) async {
    String message = "";
    http.Response response;
    try {

      print (User.get().userId.toString() + team.name + team.playerAt(1)) ;
      response = await http.post(
          "http://192.168.1.6:4000/teams/add_team",
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          body: {
            "user_id" : User.get().userId,
            "name" : team.name,
            "owner" : team.owner,
            "def_num" : 4,
            "mid_num" : 4,
            "fwd_num" : 2,
            "goal_id" : team.playerAt(0),
            "player1_id" : team.playerAt(1),
            "player2_id" : team.playerAt(2),
            "player3_id" : team.playerAt(3),
            "player4_id" : team.playerAt(4),
            "player5_id" : team.playerAt(5),
            "player6_id" : team.playerAt(6),
            "player7_id" : team.playerAt(7),
            "player8_id" : team.playerAt(8),
            "player9_id" : team.playerAt(9),
            "player10_id" : team.playerAt(10),
            "sub_goal_id" : team.playerAt(11),
            "sub_player1_id" : team.playerAt(12),
            "sub_player2_id" : team.playerAt(13),
            "sub_player3_id" : team.playerAt(14),
            "sub_player4_id" : team.playerAt(15)

          }
      );
      if (response.statusCode == 200) {
        //get the teamId of the newly created team
        http.Response response1;
        try {
          response1 = await http.get("http://192.168.1.6:4000/teams/last_id");

          int teamId =
          team.teamId = int.parse(json.decode(response.body)[0]['id']) ;
          team.teamId = teamId;
          TeamLab.get().teams.add(team);
          User.get().teamId = teamId;
          User.get().team = team;
          message = response.body.toString();
          if (response1.statusCode == 200){

            http.Response response2 ;
            response2 = await http.post("http://192.168.1.6:4000/teams/affecteteamauuser",
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: {"team_id": teamId, "user_id": User.get().userId}

            );
            print ("affected") ;
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return NavigationDrawer();
                }));
          }


        }catch (e){
          message = 'problem here';
        }

      } else {
        message = 'Could not add team, try again later';
      }
    } catch (e) {
      message = 'Could not add team, try again later';
    }
    if (message != "") {
      final snackBar =
      SnackBar(content: Text(message), duration: Duration(seconds: 2));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }*/

  addUser(context, String username, String email, String password) async {
    String message = "";
    http.Response response;
    try {
      response = await http.post(
          "http://192.168.1.6:4000/users/checkNameEmail",
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          body: {"name": username, "email" : email }
      );
      if (response.statusCode == 404) {
        // If the call to the server was successful, parse the JSON to get teams data
        if (response.body.toString() == 'not found') {
          addUserToDB(context, username, email, password);
        } else {
          message = response.body.toString();
        }
      } else {
        message = 'Cannot add user';
      }
    } catch (e) {
      message = 'Cannot add user';
    }
    if (message != "") {
      final snackBar =
          SnackBar(content: Text(message), duration: Duration(seconds: 2));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  addUserToDB(context, String username, String email, String password) async {
    String message = "";
    http.Response response;
    try {
      response = await http.post(
          "http://192.168.1.6:4000/users/register",
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          body: {"name": username, "email" : email , "password" : password}
      );
      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON to get teams data
        if (response.body.toString() == 'success') {
          message = "Click on the link in the confirmation email and log in";
          Navigator.pop(context);
        } else {
          message = response.body.toString();
        }
      } else {
        message = 'Cannot add user to db';
      }
    } catch (e) {
      message = 'Cannot add user to db';
    }
    if (message != "") {
      Flushbar(
        message: message,
        duration: Duration(seconds: 5),
      )..show(context);
    }
  }

  sendEmailResetPassword(context, String email) async {
    String message = "";
    http.Response response;
    try {
      response = await http.get(
          "https://union.ic.ac.uk/acc/football/android_connect/send_email.php?email=" +
              email);
      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON to get teams data
        if (response.body.toString() == 'success') {
          message = 'Check your email for a reset code';
        } else {
          message = response.body.toString();
        }
      } else {
        message = 'Cannot send email to reset password, try again later';
      }
    } catch (e) {
      message = 'Cannot send email to reset password,, try again later';
    }
    if (message != "") {
      final snackBar =
          SnackBar(content: Text(message), duration: Duration(seconds: 2));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }
  

}
