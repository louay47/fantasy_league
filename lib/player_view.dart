import 'package:fantasy_football/model/player.dart';
import 'package:fantasy_football/model/team.dart';
import 'package:fantasy_football/model/user.dart';
import 'package:fantasy_football/player_details_view.dart';
import 'package:flutter/material.dart';

class PlayerView extends StatefulWidget {
  final Function updateState;
  final Player player;
  final int index;

  PlayerView(
      {Key key,
      @required this.player,
      @required this.index,
      @required this.updateState})
      : super(key: key);

  @override
  _PlayerViewState createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  Team team;

  @override
  void initState() {
    super.initState();
    team = User.get().team;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return PlayerDetailsView(widget.player);
                  }));
            },
            child: DragTarget<List<dynamic>>(
            builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              final hovered = accepted.length > 0;
              return Container(
                  color: hovered ? Colors.green : Color(0x00000000),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Image.asset(
                          widget.player.image,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Container(
                        color: Colors.green,
                        child: Text(
                          widget.player.firstName.substring(0, 1) +
                              ". " +
                              widget.player.lastName,
                          textAlign: TextAlign.center,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      Container(
                        color: Colors.green,
                        child: Text(
                            widget.player.points.toString() +
                                "|" +
                                widget.player.pointsWeek.toString(),
                            textAlign: TextAlign.center),
                      ),
                    ],
                  ));
            },
            onWillAccept: (value) {
              if (value[0].position == widget.player.position) return true;
              switch (widget.player.position) {
                case "Goalkeeper":
                  {
                    return false;
                  }
                  break;
                case "Defender":
                  {
                    if (team.defNum <= 3) return false;
                  }
                  break;

                case "Midfielder":
                  {
                    if (team.midNum <= 3) return false;
                  }
                  break;

                case "Attacker":
                  {
                    if (team.fwdNum <= 2) return false;
                  }
                  break;
              }
              switch (value[0].position) {
                case "Goalkeeper":
                  {
                    return false;
                  }
                case "Defender":
                  {
                    if (team.defNum >= 5) return false;
                  }
                  break;

                case "Midfielder":
                  {
                    if (team.midNum >= 5) return false;
                  }
                  break;

                case "Attacker":
                  {
                    if (team.fwdNum >= 3) return false;
                  }
                  break;
              }
              return true;
            },
            onAccept: (value) {
              int insert = 0;
              //handles repositioning of players
              if (value[0].position != widget.player.position) {
                switch (value[0].position) {
                  case "Defender":
                    insert = team.defNum;
                    team.defNum++;
                    break;
                  case "Midfielder":
                    insert = team.defNum + team.midNum;
                    team.midNum++;
                    break;
                  case "Attacker":
                    insert = 10;
                    team.fwdNum++;
                    break;
                }
                switch (widget.player.position) {
                  case "Defender":
                    team.defNum--;
                    break;
                  case "Midfielder":
                    team.midNum--;
                    break;
                  case "Attacker":
                    team.fwdNum--;
                    break;
                }
                team.shiftPlayersAndInsert(widget.index, insert, value[0]);
              } else {
                team.players[widget.index] = value[0];
              }
              team.players[value[1]] = widget.player;

              //need to redraw all effected elements
              widget.updateState();
            },
          ),
        ));
  }
}
