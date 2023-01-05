import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hat/data/data.dart';
import 'package:hat/main.dart';
import 'package:hat/pages/playerspage.dart';
import 'package:hat/theme/colors.dart';

class TeamsPage extends StatefulWidget {
  @override
  State<TeamsPage> createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  List<TextEditingController> listTeamNamesController = [];

  updateConrollers() {
    listTeamNamesController = [];
    api.game.teamList.forEach((element) {
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
            api.game.teamList =[];
            listTeamNamesController.forEach((element) {
              api.game.teamList.add( Team(name: element.text));
            });
            Navigator.of(context).push( MaterialPageRoute(builder: ( context) {
              return PlayersPage ();
            }));
          },
          items: [  BottomNavigationBarItem(icon: Icon(Icons.next_plan),
              label: 'назад'),

            BottomNavigationBarItem(icon: Icon(Icons.next_plan),
                label: 'далее')],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            api.game.teamList =[];
            listTeamNamesController.forEach((element) {
              api.game.teamList.add( Team(name: element.text));
            });
            print((api.game.teamList.length + 1).toString());
            String name =
                "Команда " + (api.game.teamList.length + 1).toString();
            api.game.teamList.add(Team(name: name));
            updateConrollers();
            setState(() {});
          },
          child: Image.asset('assets/plus.png'),  // 
        ),
        appBar: AppBar(
          title: Text("Команды"),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        backgroundColor: AppColors.bg,
        body: ListView.builder(
          itemCount: api.game.teamList.length,
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
