
import 'package:fantasy_football/model/team.dart';
import 'package:fantasy_football/model/user.dart';

class TeamLab {
  List<Team> _teams = List();
  static TeamLab _sTeamLab;

  static TeamLab get() {
    if (_sTeamLab == null) {
      throw "sTeamLab is null";
    }
    return _sTeamLab;
  }

  void addTeam(Team team) {
    User user = User.get();
    if (team.teamId == user.teamId) {
      user.team = team;
    }
    _sTeamLab.teams.add(team);
  }

  TeamLab();

  TeamLab.fromJson(List<dynamic> json) {
    _sTeamLab = TeamLab();
    print ("team lab");
    for (Map<String, dynamic> teamJson in json) {
      addTeam(Team.fromTeamsJson(teamJson));

    }
  }

  List<Team> get teams => _teams;

}
