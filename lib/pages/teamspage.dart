import 'package:flutter/material.dart';
import 'package:hat/data/data.dart';
import 'package:hat/main.dart';
import 'package:hat/pages/playerspage.dart';
import 'package:hat/theme/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TeamsPage extends StatefulWidget {
  const TeamsPage({super.key});

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
          backgroundColor: AppColors.bg,
          elevation: 0,
          onTap: (index) {
            // api.game.teamList = [];
            // listTeamNamesController.forEach((element) {
            //   api.game.teamList.add(Team(name: element.text));
            // });
            // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            //   return PlayersPage();
            // }));
          },
          items: [
            BottomNavigationBarItem(
                icon: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
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
                    api.game.teamList = [];
                    listTeamNamesController.forEach((element) {
                      api.game.teamList.add(Team(name: element.text));
                    });
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return PlayersPage();
                    }));
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
                label: ''),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          highlightElevation: 0,
          elevation: 0,
          onPressed: () {
            api.game.teamList = [];
            listTeamNamesController.forEach((element) {
              api.game.teamList.add(Team(name: element.text));
            });
            print((api.game.teamList.length + 1).toString());
            String name =
                "Команда " + (api.game.teamList.length + 1).toString();
            api.game.teamList.add(Team(name: name));
            updateConrollers();
            setState(() {});
          },
          child: Image.asset('assets/plus.png'), //
        ),
        appBar: AppBar(
          leadingWidth: 70,
          //         iconTheme: IconThemeData(
          //   color: Colors.blue, //change your color here
          // ),
          leading: IconButton(
            // icon: Image.asset('assets/plus.png'),
            icon: SvgPicture.asset('assets/back_button.svg'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,
          // title: Text("Команды"),
          backgroundColor: AppColors.bg,
          // centerTitle: true,
        ),
        backgroundColor: AppColors.bg,
        body: Stack(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 5),
              child: Text('Создай команды', style: TextStyle(
                fontSize: 24,
                color: AppColors.pink,
                fontWeight: FontWeight.w700,
              ),),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 44),
              child: Text('Придумай названия', style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: ListView.builder(
                itemCount: api.game.teamList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: TextField(
                      controller: listTeamNamesController[index],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15.0))),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.pink, width: 2),
                        borderRadius:BorderRadius.all(Radius.circular(15))
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.blue, width: 2),
                        borderRadius:BorderRadius.all(Radius.circular(15))
                      )
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
