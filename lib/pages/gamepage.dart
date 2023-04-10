import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:hat/main.dart';
import 'package:hat/pages/startpage.dart';
import 'package:hat/theme/colors.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

enum _PageStates { prestart, process, end, raundend, finish }

class _GamePageState extends State<GamePage> {
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;
  CountdownTimerController? controller;
  _PageStates _pageState = _PageStates.prestart;

  void onEnd() {
    print('onEnd');
    _pageState = _PageStates.end;
    setState(() {});
  }

  void onStart() {
    print("Количество слов в шляпе " + api.game.currentRoundWordList.length.toString());
    int time = api.game.currentRound == 3 ? (30) : 60;
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * time;
    controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
    api.startTry();
    _pageState = _PageStates.process;
    setState(() {});
  }

  void onWordOK() {
    print('onWordOK');
    bool isStillWords = api.onWordOk();
    if (isStillWords) {
      setState(() {});
    } else {
      controller!.disposeTimer();
      onEnd();
    }
  }

  void onWordNoOK() {
    print('onWordNoOK');
    bool isStillWords = api.onWordNoOk();
    if (isStillWords) {
      setState(() {});
    } else {
      controller!.disposeTimer();
      onEnd();
    }
  }

  void changeWord(String word) {
    if (api.game.currentTry.okWord.contains(word)) {
      api.game.currentTry.okWord.remove(word);
      api.game.currentTry.noOkWord.add(word);
    } else if (api.game.currentTry.noOkWord.contains(word)) {
      api.game.currentTry.okWord.add(word);
      api.game.currentTry.noOkWord.remove(word);
    }
    setState(() {});
  }

  void onNext() {
    print('onNext');
    bool isStillWords = api.onTryEnd();
    if (isStillWords) {
      api.preStartTry();
      _pageState = _PageStates.prestart;
      setState(() {});
    } else {
      onRoundEnd();
    }
  }

  void onRoundEnd() {
    print('onRoundEnd');
    api.roundEnd();
    _pageState = _PageStates.raundend;
    setState(() {});
  }
   void newGame() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
      return StartPage();
    }));
   }
  void nextRound() {              //TODO Не работает переход на след. раунд!!!
    print("Количество слов в шляпе " + api.game.currentRoundWordList.length.toString());
    bool isStillRound = api.startRound();
    if (isStillRound) {
      api.preStartTry();
      _pageState = _PageStates.prestart;
      setState(() {});
    } else {
      _pageState = _PageStates.finish;
      setState(() {});
    }
  }

  @override
  void initState() {
    api.startGame();
    api.startRound();
    api.preStartTry();
    _pageState = _PageStates.prestart;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("state" + _pageState.name);
    List<Widget> results = [];
    String name = "";
    String teamName = "";
    if (_pageState == _PageStates.finish) {
      int score =0;
      int teamScore = 0;
      api.game.teamList.forEach((element) {
        if(element.score > teamScore) {
          teamName = element.name;
          teamScore = element.score;
        }
        element.playersList.forEach((player) {
          if (player.personalScore > score) {
            name = player.name;
            score = player.personalScore;
          }
        });
      });
    }
    if (_pageState == _PageStates.end) {
      api.game.currentTry.okWord.forEach((element) {
        results.add(
            ResultsButton(function: changeWord, text: element, isOk: true));
      });
      api.game.currentTry.noOkWord.forEach((element) {
        results.add(
            ResultsButton(function: changeWord, text: element, isOk: false));
      });
    } else if (_pageState == _PageStates.raundend) {
      api.game.teamList.forEach((element) {
        results.add(
          Text(element.name + " " + element.score.toString())
        );
      });
    }
    return Scaffold(
      // backgroundColor: AppColors.bg,
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff019AF6),
                Color(0xff51D3FE),
              ],
            )),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _pageState == _PageStates.prestart
                  ? Text(
                      "01-00",
                      style: TextStyle(fontSize: 105, color: AppColors.bg, fontWeight: FontWeight.w400),
                    )
                  : CountdownTimer(
                      controller: controller,
                      widgetBuilder:
                          (BuildContext context, CurrentRemainingTime? time) {
                        if (time == null) {
                          return Text(
                            "00-00",
                            style: TextStyle(
                                fontSize: 105, color: AppColors.bg, fontWeight: FontWeight.w400),
                          );
                        }
                        return Text(
                          ' ${time.min ?? "00"} - ${time.sec} ',
                          style: TextStyle(fontSize: 40, color: Colors.blue),
                        );
                      },
                    ),
              _pageState == _PageStates.finish
                  ?  Card(elevation: 20, child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(" Игра завершена \n Лучшая команда - $teamName \n Лучший игрок ${name}  ",),
                  ))
                  :  Card(
                elevation: 20.0,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      _pageState == _PageStates.raundend
                          ? Text("Промежуточные результаты")
                          : Text("Команда - ${api.game.currentTry.team.name}"),
                      _pageState == _PageStates.raundend
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: ListView(
                                children: results,
                              ))
                          : Text(api.game.currentTry.player.name),
                      _pageState == _PageStates.process
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                api.game.currentTry.currentWord,
                                style: TextStyle(fontSize: 30),
                              ),
                            )
                          : Container(),
                      _pageState == _PageStates.end
                          ? Text("Результаты:")
                          : Container(),
                      _pageState == _PageStates.end
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: ListView(
                                children: results,
                              ))
                          : Container()
                    ],
                  ),
                ),
              ),
              _pageState == _PageStates.prestart
                  ? ElevatedButton(
                      onPressed: onStart, child: const Text("Начать"))
                  : Container(),
              _pageState == _PageStates.process
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: onWordNoOK, child: const Text("Отложить")),
                        ElevatedButton(
                            onPressed: onWordOK, child: const Text("Угаданно"))
                      ],
                    )
                  : Container(),
              _pageState == _PageStates.end
                  ? ElevatedButton(onPressed: onNext, child: const Text("Далее"))
                  : Container(),
              _pageState == _PageStates.raundend
                  ? ElevatedButton(
                      onPressed: nextRound, child: const Text("Следующий раунд"))
                  : Container(),
              _pageState == _PageStates.finish
                  ? ElevatedButton(
                  onPressed: newGame, child: const Text("Новая игра"))
                  : Container(),
            ]),
      ),
    );
  }
}

class ResultsButton extends StatelessWidget {
  final String text;
  final bool isOk;
  final Function(String) function;

  const ResultsButton(
      {this.text = '', this.isOk = false, super.key, required this.function});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          function(text);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                  fontSize: 20, color: isOk ? Colors.white : Colors.red),
            ),
            Text(
              (isOk ? "  +1" : "  -1"),
              style: TextStyle(
                  fontSize: 24, color: isOk ? Colors.white : Colors.red),
            )
          ],
        ));
  }
}
