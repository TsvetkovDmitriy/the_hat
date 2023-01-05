import 'package:hat/data/data.dart';

class Api {
  Game game = Game();

  void startGame() {
    if (!game.gameStarted) {
      game.teamList.shuffle();
      game.teamList.forEach((element) {
        element.playersList.shuffle();
      });
      game.currentRound = 0;
      game.gameStarted = true;
    }
  }

  bool startRound() {
    if (!game.roundStarted) {
      if (game.currentRound < 3) {
        game.currentRound ++;
        game.currentRoundWordList.addAll(game.mainWordList);
        game.roundStarted = true;
        return true;
      } else {
        return false;
      }
    } return false;
  }

  void preStartTry() {
    game.currentTry = Try();
    game.currentTry.team = game.teamList[game.currentTurn];
    game.currentTry.player =
        game.currentTry.team.playersList[game.currentTry.team.currentTurn];
  }

  void startTry() {
    game.currentRoundWordList.shuffle();
    game.currentTry.currentWord = game.currentRoundWordList.last;
  }

  bool onWordOk() {
    game.currentTry.okWord.add(game.currentTry.currentWord);
    game.currentRoundWordList.remove(game.currentTry.currentWord);
    if (game.currentRoundWordList.isEmpty) {
      return false;
    } else {
      game.currentRoundWordList.shuffle();
      game.currentTry.currentWord = game.currentRoundWordList.last;
      return true;
    }
  }

  void toCheckTry() {}

  bool onWordNoOk() {
    game.currentTry.noOkWord.add(game.currentTry.currentWord);
    game.currentRoundWordList.remove(game.currentTry.currentWord);
    if (game.currentRoundWordList.isEmpty) {
      return false;
    } else {
      game.currentRoundWordList.shuffle();
      game.currentTry.currentWord = game.currentRoundWordList.last;
      return true;
    }
  }

  bool onTryEnd() {
    game.currentRoundWordList.addAll(game.currentTry.noOkWord);
    int changeScore =
        game.currentTry.okWord.length - game.currentTry.noOkWord.length;
    game.teamList[game.currentTurn].score =
        game.teamList[game.currentTurn].score + changeScore;
    game
        .teamList[game.currentTurn]
        .playersList[game.teamList[game.currentTurn].currentTurn]
        .personalScore = game
            .teamList[game.currentTurn]
            .playersList[game.teamList[game.currentTurn].currentTurn]
            .personalScore +
        changeScore;
    game.teamList[game.currentTurn].currentTurn++;
    if (game.teamList[game.currentTurn].currentTurn >=
        game.teamList[game.currentTurn].playersList.length) {
      game.teamList[game.currentTurn].currentTurn = 0;
    }
    game.currentTurn++;
    if (game.currentTurn >= game.teamList.length) {
      game.currentTurn = 0;
    }
    if (game.currentRoundWordList.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void roundEnd() {
    game.roundStarted = false;
}

  void addTeam(Team team) {
    game.teamList.add(team);
  }

  void removeTeam(Team team) {
    game.teamList.remove(team);
  }

  void addWord(String newWord) {
    game.mainWordList.add(newWord);
  }

  void removeWord(String newWord) {
    game.mainWordList.remove(newWord);
  }
}
