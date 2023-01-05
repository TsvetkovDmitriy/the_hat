import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hat/data/data.dart';
import 'package:hat/main.dart';
import 'package:hat/pages/teamspage.dart';
import 'package:hat/pages/wordspage.dart';
import 'package:hat/theme/colors.dart';

class PlayersPage extends StatefulWidget {
  @override
  State<PlayersPage> createState() => _PlayersPageState();
}

class _PlayersPageState extends State<PlayersPage> {
  List<TextEditingController> listTeamNamesController = [];
  int teamNumber = 0;

  updateConrollers() {
    listTeamNamesController = [];
    api.game.teamList[teamNumber].playersList.forEach((element) {
      listTeamNamesController.add(TextEditingController(text: element.name));
    });
  }

  @override
  void initState() {
    updateConrollers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            if (index == 0) {
              if (teamNumber > 0) {
                api.game.teamList[teamNumber].playersList = [];
                listTeamNamesController.forEach((element) {
                  api.game.teamList[teamNumber].playersList
                      .add(Player(name: element.text));
                });

                teamNumber = teamNumber - 1;
                updateConrollers();
                setState(() {});
              }
            } else {

              api.game.teamList[teamNumber].playersList = [];
                listTeamNamesController.forEach((element) {
                  api.game.teamList[teamNumber].playersList
                      .add(Player(name: element.text));
                });
                if ( (teamNumber +1) >= api.game.teamList.length) {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return WordsPage();
                      }));
                } else {
                  teamNumber = teamNumber + 1;
                  updateConrollers();
                  setState(() {});
                }

            }
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.next_plan), label: 'назад'),
            BottomNavigationBarItem(icon: Icon(Icons.next_plan), label: 'далее')
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            api.game.teamList[teamNumber].playersList = [];
            listTeamNamesController.forEach((element) {
              api.game.teamList[teamNumber].playersList
                  .add(Player(name: element.text));
            });
            String name = "Игрок " +
                (api.game.teamList[teamNumber].playersList.length + 1)
                    .toString();
            api.game.teamList[teamNumber].playersList.add(Player(name: name));
            updateConrollers();
            setState(() {});
          },
          child: Image.asset('assets/plus.png'),
        ),
        appBar: AppBar(
          title: Text(api.game.teamList[teamNumber].name),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        backgroundColor: AppColors.bg,
        body: ListView.builder(
          itemCount: api.game.teamList[teamNumber].playersList.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                controller: listTeamNamesController[index],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            );
          },
        ));
  }
}
