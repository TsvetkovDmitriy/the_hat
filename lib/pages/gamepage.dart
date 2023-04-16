import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:hat/main.dart';
import 'package:hat/pages/startpage.dart';
import 'package:hat/theme/colors.dart';
import 'package:hat/theme/text_styles.dart';

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
    print("Количество слов в шляпе " +
        api.game.currentRoundWordList.length.toString());
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
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
      return StartPage();
    }));
  }

  void nextRound() {
    print("Количество слов в шляпе " +
        api.game.currentRoundWordList.length.toString());
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
      int score = 0;
      int teamScore = 0;
      api.game.teamList.forEach((element) {
        if (element.score > teamScore) {
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
        results.add(Text(element.name + " " + element.score.toString()));
      });
    }

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      // backgroundColor: AppColors.bg,
      body: Container(
        width: width,
        height: height,
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
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                height: 70,
              ),
              _pageState == _PageStates.finish
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        Column(
                          children: [
                            const Text(
                              " Игра завершена",
                              style: TextStyle(fontSize: 32,
                                  color: AppColors.bg,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 60,),
                            Container(
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(19)),
                                  color: AppColors.paleBlue,
                                ),
                                // elevation: 0,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 30),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      // const Text(
                                      //   " Игра завершена",
                                      //   style: TextStyle(fontSize: 32,
                                      //   color: AppColors.bg,
                                      //   fontWeight: FontWeight.w700),
                                      // ),
                                      const SizedBox(height: 10,),
                                      const Text('Победила команда:',
                                        style: TextStyle(fontSize: 16,
                                            color: AppColors.bg,
                                            fontWeight: FontWeight.w500),),
                                      const SizedBox(height: 10,),
                                      Text('$teamName',
                                        style: const TextStyle(fontSize: 24,
                                            color: AppColors.bg,
                                            fontWeight: FontWeight.w700),),
                                      const SizedBox(height: 30,),
                                      const Text('Лучший игрок:',
                                        style: TextStyle(fontSize: 16,
                                            color: AppColors.bg,
                                            fontWeight: FontWeight.w500),),
                                      SizedBox(height: 10,),
                                      Text('${name}',
                                        style: const TextStyle(fontSize: 24,
                                            color: AppColors.bg,
                                            fontWeight: FontWeight.w700),)
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ],
                    )
                  : Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(19)),
                        color: AppColors.paleBlue,
                      ),
                      // shape: const RoundedRectangleBorder(
                      //   side: BorderSide(
                      //     color: Color.fromARGB(51, 255, 255, 255),
                      //   ),
                      //   borderRadius: BorderRadius.all(Radius.circular(19)),
                      // ),

                      // width: 340,
                      // height: 80,
                      // elevation: 0,
                      child: SizedBox(
                        width: 340,
                        height: 90,
                        child: Column(
                          children: [
                            _pageState == _PageStates.raundend
                                ? Column(
                                    children: const [
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        "Раунд окончен!",
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.bg,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Промежуточные результаты:",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.bg,
                                        ),
                                      )
                                    ],
                                  )
                                : Column(
                                    children: [
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      const Text(
                                        "Команда",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.bg,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        api.game.currentTry.team.name,
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.bg,
                                        ),
                                      )
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ),
              _pageState == _PageStates.raundend
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: ListView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 100),
                        children: results,
                      ))
                  : Column(
                      children: [
                        _pageState == _PageStates.finish
                            ? const SizedBox(
                                height: 200,
                              )
                            : Padding(
                                padding: const EdgeInsets.only(top: 60),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'игрок',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.bg,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(api.game.currentTry.player.name,
                                        style: const TextStyle(
                                          fontSize: 31,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.bg,
                                        )),
                                    const SizedBox(
                                      height: 34,
                                    ),
                                    _pageState == _PageStates.prestart
                                        ? const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Text(
                                              'За отведённое время\nобъясните как можно больше слов',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.bg,
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                      ],
                    ),
              _pageState == _PageStates.process
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                          child: Text(
                            api.game.currentTry.currentWord,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.w600,
                                color: AppColors.bg),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    )
                  : Container(),
              _pageState == _PageStates.end
                  ? Column(
                      children: const [
                        Text(
                          "Результаты:",
                          style: TextStyle(
                            color: AppColors.bg,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    )
                  : Container(),
              _pageState == _PageStates.end
                  ? Container(
                      height: 400,
                      child: ListView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 0),
                        children: results,
                      ))
                  : Container(),
              _pageState == _PageStates.prestart
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 34,
                        ),
                        Text(
                          "01:00",
                          style: AppTextStyles.timer,
                        ),
                        const SizedBox(
                          height: 120,
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        _pageState == _PageStates.process
                            ? CountdownTimer(
                                controller: controller,
                                widgetBuilder: (BuildContext context,
                                    CurrentRemainingTime? time) {
                                  if (time == null) {
                                    return const Text(
                                      "00-00",
                                      style: TextStyle(
                                          fontSize: 105,
                                          color: AppColors.bg,
                                          fontWeight: FontWeight.w400),
                                    );
                                  }
                                  return Text(
                                    ' ${time.min ?? "00"}:${time.sec} ',
                                    style: const TextStyle(
                                        fontSize: 105, color: AppColors.bg),
                                  );
                                },
                              )
                            : Container(),
                      ],
                    ),
              _pageState == _PageStates.prestart
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: ElevatedButton(
                        onPressed: onStart,
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor:
                                MaterialStateProperty.all(AppColors.bg),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.only(
                                    left: 80, top: 17, right: 80, bottom: 17)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    side: const BorderSide(
                                        color: AppColors.bg)))),
                        child: Text(
                          "Начать",
                          style: AppTextStyles.blueButtom,
                        ),
                      ),
                    )
                  : Container(),
              _pageState == _PageStates.process
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 150,
                        ),
                        ElevatedButton(
                          onPressed: onWordNoOK,
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromRGBO(0, 0, 0, 0)),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.only(
                                      left: 40,
                                      top: 15,
                                      right: 40,
                                      bottom: 15)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: const BorderSide(
                                          color: AppColors.bg)))),
                          child: const Text(
                            'Отложить',
                            style: TextStyle(
                                color: AppColors.bg,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        ElevatedButton(
                          onPressed: onWordOK,
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor:
                                  MaterialStateProperty.all(AppColors.bg),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.only(
                                      left: 40,
                                      top: 15,
                                      right: 40,
                                      bottom: 15)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: const BorderSide(
                                          color: AppColors.bg)))),
                          child: const Text(
                            'Угадано',
                            style: TextStyle(
                                color: AppColors.blueButton,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    )
                  : Container(),
              _pageState == _PageStates.end
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: onNext,
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor:
                                  MaterialStateProperty.all(AppColors.bg),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.only(
                                      left: 80,
                                      top: 17,
                                      right: 80,
                                      bottom: 17)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: const BorderSide(
                                          color: AppColors.bg)))),
                          child: Text(
                            "Далее",
                            style: AppTextStyles.blueButtom,
                          ),
                        ),
                      ],
                    )
                  : Container(),
              _pageState == _PageStates.raundend
                  ? ElevatedButton(
                      onPressed: nextRound,
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.bg),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.only(
                                  left: 80, top: 17, right: 80, bottom: 17)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side:
                                      const BorderSide(color: AppColors.bg)))),
                      child: Text(
                        "Следующий раунд",
                        style: AppTextStyles.blueButtom,
                      ))
                  : Container(),
              _pageState == _PageStates.finish
                  ? ElevatedButton(
                      onPressed: newGame,
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.bg),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.only(
                                  left: 80, top: 17, right: 80, bottom: 17)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side:
                                      const BorderSide(color: AppColors.bg)))),
                      child: Text(
                        "Новая игра",
                        style: AppTextStyles.blueButtom,
                      ),
                    )
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
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(AppColors.paleBlue),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
              side: const BorderSide(color: AppColors.blue)))
      ),
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
              (isOk ? "  1" : "  -1"),
              style: TextStyle(
                  fontSize: 24, color: isOk ? Colors.white : Colors.red),
            )
          ],
        ));
  }
}
