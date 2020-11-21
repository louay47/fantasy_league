import 'dart:convert';

import 'package:fantasy_football/model/team.dart';

class User {
  int _userId;
  int _teamId;
  String _username;
  int _adminedTeam;
  bool _isSuperAdmin;
  static User _sUser;
  Team _team;

  User(this._userId, this._teamId, this._username);

  User.fromJson(Map<String, dynamic> json )
  { _userId = json['id'] ;
    _teamId = json['team_id'];
    _username = json['name'];
    create(_userId, _teamId , _username);
    print("here");
    }
  Map<String, dynamic> toJson() =>
      {
        'id': _userId,
        'team_id' : _teamId,
        'name' : _username
      };

  static User get() {
    if (_sUser == null) {
      throw "User is null";
    }
    return _sUser;
  }

  static void create(int userId, int teamId, String username) {
    if (_sUser == null) {
      _sUser = new User(userId, teamId, username);
      print(_sUser._username);
    }
  }



  void clearUser() {
    _sUser = null;
  }

  int get userId => _userId;

  int get teamId => _teamId;

  String get username => _username;

  int get adminedTeam => _adminedTeam;

  bool get isSuperAdmin => _isSuperAdmin;

  Team get team => _team;

  set team(Team value) {
    _team = value;
  }

  set teamId(int value) {
    _teamId = value;
  }


}