import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hat/data/data.dart';
import 'package:hat/main.dart';
import 'package:hat/pages/teamspage.dart';
import 'package:hat/pages/wordspage.dart';
import 'package:hat/theme/colors.dart';

class PlayersPage extends StatefulWidget {
  const PlayersPage({super.key});

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
          backgroundColor: AppColors.bg,
          elevation: 0,
          onTap: (index) {
            // if (index == 0) {
            //   if (teamNumber > 0) {
            //     api.game.teamList[teamNumber].playersList = [];
            //     listTeamNamesController.forEach((element) {
            //       api.game.teamList[teamNumber].playersList
            //           .add(Player(name: element.text));
            //     });
            //
            //     teamNumber = teamNumber - 1;
            //     updateConrollers();
            //     setState(() {});
            //   }
            // } else {
            //   api.game.teamList[teamNumber].playersList = [];
            //   listTeamNamesController.forEach((element) {
            //     api.game.teamList[teamNumber].playersList
            //         .add(Player(name: element.text));
            //   });
            //   if ((teamNumber + 1) >= api.game.teamList.length) {
            //     Navigator.of(context)
            //         .push(MaterialPageRoute(builder: (BuildContext context) {
            //       return WordsPage();
            //     }));
            //   } else {
            //     teamNumber = teamNumber + 1;
            //     updateConrollers();
            //     setState(() {});
            //   }
            // }
          },
          items: [
            BottomNavigationBarItem(
                icon: ElevatedButton(
                  onPressed: () {
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
                  },
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(AppColors.bg),
                      padding: MaterialStateProperty.all(const EdgeInsets.only(
                          left: 60, top: 15, right: 60, bottom: 15)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: const BorderSide(color: AppColors.blue)))),
                  child: const Text(
                    'Назад',
                    style: TextStyle(
                        color: AppColors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: ElevatedButton(
                  onPressed: () {
                    api.game.teamList[teamNumber].playersList = [];
                    listTeamNamesController.forEach((element) {
                      api.game.teamList[teamNumber].playersList
                          .add(Player(name: element.text));
                    });
                    if ((teamNumber + 1) >= api.game.teamList.length) {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return WordsPage();
                      }));
                    } else {
                      teamNumber = teamNumber + 1;
                      updateConrollers();
                      setState(() {});
                    }
                  },
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.blue),
                      padding: MaterialStateProperty.all(const EdgeInsets.only(
                          left: 60, top: 15, right: 60, bottom: 15)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: const BorderSide(color: AppColors.blue)))),
                  child: const Text(
                    'Далее',
                    style: TextStyle(
                        color: AppColors.bg,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                label: '')
          ],
        ),
        floatingActionButton: FloatingActionButton(
          highlightElevation: 0,
          elevation: 0,
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
          leadingWidth: 70,
          // title: Text(api.game.teamList[teamNumber].name,
          // style: const TextStyle(color: AppColors.pink),),
          leading: IconButton(
            icon: SvgPicture.asset('assets/back_button.svg'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,
          backgroundColor: AppColors.bg,
        ),
        backgroundColor: AppColors.bg,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 5),
              child: Text(
                api.game.teamList[teamNumber].name,
                style: const TextStyle(
                  fontSize: 24,
                  color: AppColors.pink,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 44),
              child: Text(
                'Запишите имена игроков команды',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: ListView.builder(
                itemCount: api.game.teamList[teamNumber].playersList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: TextField(
                      controller: listTeamNamesController[index],
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.pink, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.blue, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)))),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
