import 'package:fantasy_football/controller/player_lab.dart';
import 'package:fantasy_football/model/player.dart';

class Team {
   int _teamId;
   String _name;
   String _owner;
   double _price =0.0;
   int _points;
   int _pointsWeek;
   int _defNum;
   int _midNum;
   int _fwdNum;
   List<Player> _players = new List();


   int goalId;
   int player1Id;
   int player2Id;
   int player3Id;
   int player4Id;
   int player5Id;
   int player6Id;
   int player7Id;
   int player8Id;
   int player9Id;
   int player10Id;
   int subGoalId;
   int subPlayer1Id;
   int subPlayer2Id;
   int subPlayer3Id;
   int subPlayer4Id;




   Team(this._teamId, this._name, this._owner, this._price, this._points, this._pointsWeek,
       this._defNum, this._midNum, this._fwdNum, int goalId, int player1Id,
       int player2Id, int player3Id, int player4Id, int player5Id,
       int player6Id, int player7Id, int player8Id, int player9Id,
       int player10Id, int subGoalId, int sub1Id, int sub2Id, int sub3Id,
       int sub4Id) {
     PlayerLab playerLab = PlayerLab.get();
     _players.add(playerLab.getPlayer(goalId));
     _players.add(playerLab.getPlayer(player1Id));
     _players.add(playerLab.getPlayer(player2Id));
     _players.add(playerLab.getPlayer(player3Id));
     _players.add(playerLab.getPlayer(player4Id));
     _players.add(playerLab.getPlayer(player5Id));
     _players.add(playerLab.getPlayer(player6Id));
     _players.add(playerLab.getPlayer(player7Id));
     _players.add(playerLab.getPlayer(player8Id));
     _players.add(playerLab.getPlayer(player9Id));
     _players.add(playerLab.getPlayer(player10Id));
     _players.add(playerLab.getPlayer(subGoalId));
     _players.add(playerLab.getPlayer(sub1Id));
     _players.add(playerLab.getPlayer(sub2Id));
     _players.add(playerLab.getPlayer(sub3Id));
     _players.add(playerLab.getPlayer(sub4Id));
   }

   /*factory Team.fromJson(Map<String, dynamic> json, int teamId) {

     return Team(teamId, json['name'], json['owner'], double.parse(json['price']), int.parse(json['points']),
         int.parse(json['points_week']), int.parse(json['def_num']), int.parse(json['mid_num']), int.parse(json['fwd_num']),
         int.parse(json['goal_id']), int.parse(json['player1_id']), int.parse(json['player2_id']), int.parse(json['player3_id']),
         int.parse(json['player4_id']), int.parse(json['player5_id']), int.parse(json['player6_id']), int.parse(json['player7_id']),
         int.parse(json['player8_id']), int.parse(json['player9_id']), int.parse(json['player10_id']), int.parse(json['sub_goal_id']),
         int.parse(json['sub_player1_id']), int.parse(json['sub_player2_id']), int.parse(json['sub_player3_id']),int.parse(json['sub_player4_id']));
   }*/

   //the players are from selected list are rearranged to fit the team sturcture
   Team.fromSelectedList(List<Player> players, this._name, this._owner, this._price) :
         _teamId = 0, _points = 0, _pointsWeek = 0, _defNum = 3, _midNum = 4, _fwdNum = 3 {
     print ("affect players to team"+players[0].fullName) ;
     _players.add(players[0]);
     _players.add(players[2]);
     _players.add(players[3]);
     _players.add(players[4]);
     _players.add(players[7]);
     _players.add(players[8]);
     _players.add(players[9]);
     _players.add(players[10]);
     _players.add(players[12]);
     _players.add(players[13]);
     _players.add(players[14]);
     _players.add(players[1]);
     _players.add(players[15]);
     _players.add(players[11]);
     _players.add(players[5]);
     _players.add(players[6]);
   }

    /*factory Team.fromTeamsJson(Map<String, dynamic> json) {
     print ("team reach");
     return Team(int.parse(json['id']), json['name'], json['owner'], 0.0, int.parse(json['points']),
         int.parse(json['points_week']), int.parse(json['def_num']), int.parse(json['mid_num']), int.parse(json['fwd_num']),
         int.parse(json['goal_id']), int.parse(json['player1_id']), int.parse(json['player2_id']), int.parse(json['player3_id']),
         int.parse(json['player4_id']), int.parse(json['player5_id']), int.parse(json['player6_id']), int.parse(json['player7_id']),
         int.parse(json['player8_id']), int.parse(json['player9_id']), int.parse(json['player10_id']), int.parse(json['sub_goal_id']),
         int.parse(json['sub_player1_id']), int.parse(json['sub_player2_id']), int.parse(json['sub_player3_id']),int.parse(json['sub_player4_id']));
   }*/

   Team.fromTeamsJson(Map<String, dynamic> json) {

     print("Parse team");
     _teamId = json['id'];

     _name = json['name'];
     _owner = json['owner'];

     _points = json['points'];
     _pointsWeek = json['points_week'];
     _defNum = json['def_num'];
     _midNum = json['mid_num'];
     _fwdNum = json['fwd_num'];
     goalId = json['goal_id'];
     player1Id = json['player1_id'];
     player2Id = json['player2_id'];
     player3Id = json['player3_id'];
     player4Id = json['player4_id'];
     player5Id = json['player5_id'];
     player6Id = json['player6_id'];
     player7Id = json['player7_id'];
     player8Id = json['player8_id'];
     player9Id = json['player9_id'];
     player10Id = json['player10_id'];
     subGoalId = json['sub_goal_id'];
     subPlayer1Id = json['sub_player1_id'];
     subPlayer2Id = json['sub_player2_id'];
     subPlayer3Id = json['sub_player3_id'];
     subPlayer4Id = json['sub_player4_id'];
   }

   Map<String, dynamic> toJson() {
     final Map<String, dynamic> data = new Map<String, dynamic>();
     data['id'] = this._teamId;

     data['name'] = this._name;
     data['owner'] = this._owner;

     data['points'] = this._points;
     data['points_week'] = this._pointsWeek;
     data['def_num'] = this._defNum;
     data['mid_num'] = this._midNum;
     data['fwd_num'] = this._fwdNum;
     data['goal_id'] = this.goalId;
     data['player1_id'] = this.player1Id;
     data['player2_id'] = this.player2Id;
     data['player3_id'] = this.player3Id;
     data['player4_id'] = this.player4Id;
     data['player5_id'] = this.player5Id;
     data['player6_id'] = this.player6Id;
     data['player7_id'] = this.player7Id;
     data['player8_id'] = this.player8Id;
     data['player9_id'] = this.player9Id;
     data['player10_id'] = this.player10Id;
     data['sub_goal_id'] = this.subGoalId;
     data['sub_player1_id'] = this.subPlayer1Id;
     data['sub_player2_id'] = this.subPlayer2Id;
     data['sub_player3_id'] = this.subPlayer3Id;
     data['sub_player4_id'] = this.subPlayer4Id;
     return data;
   }
   int get fwdNum => _fwdNum;

   int get midNum => _midNum;

   int get defNum => _defNum;

   int get pointsWeek => _pointsWeek;

   int get points => _points;

   double get price => _price;

   String get owner => _owner;

   String get name => _name;

   int get teamId => _teamId;

   set teamId(int value) {
     _teamId = value;
   }

   String playerAt (int index) => players[index].playerID.toString();

   List<Player> get players => _players;

   set fwdNum(int value) {
     _fwdNum = value;
   }

   set midNum(int value) {
     _midNum = value;
   }

   set defNum(int value) {
     _defNum = value;
   }

   shiftPlayersAndInsert(delIndex, insertIndex, player) {
     _players.removeAt(delIndex);
     _players.insert(insertIndex, player);
   }

   int getCurrentWeeklyPoints() {
     int currentWeeklyPoints = 0;
     for (Player player in players) {
       currentWeeklyPoints+=player.pointsWeek;
     }
     return currentWeeklyPoints;
   }

}