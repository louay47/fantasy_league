import 'package:fantasy_football/model/player.dart';
import 'package:fantasy_football/player_details_view.dart';
import 'package:fantasy_football/styles.dart';
import 'package:flutter/material.dart';


class SubView extends StatelessWidget {
  final Player player;
  final int index;

  const SubView({Key key, @required this.player, @required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return PlayerDetailsView(player);
              }));
            },
            child: Draggable<List<dynamic>>(
              maxSimultaneousDrags: 1,
              data: [player, index],
              feedback: Opacity(
                  opacity: 0.5,
                  child: Container(
                      color: Colors.redAccent,
                      height: 110.0,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Image.asset(
                              player.image,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          Container(
                            color: Colors.green,
                            child: Text(
                              player.firstName.substring(0, 1) +
                                  ". " +
                                  player.lastName,
                              textAlign: TextAlign.center,
                              style: Styles.playerLabel,
                              softWrap: false,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                          Container(
                            color: Colors.green,
                            child: Text(player.points.toString(),
                                textAlign: TextAlign.center,
                                style: Styles.playerLabel),
                          ),
                        ],
                      ))),
              childWhenDragging: Container(),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Image.asset(
                      player.image,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Container(
                    color: Colors.green,
                    child: Text(
                      player.firstName.substring(0, 1) + ". " + player.lastName,
                      textAlign: TextAlign.center,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  Container(
                    color: Colors.green,
                    child: Text(player.points.toString(),
                        textAlign: TextAlign.center),
                  ),
                ],
              ),
            )));
  }
}
