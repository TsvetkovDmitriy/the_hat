import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    for (int i = 0; i < playerQuantity; i++) {
      listOfWords.add(["", "", "", "", "", "", "", "", "", ""]);
    }
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
            //   if (playerNumber > 0) {
            //     listOfWords[playerNumber] = [];
            //     listWordsController.forEach((element) {
            //       listOfWords[playerNumber].add(element.text);
            //     });
            //
            //     playerNumber = playerNumber - 1;
            //     updateConrollers();
            //     setState(() {});
            //   }
            // } else {
            //   listOfWords[playerNumber] = [];
            //   listWordsController.forEach((element) {
            //     listOfWords[playerNumber].add(element.text);
            //   });
            //   if ((playerNumber + 1) >= playerQuantity) {
            //     api.game.mainWordList = [];
            //     listOfWords.forEach((element) {
            //       api.game.mainWordList.addAll(element);
            //     });
            //
            //     Navigator.of(context).pushReplacement(
            //         MaterialPageRoute(builder: (BuildContext context) {
            //       return GamePage();
            //     }));
            //     //TODO переход на игру
            //   } else {
            //     playerNumber = playerNumber + 1;
            //     updateConrollers();
            //     setState(() {});
            //   }
            // }
          },
          items: [
            BottomNavigationBarItem(
                icon: ElevatedButton(
                  onPressed: () {
                    if (playerNumber > 0) {
                      listOfWords[playerNumber] = [];
                      listWordsController.forEach((element) {
                        listOfWords[playerNumber].add(element.text);
                      });

                      playerNumber = playerNumber - 1;
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
                    listOfWords[playerNumber] = [];
                    listWordsController.forEach((element) {
                      listOfWords[playerNumber].add(element.text);
                    });
                    if ((playerNumber + 1) >= playerQuantity) {
                      api.game.mainWordList = [];
                      listOfWords.forEach((element) {
                        api.game.mainWordList.addAll(element);
                      });

                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return GamePage();
                      }));
                    } else {
                      playerNumber = playerNumber + 1;
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
        appBar: AppBar(
          // title: Text("Пишем слова (по 10шт)"),
          leadingWidth: 70,
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
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 5),
              child: Text('Добавь слова', style: TextStyle(
                fontSize: 24,
                color: AppColors.pink,
                fontWeight: FontWeight.w700,
              ),),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 44),
              child: Text('Каждый игрок пишет по 10 слов и жмёт "Далее"', style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: ListView.builder(
                itemCount: listOfWords[playerNumber].length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: TextField(
                      cursorColor: AppColors.blue,
                      cursorWidth: 1.5,
                      maxLength: 64,
                      controller: listWordsController[index],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15.0))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.pink, width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.blue, width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(15))),
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
