import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hat/data/data.dart';
import 'package:hat/main.dart';
import 'package:hat/pages/gamepage.dart';
import 'package:hat/pages/teamspage.dart';
import 'package:hat/theme/colors.dart';

class WordsPage extends StatefulWidget {
  @override
  State<WordsPage> createState() => _WordsPageState();
}

class _WordsPageState extends State<WordsPage> {
  List<TextEditingController> listWordsController = [];
  int playerNumber = 0;
  int playerQuantity = 0;
  List<List<String>> listOfWords = [];

  updateConrollers() {
    listWordsController = [];
    listOfWords[playerNumber].forEach((element) {
      listWordsController.add(TextEditingController(text: element));
    });
  }

  @override
  void initState() {
    api.game.teamList.forEach((element) {
      playerQuantity = playerQuantity + element.playersList.length;
    });
    for (int i =0; i<playerQuantity; i ++) {
      listOfWords.add(["", "", "", "", "", "", "", "", "", ""]);
    }
    updateConrollers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            if (index ==0) {
              if (playerNumber > 0) {
                listOfWords[playerNumber] =[];
                listWordsController.forEach((element) {
                  listOfWords[playerNumber].add( element.text);
                });

                playerNumber =playerNumber -1 ;
                updateConrollers();
                setState(() {

                });
              }

            }else {

                listOfWords[playerNumber] =[];
                listWordsController.forEach((element) {
                  listOfWords[playerNumber].add( element.text);
                });
                if ((playerNumber +1) >= playerQuantity) {
                  api.game.mainWordList = [];
                  listOfWords.forEach((element) {
                    api.game.mainWordList.addAll(element);
                  });

                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
                    return GamePage();
                  }));
                  //TODO переход на игру

                } else {
                  playerNumber = playerNumber + 1;
                  updateConrollers();
                  setState(() {

                  });
                }

            }
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.next_plan),
                label: 'назад'),

            BottomNavigationBarItem(icon: Icon(Icons.next_plan),
                label: 'далее')
          ],
        ),

        appBar: AppBar(
          title: Text("Пишем слова (по 10шт)"),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        backgroundColor: AppColors.bg,
        body: ListView.builder(
          itemCount: listOfWords[playerNumber].length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                controller: listWordsController[index],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            );
          },
        ));
  }
}
